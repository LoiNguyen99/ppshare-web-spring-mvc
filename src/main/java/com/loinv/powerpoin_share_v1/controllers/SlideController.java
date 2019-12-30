/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.controllers;

import com.loinv.powerpoin_share_v1.entities.Category;
import com.loinv.powerpoin_share_v1.entities.Slide;
import com.loinv.powerpoin_share_v1.services.CategoryService;
import com.loinv.powerpoin_share_v1.services.ImageService;
import com.loinv.powerpoin_share_v1.services.SlideService;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Loi Nguyen
 */
@Controller
@RequestMapping("/trang-trinh-chieu")
public class SlideController {

    private final String ACT_LIST = "list";
    private final String ACT_ADD = "add";
    private final String ACT_EDIT = "edit";

    @Autowired
    private SlideService slideService;

    @Autowired
    private ImageService imageService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ServletContext context;

    @RequestMapping(method = RequestMethod.GET)
    public String redirectSlideList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String orderBy = request.getParameter("order");
        String category = request.getParameter("cat");

        if (orderBy != null && category == null) {
            return "redirect:/trang-trinh-chieu/tat-ca?order=" + orderBy;
        } else if (orderBy != null && category != null) {
            List<Category> list = (List<Category>) context.getAttribute("categories");
            String categoryName = "tat-ca";
            if (list != null) {
                for (int i = 0; i < list.size(); i++) {
                    if (Integer.parseInt(category) == list.get(i).getCategoryId()) {
                        categoryName = list.get(i).convertURL();
                    }
                }
            }
            return "redirect:/trang-trinh-chieu/" + categoryName + "?cat=" + category + "&order=" + orderBy;
        }

        return "redirect:/trang-trinh-chieu/tat-ca";
    }

    @RequestMapping("/{categoryName}")
    public String slideList(@PathVariable String categoryName, HttpServletRequest request, ModelMap model) {
        HashMap<String, String> orderList = new HashMap<>();
        orderList.put("1", "Mới nhất");
        orderList.put("2", "Cũ nhất");
        orderList.put("3", "Phổ biến");
        String category = request.getParameter("cat");
        String orderBy = request.getParameter("order");
        int categoryId = 0;
        if (category == null || !category.matches("[0-9]{1,}")) {
            categoryId = 0;
        } else {
            categoryId = Integer.parseInt(category);
        }
        if (orderBy == null) {
            orderBy = "1";
        }

        String pageString = request.getParameter("page");
        if (pageString == null) {
            pageString = "1";
        }
        if (!pageString.matches("[0-9]{1,2}") || pageString.equals("0")) {
            pageString = "1";
        }
        int page = Integer.parseInt(pageString);
        long numbersOfSlide = slideService.getNumbersOfslide(categoryId);
        double numbersOfpage = Math.ceil(1.0 * numbersOfSlide / 12);
        model.addAttribute("page", page);
        model.addAttribute("numsOfPage", numbersOfpage);

        List<Slide> slides = slideService.getListSlideByProperties(page, categoryId, orderBy);
        List<Category> list = (List<Category>) context.getAttribute("categories");
        String categoryNameTitle = "tất cả";
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                if (categoryId == list.get(i).getCategoryId()) {
                    categoryNameTitle = list.get(i).getCategoryName();
                }
            }
        }
        model.addAttribute("slides", slides);
        model.addAttribute("orders", orderList);
        model.addAttribute("title", categoryNameTitle);
        return "slide_list";
    }

    @RequestMapping("/test")
    public String test() {
//        List<Slide> list = slideService.getListSlideByProperties(1, 1, "old");
//        for (int i = 0; i < list.size(); i++) {
//            System.out.println("number: " + i);
//            System.out.println(list.get(i).getSlideName());
//            System.out.println(list.get(i).getAvatarPath());
//            System.out.println(list.get(i).getFilePath());
//            System.out.println("categpry id:" + list.get(i).getCategory().getCategoryId());
//        }
        return "error";
    }

    @RequestMapping(value = "/{id}/{slideName}")
    public String detail(@PathVariable("id") int id, ModelMap model) {
        Slide slide = slideService.getSlideById(id);
        List<Slide> relativeSlides = slideService.getRandomSlides();
        model.addAttribute("relative_slides", relativeSlides);
        model.addAttribute("slide", slide);
        return "slide_details";
    }
}
