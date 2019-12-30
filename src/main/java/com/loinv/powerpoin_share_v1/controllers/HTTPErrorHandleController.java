/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

/**
 *
 * @author Loi Nguyen
 */
@ControllerAdvice
public class HTTPErrorHandleController {

////    @ExceptionHandler(NoHandlerFoundException.class)
//    @ExceptionHandler()
//    @ResponseStatus(HttpStatus.NOT_FOUND)
//    public String handleExceptiond(Exception ex) {
//        System.out.println(ex.getLocalizedMessage());
//
//        return "errorPage";
//    }

}
