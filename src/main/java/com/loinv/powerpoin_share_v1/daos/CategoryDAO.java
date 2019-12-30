/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.daos;

import com.loinv.powerpoin_share_v1.entities.Category;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Loi Nguyen
 */
@Repository
public class CategoryDAO {

    private static final Logger logger = Logger.getLogger(CategoryDAO.class);

    @Autowired
    SessionFactory factory;

    public List<Category> getListCategories(boolean status) {
        Session session = factory.openSession();
        Transaction t = null;
        List<Category> list = null;
        try {
            t = session.beginTransaction();
            String hql = "FROM Category where status = " + status;
            list = session.createQuery(hql).list();
            t.commit();
        } catch (Exception e) {
            t.rollback();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public boolean insertCategory(Category category) {
        boolean result = true;
        Session session = factory.openSession();
        Transaction t = null;
        try {
            t = session.beginTransaction();
            session.save(category);
            t.commit();
        } catch (Exception e) {
            if (t != null) {
                t.rollback();
            }
            result = false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return result;
    }

    public boolean deleteCategoryById(int id) {
        boolean result = true;
        Session session = factory.openSession();
        Transaction t = null;
        try {
            t = session.beginTransaction();
            Category category = (Category) session.get(Category.class, id);
            category.setStatus(false);
            t.commit();
        } catch (Exception e) {
            if (t != null) {
                t.rollback();
            }
            result = false;
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return result;
    }

    public Category updateCategory(Category newCategory) {
        Session session = factory.openSession();
        Transaction t = null;
        Category category = null;
        try {
            t = session.beginTransaction();
            int id = newCategory.getCategoryId();
            category = (Category) session.get(Category.class, id);
            category.setCategoryName(newCategory.getCategoryName());
            category.setStatus(newCategory.isStatus());
            t.commit();
        } catch (Exception e) {
            logger.error(e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return category;
    }
}
