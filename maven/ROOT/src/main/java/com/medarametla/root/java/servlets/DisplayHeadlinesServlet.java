/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.medarametla.root.java.servlets;

import com.medarametla.root.java.database.DatabaseUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONWriter;
import org.json.JSONArray;
import org.json.JSONObject;
import org.apache.commons.codec.binary.Base64;


/**
 *
 * @author lenovo
 */
@WebServlet(name = "DisplayHeadlinesServlet", urlPatterns = {"/headlines"})
public class DisplayHeadlinesServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        System.out.println("in process request method.........");
        Connection con = null;
        try{
        JSONArray latestNews
                = new JSONArray();
        DatabaseUtil dbUtil = new DatabaseUtil();
        System.out.println("before getting database connection:"+dbUtil);
         con = dbUtil.getDbConnection();
        System.out.println("con......"+con);
        PreparedStatement ps = null;
                    ps = con.prepareStatement(  
                    "select * from news_latest");
                    ResultSet rs = null;  
                    rs = ps.executeQuery();
                    JSONObject news = new JSONObject();
                    int newsCounter = 1;
                    while (rs.next()) {
                        JSONObject headingNewsPair = new JSONObject();
                        headingNewsPair.put("s_no", rs.getInt(1));
                        headingNewsPair.put("heading", rs.getString(2));
                        headingNewsPair.put("news_description", rs.getString(3));
                        //news.put("news"+newsCounter, headingNewsPair);
                        System.out.println("value..........:"+rs.getString(2));
                        headingNewsPair.put("article_type", rs.getString(5));
                        System.out.println("article type..........:"+rs.getString(5));
                        Blob blob = rs.getBlob("photo");
                        if(blob != null){
                        System.out.println("blob:"+blob);
                        int blobLength = (int) blob.length();  
                        byte[] blobAsBytes = blob.getBytes(1, blobLength);
                        //release the blob and free up memory. (since JDBC 4.0)
                        blob.free();
                        String imageString = Base64.encodeBase64String(blobAsBytes);
                        headingNewsPair.put("photo", "data:image/png;base64,"+imageString);
                        System.out.println("imageString:"+imageString);
                        }
                        latestNews.put(headingNewsPair);    
                        newsCounter++;
    }
                    response.setHeader("Content-Type", "application/json; charset=UTF-16LE");
            //response.getWriter().write(latestNews.toString());
            response.getWriter().write(latestNews.toString());
        
        
        //send response
    }catch(Exception e){
            System.out.println("Exception while reading Latest news:"+e);
    }
        finally{
        //con.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(DisplayHeadlinesServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(DisplayHeadlinesServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
