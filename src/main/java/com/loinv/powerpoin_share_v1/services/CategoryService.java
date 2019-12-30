/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.services;

import com.loinv.powerpoin_share_v1.daos.CategoryDAO;
import com.loinv.powerpoin_share_v1.entities.Category;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Loi Nguyen
 */
@Service
public class CategoryService {

    @Autowired
    CategoryDAO dao;
    
    @Transactional
    public List<Category> getListCategory(boolean status) {
        return dao.getListCategories(status);
    }
    
    @Transactional
    public boolean insertCategory(Category category) {
        return dao.insertCategory(category);
    }
    
    @Transactional
    public boolean deleteCategoryById(int id) {
        return dao.deleteCategoryById(id);
    }
    
    @Transactional
    public Category updateCategory(Category newCategory){
        return dao.updateCategory(newCategory);
    }
    
}
