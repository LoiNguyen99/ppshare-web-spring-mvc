/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.daos;

import com.loinv.powerpoin_share_v1.entities.Image;
import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
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
public class ImageDAO {

    private static final Logger logger = Logger.getLogger(ImageDAO.class);

    @Autowired
    SessionFactory factory;

    public void insert(Image image) {
        Session session = factory.openSession();
        Transaction t = null;
        try {
            t = session.beginTransaction();
            session.save(image);
            t.commit();
        } catch (Exception e) {
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public void delete(int id) {
        Session session = factory.openSession();
        Transaction t = null;
        try {
            t = session.beginTransaction();
            Image image = (Image) session.get(Image.class, id);
            session.delete(image);
            t.commit();
        } catch (Exception e) {
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public Image getImagePath(int id) {
        Session session = factory.openSession();
        Transaction t = null;
        Image image = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Image.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("imagePath").as("imagePath"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Image.class));
            criteria.add(Restrictions.eq("imageId", id));
            image = (Image) criteria.uniqueResult();
            t.commit();
        } catch (Exception e) {
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return image;
    }

    public List<Image> getImagePathsBySlideId(int slideId) {
        Session session = factory.openSession();
        Transaction t = null;
        List<Image> images = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Image.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("imageId").as("imageId"));
            projectionList.add(Projections.property("imagePath").as("imagePath"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Image.class));
            criteria.add(Restrictions.eq("slide.slideId", slideId));
            images = criteria.list();
            t.commit();
        } catch (Exception e) {
            logger.error(e.getMessage());
            if (t != null) {
                t.rollback();
            }
        }

        return images;

    }

    public int getCurrentId() {
        int currentId = 0;
        Session session = factory.openSession();
        Transaction t = null;

        try {
            t = session.beginTransaction();
            Query q = session.createQuery("select max(imageId) from Image");
            if (q.uniqueResult() != null) {
                currentId = (int) q.uniqueResult();
            } else {
                currentId = 0;
            }
            t.commit();
        } catch (Exception e) {
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return currentId;
    }
}
