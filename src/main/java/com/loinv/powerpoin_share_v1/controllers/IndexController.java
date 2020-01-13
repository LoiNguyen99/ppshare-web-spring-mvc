/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.controllers;

import com.loinv.powerpoin_share_v1.entities.Category;
import com.loinv.powerpoin_share_v1.entities.Slide;
import com.loinv.powerpoin_share_v1.services.CategoryService;
import com.loinv.powerpoin_share_v1.services.SlideService;
import java.util.List;
import javax.servlet.ServletContext;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Loi Nguyen
 */
@Controller
@RequestMapping("/")
public class IndexController {

    private static final Logger LOGGER = Logger.getLogger(IndexController.class);
    
    @Autowired
    ServletContext context;
    @Autowired
    SlideService slideService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap model) {
        List<Slide> listNewSlide = (List<Slide>) context.getAttribute("newSlides");
        List<Slide> listHotSlide = (List<Slide>) context.getAttribute("hotSlides");
        List<Category> listCategory = (List<Category>) context.getAttribute("categories");
        try {
            if (listNewSlide == null) {
                listNewSlide = slideService.getNewestSlides();
                context.setAttribute("newSlides", listNewSlide);
            }
            if (listHotSlide == null) {
                listHotSlide = slideService.getHotestSlides();
                context.setAttribute("hotSlides", listHotSlide);
            }

            if (listCategory == null) {
                listCategory = categoryService.getListCategory(true);
                context.setAttribute("categories", listCategory);
            }
        } catch (Exception e) {
            LOGGER.error("Error: "+e.getMessage());
        }
        return "index";
    }
}
