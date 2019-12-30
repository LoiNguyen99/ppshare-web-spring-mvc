/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.controllers;

import com.loinv.powerpoin_share_v1.entities.Slide;
import com.loinv.powerpoin_share_v1.services.SlideService;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 *
 * @author Loi Nguyen
 */
@Controller
@RequestMapping("/download")
public class DownloadController {

    
    @Autowired
    ServletContext context;
    
    @Autowired
    SlideService service;
    
    private static final Logger LOGGER = Logger.getLogger(ManageController.class);

    @RequestMapping("{id}/{fileName}")
    public void download(HttpServletResponse response,@PathVariable("id") String id, @PathVariable("fileName") String fileName) {
        String realPath = context.getRealPath("/");
        Slide slide = service.getFilePath(Integer.parseInt(id));
        String filepath = slide.getFilePath();
        filepath = filepath.replace("files/", "");     
        String contextPath = "ROOT";
        if (context.getContextPath().length() > 0) {
            contextPath = context.getContextPath().substring(1, context.getContextPath().length());
        }
        realPath = realPath.replace(contextPath, "files");
        realPath = realPath + filepath;
        File file = new File(realPath);
        try {
            byte[] data = FileUtils.readFileToByteArray(file);
            response.setContentType("application/octet-stream");
            response.setHeader("Content-disposition", "attachment; filename=" + file.getName());
            response.setContentLength(data.length);
            InputStream inputStream = new BufferedInputStream(new ByteArrayInputStream(data));
            FileCopyUtils.copy(inputStream, response.getOutputStream());
            service.updateDownload(Integer.parseInt(id));
        } catch (IOException e) {
            LOGGER.error(e.getMessage());
        }

    }
    
}
