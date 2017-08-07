/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.medarametla.root.java.database;

/**
 *
 * @author lenovo
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
public class DatabaseUtil {
 public  Connection getDbConnection () { // creates three different Connection objects

  Connection conn1 = null;
  Connection conn2 = null;
  Connection conn3 = null;
  try { 
   Class.forName("com.mysql.jdbc.Driver");
   String dbUrl = "jdbc:mysql://localhost:3306/medarametladb?useUnicode=true&characterEncoding=UTF-8";
   Properties info = new Properties();
   info.put("user", "root");
   info.put("password", "admin");
   conn3 = DriverManager.getConnection(dbUrl, info);
   if (conn3 != null) {
    System.out.println("Connected to the database medarametladb........."+conn3);
   }
   
  } catch (SQLException ex) {
   System.out.println("An error occurred. Maybe user/password is invalid");
   ex.printStackTrace();
  }  catch (ClassNotFoundException ex) {
         Logger.getLogger(DatabaseUtil.class.getName()).log(Level.SEVERE, null, ex);
     }
  
      return conn3;
 }
}