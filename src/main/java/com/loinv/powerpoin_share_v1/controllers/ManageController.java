/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.loinv.powerpoin_share_v1.daos.SlideDAO;
import com.loinv.powerpoin_share_v1.entities.Category;
import com.loinv.powerpoin_share_v1.entities.Image;
import com.loinv.powerpoin_share_v1.entities.Slide;
import com.loinv.powerpoin_share_v1.entities.User;
import com.loinv.powerpoin_share_v1.services.CategoryService;
import com.loinv.powerpoin_share_v1.services.ImageService;
import com.loinv.powerpoin_share_v1.services.SlideService;
import com.loinv.powerpoin_share_v1.services.UserService;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Loi Nguyen
 */
@Controller
@RequestMapping("/manage")
public class ManageController {

    private static final String USER_ROLE = "usr";
    private static final String ADMIN_ROLE = "ad";

    private static final Logger LOGGER = Logger.getLogger(ManageController.class);

    private final String ACT_LIST = "list";
    private final String ACT_ADD = "add";
    private final String ACT_EDIT = "edit";

    @Autowired
    private SlideService slideService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ServletContext context;

    @RequestMapping(method = RequestMethod.GET)
    public String manage() {
        return "redirect:/manage/slide";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {

        HttpSession session = request.getSession();
        session.removeAttribute("admin");
        return "redirect:login";

    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request, @RequestParam(required = false) String userId, @RequestParam(required = false) String password) {
        if (userId != null && password != null) {
            User user = userService.checkLogin(userId, password);
            if (user != null) {
                if (user.getRole().getRoleId().equals(ADMIN_ROLE)) {
                    HttpSession session = request.getSession();
                    session = request.getSession();
                    session.setAttribute("admin", user);
                    return "redirect:/manage/slide";
                }
            }

        }
        return "login_admin";

    }

    @RequestMapping("/slide")
    public String slide(ModelMap model, HttpServletRequest request) {
        String action = request.getParameter("action");
        if (action == null) {
            action = ACT_LIST;
        }
        String formStatusString = request.getParameter("formStatus");
        boolean formStatus = true;
        if (formStatusString != null) {
            formStatus = Boolean.parseBoolean(formStatusString);
        }
        if (action.equalsIgnoreCase(ACT_LIST)) {
            String pageString = request.getParameter("page");
            if (pageString == null) {
                pageString = "1";
            }
            if (!pageString.matches("[0-9]{1,2}") || pageString.equals("0")) {
                pageString = "1";
            }
            int page = Integer.parseInt(pageString);
            List<Slide> list = slideService.getListSlide(page, formStatus);
            long numbersOfSlide = slideService.getNumbersOfslide(0);
            double numbersOfpage = Math.ceil(1.0 * numbersOfSlide / SlideDAO.PAGE_SIZE);
            model.addAttribute("page", page);
            model.addAttribute("numsOfPage", numbersOfpage);
            model.addAttribute("slides", list);
            model.addAttribute("action", action);
        } else if (action.equalsIgnoreCase(ACT_ADD)) {
            model.addAttribute("action", ACT_ADD);
            model.addAttribute("categories", categoryService.getListCategory(true));
            model.addAttribute("slide", new Slide());
        } else if (action.equalsIgnoreCase(ACT_EDIT)) {
            model.addAttribute("action", ACT_EDIT);
            model.addAttribute("categories", categoryService.getListCategory(true));
            String slideIdString = request.getParameter("slideId");
            int id = Integer.parseInt(slideIdString);
            Slide slide = slideService.getSlideById(id);
            model.addAttribute("slide", slide);
        }
        model.addAttribute("formStatus", formStatus);
        return "manage_slide";
    }

    @RequestMapping("/slide/insert")
    public String insertSlide(ModelMap model, @ModelAttribute("slide") Slide slide, @RequestParam("avatarFile") MultipartFile avatarFile,
            @RequestParam("slideFile") MultipartFile slideFile, @RequestParam("descriptionImgFile") List<MultipartFile> descriptionImgFiles,
            RedirectAttributes redirectAttributes) {

        try {
            int currentId = slideService.getCurrentId() + 1;

            String avatarPath = this.getFilePath(currentId, avatarFile);
            slide.setAvatarPath(avatarPath);
            this.transferFile(avatarPath, avatarFile);

            String filePath = this.getFilePath(currentId, slideFile);
            slide.setFilePath(filePath);
            this.transferFile(filePath, slideFile);

            slide.setStatus(true);
            slide.setDateCreate(new Date());
            slide.setSize((int) slideFile.getSize());

            slideService.insert(slide);

            for (int i = 0; i < descriptionImgFiles.size(); i++) {
                Image image = new Image();
                String imagePath = this.getFilePath(currentId, descriptionImgFiles.get(i));
                image.setImagePath(imagePath);
                image.setSlide(slide);
                this.transferFile(imagePath, descriptionImgFiles.get(i));
                imageService.insert(image);
            }
            redirectAttributes.addFlashAttribute("message", "Add successful!");
        } catch (Exception e) {
            LOGGER.error("Error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("message", "Add failed! - " + e.getMessage());
        } finally {
            updateSlideContext();
            return "redirect:/manage/slide?action=add";
        }
    }

    @RequestMapping("/slide/delete")
    public String deleteSlide(@RequestParam("slideId") int slideId) {
        if (slideService.deleteSlideById(slideId)) {
            updateSlideContext();
            return "redirect:/manage/slide";
        } else {
            return "error";
        }
    }

    @RequestMapping(value = "/slide/detail", method = RequestMethod.GET)
    @ResponseBody
    public String getSlideDetails(@RequestParam("id") int id) {
        Slide slide = slideService.getSlideById(id);
        ObjectMapper mapper = new ObjectMapper();
        String result = null;
        try {
            result = mapper.writeValueAsString(slide);
        } catch (JsonProcessingException ex) {
            LOGGER.error("Error: " + ex.getMessage());
        }
        return result;

    }

    @RequestMapping("/slide/edit")
    public String editSlide(ModelMap model, @ModelAttribute("slide") Slide slide, @RequestParam(required = false) MultipartFile avatarFile,
            @RequestParam(required = false) MultipartFile slideFile, @RequestParam("descriptionImgFile") List<MultipartFile> descriptionImgFiles,
            RedirectAttributes redirectAttributes) {

        try {

            if (!avatarFile.isEmpty()) {
                String avatarPath = this.getFilePath(slide.getSlideId(), avatarFile);
                deleteFromDisk(slide.getAvatarPath());
                this.transferFile(avatarPath, avatarFile);
                slide.setAvatarPath(avatarPath);
            }

            if (!slideFile.isEmpty()) {
                String filePath = this.getFilePath(slide.getSlideId(), slideFile);
                deleteFromDisk(slide.getFilePath());
                this.transferFile(filePath, slideFile);
                slide.setFilePath(filePath);
                slide.setSize((int) slideFile.getSize());

            }

            slide = slideService.updateSlide(slide);
            if (!descriptionImgFiles.get(0).isEmpty()) {
                for (int i = 0; i < descriptionImgFiles.size(); i++) {
                    Image image = new Image();
                    int currentId = imageService.getCurrentId();
                    String filename = currentId + descriptionImgFiles.get(i).getOriginalFilename();
                    String imagePath = this.getFilePath(slide.getSlideId(), filename);

                    image.setImagePath(imagePath);
                    image.setSlide(slide);
                    this.transferFile(imagePath, descriptionImgFiles.get(i));
                    imageService.insert(image);
                }
            }
            redirectAttributes.addFlashAttribute("slide", slide);
            redirectAttributes.addFlashAttribute("message", "Update successful!");
        } catch (Exception e) {
            LOGGER.error("Error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("message", "Update failed! - " + e.getMessage());
        } finally {
            updateSlideContext();
            return "redirect:/manage/slide?action=edit&slideId=" + slide.getSlideId();
        }
    }

    public String getFilePath(int currentId, MultipartFile file) {

        String path = "/files/s/" + currentId + "/" + file.getOriginalFilename();
        return path;
    }

    public String getFilePath(int currentId, String filename) {

        String path = "/files/s/" + currentId + "/" + filename;
        return path;
    }

    public void transferFile(String path, MultipartFile file) throws IOException {
        String realContext = context.getRealPath(path.replace("/files", ""));
        String contextPath = "ROOT";
        if (context.getContextPath().length() > 0) {
            contextPath = context.getContextPath().substring(1, context.getContextPath().length());
        }

        String realPath = realContext.replace(contextPath, "files");
        file.transferTo(new File(realPath));
    }

    public void updateSlideContext() {
        List<Slide> newSlide = slideService.getNewestSlides();
        context.setAttribute("newSlides", newSlide);
        List<Slide> hotSlide = slideService.getHotestSlides();
        context.setAttribute("hotSlides", hotSlide);
    }

    /* 
    *     ------------------Category
    *
    *
     */
    @RequestMapping("/category")
    public String category(ModelMap model, HttpServletRequest request) {
        String action = request.getParameter("action");
        String formStatusString = request.getParameter("formStatus");
        boolean formStatus = true;
        if (formStatusString != null) {
            formStatus = Boolean.parseBoolean(formStatusString);
        }
        if (action == null) {
            action = ACT_LIST;
        }
        if (action.equalsIgnoreCase(ACT_LIST)) {

            List<Category> list = categoryService.getListCategory(formStatus);
            model.addAttribute("categories", list);
            model.addAttribute("action", action);
        } else if (action.equalsIgnoreCase(ACT_ADD)) {
            model.addAttribute("action", ACT_ADD);
            model.addAttribute("category", new Category());
        } else if (action.equalsIgnoreCase(ACT_EDIT)) {
            model.addAttribute("action", ACT_EDIT);
            String idString = request.getParameter("categoryId");
            String categoryName = request.getParameter("categoryName");
            String statusString = request.getParameter("status");
            if (idString != null && categoryName != null && statusString != null) {
                int id = Integer.parseInt(idString);
                boolean status = Boolean.parseBoolean(statusString);
                Category category = new Category();
                category.setCategoryName(categoryName);
                category.setCategoryId(id);
                category.setStatus(status);
                model.addAttribute("category", category);
                model.addAttribute("action", ACT_EDIT);
            } else {
                return "redirect:/manage/category";
            }
        }
        model.addAttribute("formStatus", formStatus);
        return "manage_category";
    }

    @RequestMapping("/category/delete")
    public String deleteCategory(@RequestParam("categoryId") int categoryId) {
        if (categoryService.deleteCategoryById(categoryId)) {
            updateCategoryContext();
            return "redirect:/manage/category";
        } else {
            return "error";
        }
    }

    @RequestMapping("/category/insert")
    public String insertCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        category.setStatus(true);
        if (categoryService.insertCategory(category)) {
            redirectAttributes.addFlashAttribute("message", "Add successful!");
            updateCategoryContext();
        } else {

            redirectAttributes.addFlashAttribute("message", "Add failed!");
        }

        return "redirect:/manage/category?action=add";

    }

    @RequestMapping("/category/edit")
    public String editCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        category = categoryService.updateCategory(category);
        redirectAttributes.addFlashAttribute("message", "Update successful!");
        updateCategoryContext();
        return "redirect:/manage/category";

    }

    public void updateCategoryContext() {
        List<Category> listCateory = categoryService.getListCategory(true);
        context.setAttribute("categories", listCateory);
    }

    /*
    *
    * IMAGE
    *
     */
    @RequestMapping("/image/delete")
    @ResponseBody
    public String deleteImage(HttpServletRequest request) {

        String[] imageIdList = request.getParameterValues("imagesIdList[]");
        String result = null;
        try {

            String slideId = request.getParameter("slideId");
            if (imageIdList != null) {
                for (int i = 0; i < imageIdList.length; i++) {
                    int id = Integer.parseInt(imageIdList[i]);
                    String ImagePath = imageService.getImagePath(id).getImagePath();
                    if (deleteFromDisk(ImagePath)) {
                        imageService.delete(id);
                    }
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            List<Image> images = null;
            if (slideId != null) {
                images = imageService.getImagePathsBySlideId(Integer.parseInt(slideId));
            }
            if (images != null) {
                result = mapper.writeValueAsString(images);
            }
        } catch (Exception e) {
            LOGGER.error(e.getMessage());
        }

        return result;
    }

    public boolean deleteFromDisk(String filepath) {
        String realPath = context.getRealPath("/");

        filepath = filepath.replace("files/", "");
        String contextPath = "ROOT";
        if (context.getContextPath().length() > 0) {
            contextPath = context.getContextPath().substring(1, context.getContextPath().length());
        }
        realPath = realPath.replace(contextPath, "files");
        realPath = realPath + filepath;
        File file = new File(realPath);
        boolean result = file.delete();
        return result;
    }

}
