/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.services;

import com.loinv.powerpoin_share_v1.daos.UserDAO;
import com.loinv.powerpoin_share_v1.entities.User;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Loi Nguyen
 */

@Service
public class UserService {
    
    @Autowired
    UserDAO userDao;
    
    @Transactional
    public User checkLogin(String userId , String password){
        return userDao.checkLogin(userId, password);
    }
}
