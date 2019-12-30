/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.daos;

import com.loinv.powerpoin_share_v1.entities.User;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Loi Nguyen
 */

@Repository
public class UserDAO {
    
    private static final Logger logger = Logger.getLogger(UserDAO.class);
    
    @Autowired
    SessionFactory factory;
    
    public User checkLogin(String userId , String password){
        Session session = factory.openSession();
        Transaction t = null;
        User user = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(User.class);
            ProjectionList pl = Projections.projectionList();
            pl.add(Projections.property("userId").as("userId"));
            pl.add(Projections.property("firstName").as("firstName"));
            pl.add(Projections.property("lastName").as("lastName"));
            pl.add(Projections.property("role").as("role"));
            criteria.setProjection(pl);
            criteria.setResultTransformer(Transformers.aliasToBean(User.class));
            criteria.add(Restrictions.eq("userId", userId));
            criteria.add(Restrictions.eq("password", password));
            criteria.add(Restrictions.eq("status", true));
            user = (User) criteria.uniqueResult();
            t.commit();
        } catch (Exception e) {
            if(t!= null){
                t.rollback();
            }
            e.printStackTrace();
            logger.error(e.getMessage());
        }finally{
            session.close();
        }
        
        return user;
    }
    
}
