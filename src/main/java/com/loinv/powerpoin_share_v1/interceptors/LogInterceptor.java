/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.interceptors;

import com.loinv.powerpoin_share_v1.entities.User;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 *
 * @author Loi Nguyen
 */
public class LogInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    ServletContext context;

    @Override
    public boolean preHandle(HttpServletRequest hsr, HttpServletResponse hsr1, Object o) throws Exception {
        HttpSession session = hsr.getSession();
        User user = (User) session.getAttribute("admin");
        if (user != null) {
            return true;
        } else {
            hsr1.sendRedirect(context.getContextPath() + "/manage/login");
            return false;
        }

    }

}
