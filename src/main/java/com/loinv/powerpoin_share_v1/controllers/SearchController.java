/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.controllers;

import com.loinv.powerpoin_share_v1.entities.Slide;
import com.loinv.powerpoin_share_v1.services.SlideService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
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
@RequestMapping("/search")
public class SearchController {

    @Autowired
    SlideService slideService;

    @RequestMapping(method = RequestMethod.GET)
    public String search(HttpServletRequest request, ModelMap model) {
        String searchValue = request.getParameter("searchValue");
        String pageString = request.getParameter("page");
        if (pageString == null) {
            pageString = "1";
        }
        if (!pageString.matches("[0-9]{1,2}") || pageString.equals("0")) {
            pageString = "1";
        }
        int page = Integer.parseInt(pageString);
        long numbersOfSlide = slideService.getNumbersOfsearch(searchValue);
        double numbersOfpage = Math.ceil(1.0 * numbersOfSlide / 12);
        if (numbersOfSlide <= 12) {
            page = 1;
        }
        model.addAttribute("page", page);
        model.addAttribute("numsOfPage", numbersOfpage);

        List<Slide> slides = slideService.search(searchValue,page);
        model.addAttribute("slides", slides);
        return "search";
    }

}
