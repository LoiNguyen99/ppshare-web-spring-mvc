/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.daos;

import com.loinv.powerpoin_share_v1.entities.Slide;
import java.util.List;
import java.util.Random;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
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
public class SlideDAO {

    private static final Logger logger = Logger.getLogger(SlideDAO.class);

    public static final int PAGE_SIZE = 10;
    @Autowired
    private SessionFactory factory;

    public Slide getSlideById(int id) {
        Session session = factory.getCurrentSession();
        Slide slide = (Slide) session.get(Slide.class, id);

        return slide;
    }

    public List<Slide> getListSlide(int page, boolean status) {
        int begin = (page * PAGE_SIZE - PAGE_SIZE);
        Session session = factory.openSession();
        Transaction t = null;
        List<Slide> list = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Slide.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("slideName").as("slideName"));
            projectionList.add(Projections.property("avatarPath").as("avatarPath"));
            projectionList.add(Projections.property("slideId").as("slideId"));
            projectionList.add(Projections.property("size").as("size"));
            projectionList.add(Projections.property("dateCreate").as("dateCreate"));
            projectionList.add(Projections.property("category").as("category"));
            projectionList.add(Projections.property("download").as("download"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Slide.class));
            criteria.add(Restrictions.eq("status", status));
            criteria.addOrder(Order.desc("dateCreate"));
            criteria.setFirstResult(begin);
            criteria.setMaxResults(PAGE_SIZE -1);
            list = criteria.list();
            t.commit();
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public List<Slide> getListSlideByProperties(int page, int categoryId, String orderBy) {
        int begin = page * 12 - 12;
        Session session = factory.openSession();
        Transaction t = null;
        List<Slide> list = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Slide.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("slideName").as("slideName"));
            projectionList.add(Projections.property("avatarPath").as("avatarPath"));
            projectionList.add(Projections.property("slideId").as("slideId"));
            projectionList.add(Projections.property("category").as("category"));
            projectionList.add(Projections.property("filePath").as("filePath"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Slide.class));
            if (categoryId > 0) {
                criteria.add(Restrictions.eq("category.categoryId", categoryId));
            }
            if (orderBy.equals("1")) {
                criteria.addOrder(Order.desc("dateCreate"));
            } else if (orderBy.equals("2")) {
                criteria.addOrder(Order.asc("dateCreate"));
            } else if (orderBy.equals("3")) {
                criteria.addOrder(Order.desc("download"));
            }
            criteria.add(Restrictions.eq("status", true));
            criteria.setFirstResult(begin);
            criteria.setMaxResults(12);
            list = criteria.list();
            t.commit();
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public boolean deleteSlideById(int id) {
        boolean result = false;
        Session session = factory.getCurrentSession();
        String hql = "UPDATE Slide SET status = 0 where slideId = :id";
        Query q = session.createQuery(hql);
        q.setParameter("id", id);
        result = q.executeUpdate() > 0;

        return result;
    }

