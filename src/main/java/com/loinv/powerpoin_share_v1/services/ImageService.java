/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.services;

import com.loinv.powerpoin_share_v1.daos.ImageDAO;
import com.loinv.powerpoin_share_v1.entities.Image;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Loi Nguyen
 */
@Service
public class ImageService {

    @Autowired
    ImageDAO imageDao;

    @Transactional
    public void insert(Image image) {
        imageDao.insert(image);
    }

    @Transactional
    public Image getImagePath(int id) {
        return imageDao.getImagePath(id);
    }

    @Transactional
    public void delete(int id) {
        imageDao.delete(id);
    }

    @Transactional
    public List<Image> getImagePathsBySlideId(int slideId) {
        return imageDao.getImagePathsBySlideId(slideId);
    }
    
    @Transactional
     public int getCurrentId() {
         return imageDao.getCurrentId();
     }
}
