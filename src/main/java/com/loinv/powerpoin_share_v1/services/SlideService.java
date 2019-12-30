/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.services;

import com.loinv.powerpoin_share_v1.daos.SlideDAO;
import com.loinv.powerpoin_share_v1.entities.Slide;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Loi Nguyen
 */
@Service
public class SlideService {

    @Autowired
    private SlideDAO slideDAO;

    @Transactional
    public Slide getSlideById(int id) {
        return slideDAO.getSlideById(id);
    }

    @Transactional
    public List<Slide> getListSlide(int begin,boolean status) {
        return slideDAO.getListSlide(begin,status);
    }

    @Transactional
    public boolean deleteSlideById(int id) {
        return slideDAO.deleteSlideById(id);
    }

    @Transactional
    public int getCurrentId() {
        return slideDAO.getCurrentId();
    }

    @Transactional
    public void insert(Slide slide) {
        slideDAO.insert(slide);
    }

    @Transactional
    public long getNumbersOfslide(int categoryId) {
        return slideDAO.getNumbersOfslide(categoryId);
    }

    @Transactional
    public List<Slide> getNewestSlides() {
        return slideDAO.getNewestSlides();
    }
    
    @Transactional
    public List<Slide> getHotestSlides(){
        return slideDAO.getHotestSlides();
    }

    @Transactional
    public void updateDownload(int id) {
        slideDAO.updateDownload(id);
    }

    @Transactional
    public List<Slide> getRandomSlides() {
        return slideDAO.getRandomSlides();
    }
    
    @Transactional
    public List<Slide> getListSlideByProperties(int page, int categoryId, String orderBy){
        return slideDAO.getListSlideByProperties(page, categoryId, orderBy);
    }
    
    @Transactional
    public List<Slide> search(String searchValue,int page){
        return slideDAO.search(searchValue,page);
    }
    
    @Transactional
    public long getNumbersOfsearch(String searchValue){
        return slideDAO.getNumbersOfsearch(searchValue);
    }
    
    @Transactional
    public Slide getFilePath(int id){
        return slideDAO.getFilePath(id);
    }
    
    @Transactional
    public Slide updateSlide(Slide newSlide){
        return slideDAO.updateSlide(newSlide);
    }
}
