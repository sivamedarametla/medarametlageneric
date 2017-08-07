/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.medarametla.root.java.servlets.authoring;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.http.Part;
import com.medarametla.root.java.database.DatabaseUtil;
import java.util.Date;
import java.text.SimpleDateFormat;


/**
 *
 * @author lenovo
 */
@WebServlet(name = "FileUploadDBServlet", urlPatterns = {"/uploadServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class FileUploadDBServlet extends HttpServlet {
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author lenovo
 */

// database connection settings
 protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {// gets values of text fields

  String newsHeading = request.getParameter("news_heading");
     System.out.println("newsHeading............:"+newsHeading);
  String newsDescription = request.getParameter("news_description");
    String articleType = request.getParameter("article_type");

  InputStream inputStream = null; // input stream of the upload file
  // obtains the upload file part in this multipart request
  Part filePart = request.getPart("photo");
  if (filePart != null) {// prints out some information for debugging
   System.out.println(filePart.getName());
   System.out.println(filePart.getSize());
   System.out.println(filePart.getContentType());// obtains input stream of the upload file
   inputStream = filePart.getInputStream();
  }
  Connection conn = null; // connection to the database
  String message = null;// message will be sent back to client
  try {// connects to the database
   DatabaseUtil dbUtil = new DatabaseUtil();
         conn = dbUtil.getDbConnection();
        System.out.println("con......"+conn);
        String sql = "INSERT INTO news_latest ( s_no,news_heading,news_description, created_date,article_type,photo) values (?, ?, ?,?,?,?)";
   PreparedStatement statement = conn.prepareStatement(sql);
      System.out.println("newsDescription:"+newsDescription);
      statement.setInt(1, 0);
   statement.setString(2, newsHeading);
   statement.setString(3, newsDescription);
      java.util.Date dt = new java.util.Date();
   SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   String currentTime = sdf.format(dt);
      statement.setString(4, currentTime);
         statement.setString(5, articleType);

   if (inputStream != null) {// fetches input stream of the upload file for the blob column
    statement.setBlob(6, inputStream);
   }// sends the statement to the database server

   int row = statement.executeUpdate();
   if (row > 0) {
    message = "File uploaded and saved into database";
   }
  } catch (SQLException ex) {
   message = "ERROR: " + ex.getMessage();
   ex.printStackTrace();
  } finally {
   if (conn != null) {// closes the database connection
    try {
     conn.close();
    } catch (SQLException ex) {
     ex.printStackTrace();
    }
   }// sets the message in request scope
   request.setAttribute("Message", message);// forwards to the message 
   getServletContext().getRequestDispatcher(request.getContextPath()+"/jsp/Message.jsp").forward(request, response);
  }
 }
}