    public int getCurrentId() {
        int currentId = 0;
        Session session = factory.openSession();
        Transaction t = null;

        try {
            t = session.beginTransaction();
            Query q = session.createQuery("select max(slideId) from Slide");
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

    public void insert(Slide slide) {
        Session session = factory.getCurrentSession();
        session.persist(slide);
    }

    public long getNumbersOfslide(int categoryId) {
        Session session = factory.getCurrentSession();
        long count = 0;
        try {
            Query q = null;
            if (categoryId > 0) {
                q = session.createQuery("select count(slideId) from Slide where status= 1 and category.categoryId = :categoryId");
                q.setParameter("categoryId", categoryId);
            }
            else {
                 q = session.createQuery("select count(slideId) from Slide where status= 1");
            }

            count = (long) q.uniqueResult();
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return count;
    }

    public List<Slide> getNewestSlides() {
        Session session = factory.openSession();
        Transaction t = null;
        List<Slide> list = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Slide.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("slideName").as("slideName"));
            projectionList.add(Projections.property("avatarPath").as("avatarPath"));
            projectionList.add(Projections.property("filePath").as("filePath"));
            projectionList.add(Projections.property("slideId").as("slideId"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Slide.class));
            criteria.add(Restrictions.eq("status", true));
            criteria.addOrder(Order.desc("dateCreate"));
            criteria.setMaxResults(8);
            list = criteria.list();
            t.commit();
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public List<Slide> getHotestSlides() {
        Session session = factory.openSession();
        Transaction t = null;
        List<Slide> list = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Slide.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("slideName").as("slideName"));
            projectionList.add(Projections.property("avatarPath").as("avatarPath"));
            projectionList.add(Projections.property("filePath").as("filePath"));
            projectionList.add(Projections.property("slideId").as("slideId"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Slide.class));
            criteria.add(Restrictions.eq("status", true));
            criteria.addOrder(Order.desc("download"));
            criteria.setMaxResults(8);
            list = criteria.list();
            t.commit();
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public void updateDownload(int id) {
        Session session = factory.openSession();
        Transaction transaction = session.beginTransaction();
        Slide slide = (Slide) session.get(Slide.class, id);
        slide.setDownload(slide.getDownload() + 1);
        transaction.commit();
        if (session != null) {
            session.close();
        }

    }

    public List<Slide> getRandomSlides() {
        Session session = factory.openSession();
        Transaction t = null;
        List<Slide> slides = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Slide.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("slideName").as("slideName"));
            projectionList.add(Projections.property("avatarPath").as("avatarPath"));
            projectionList.add(Projections.property("slideId").as("slideId"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Slide.class));
            criteria.add(Restrictions.eq("status", true));
            Random random = new Random();
            int first = random.nextInt((int) getNumbersOfslide(0) - 6);
            criteria.setFirstResult(first);
            criteria.setMaxResults(6);
            slides = criteria.list();
            t.commit();
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return slides;
    }

    public List<Slide> search(String searchValue, int page) {
        int begin = page * 12 - 12;
        Session session = factory.openSession();
        Transaction t = null;
        List<Slide> list = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Slide.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("slideName").as("slideName"));
            projectionList.add(Projections.property("avatarPath").as("avatarPath"));
            projectionList.add(Projections.property("slideId").as("slideId"));
            projectionList.add(Projections.property("category").as("category"));
            projectionList.add(Projections.property("filePath").as("filePath"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Slide.class));
            criteria.add(Restrictions.ilike("slideName", "%" + searchValue + "%"));
            criteria.add(Restrictions.eq("status", true));
            criteria.setFirstResult(begin);
            criteria.setMaxResults(12);
            list = criteria.list();
            t.commit();
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return list;
    }

    public long getNumbersOfsearch(String searchValue) {
        Session session = factory.getCurrentSession();
        Query q = session.createQuery("select count(slideId) from Slide as s where s.status= 1 and s.slideName like :searchValue");
        q.setParameter("searchValue", "%" + searchValue + "%");
        long count = (long) q.uniqueResult();

        return count;
    }

    public Slide getFilePath(int id) {
        Session session = factory.openSession();
        Transaction t = null;
        Slide slide = null;
        try {
            t = session.beginTransaction();
            Criteria criteria = session.createCriteria(Slide.class);
            ProjectionList projectionList = Projections.projectionList();
            projectionList.add(Projections.property("filePath").as("filePath"));
            criteria.setProjection(projectionList);
            criteria.setResultTransformer(Transformers.aliasToBean(Slide.class));
            criteria.add(Restrictions.eq("slideId", id));
            slide = (Slide) criteria.uniqueResult();
            t.commit();
        } catch (Exception e) {
            logger.error("Error: " + e.getMessage());
            if (t != null) {
                t.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return slide;
    }

    public Slide updateSlide(Slide newSlide) {
        Session session = factory.openSession();
        Transaction t = null;
        Slide slide = null;
        try {
            t = session.beginTransaction();
            int id = newSlide.getSlideId();
            slide = (Slide) session.get(Slide.class, id);
            slide.setSlideName(newSlide.getSlideName());
            slide.setAvatarPath(newSlide.getAvatarPath());
            slide.setCategory(newSlide.getCategory());
            slide.setFilePath(newSlide.getFilePath());
            slide.setSize(newSlide.getSize());
            slide.setStatus(newSlide.isStatus());
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
        return slide;
    }

}
