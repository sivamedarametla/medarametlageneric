<%-- 
    Document   : Upload
    Created on : 5 Aug, 2017, 9:18:08 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Authoring template</title>
      <meta charset="UTF-8">

</head>
<body>
    <center>
        <h1>News Authoring</h1>
        <form method="post" action=<%=request.getContextPath()%> "/uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td>News Headline: </td>
                    <td><input type="text" name="news_heading"/></td> 
                </tr>
                <tr>
                    <td>News Description: </td>
                    <td><input type="text" name="news_description"/></td>
                </tr>
                <tr>
                    <td>Portrait Photo: </td>
                    <td><input type="file" name="photo" size="50"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </table>
            <input type="hidden" name="article_type" value="news"/>
        </form>
    </center>
    <center>
        <h1>Article Authoring</h1>
        <form method="post" action=<%=request.getContextPath()%> "/uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td>Article Headline: </td>
                    <td><input type="text" name="news_heading"/></td> 
                </tr>
                <tr>
                    <td>Article Description: </td>
                    <td><input type="text" name="news_description"/></td>
                </tr>
                <tr>
                    <td>Article Photo: </td>
                    <td><input type="file" name="photo" size="50"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </table>
                        <input type="hidden" name="article_type" value="article"/>

        </form>
    </center>
            <center>
        <h1>Technology Authoring</h1>
        <form method="post" action=<%=request.getContextPath()%> "/uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td>Technology Headline: </td>
                    <td><input type="text" name="news_heading"/></td> 
                </tr>
                <tr>
                    <td>Technology Description: </td>
                    <td><input type="text" name="news_description"/></td>
                </tr>
                <tr>
                    <td>Technology Photo: </td>
                    <td><input type="file" name="photo" size="50"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </table>
                        <input type="hidden" name="article_type" value="technology_article"/>

        </form>
    </center>
    <center>
        <h1>Current Affairs Authoring</h1>
        <form method="post" action=<%=request.getContextPath()%> "/uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td>Current Affairs Headline: </td>
                    <td><input type="text" name="news_heading"/></td> 
                </tr>
                <tr>
                    <td>Current Affairs Description: </td>
                    <td><input type="text" name="news_description"/></td>
                </tr>
                <tr>
                    <td>Current Affairs Photo: </td>
                    <td><input type="file" name="photo" size="50"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </table>
                        <input type="hidden" name="article_type" value="current_affairs"/>

        </form>
    </center>
            <center>
        <h1>Advertisements Authoring</h1>
        <form method="post" action=<%=request.getContextPath()%> "/uploadServlet" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td>Advertisement Headline: </td>
                    <td><input type="text" name="news_heading"/></td> 
                </tr>
                <tr>
                    <td>Advertisement Description: </td>
                    <td><input type="text" name="news_description"/></td>
                </tr>
                <tr>
                    <td>Advertisement Photo: </td>
                    <td><input type="file" name="photo" size="50"/></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </table>
                        <input type="hidden" name="article_type" value="advertisement"/>

        </form>
    </center>
</body>
</html>
