/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.controllers;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import org.apache.log4j.Logger;

/**
 *
 * @author Loi Nguyen
 */
@WebListener
public class ImplementContextListener implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(ImplementContextListener.class);
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        Enumeration<Driver> drivers = DriverManager.getDrivers();
        Driver d = null;
        while (drivers.hasMoreElements()) {
            try {
                d = drivers.nextElement();
                DriverManager.deregisterDriver(d);
            } catch (SQLException ex) {
                LOGGER.error(ex.getMessage());
            }
        }
        AbandonedConnectionCleanupThread.uncheckedShutdown();
    }
}
