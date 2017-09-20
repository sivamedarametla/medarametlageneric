<%-- 
    Document   : article
    Created on : 19 Aug, 2017, 3:18:21 PM
    Author     : lenovo
--%>

<%@page import="java.sql.Blob"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.medarametla.root.java.database.DatabaseUtil"%>
<%String imageString = null;%>

<!doctype html>
<html lang="en">
   <head>
      <title>Welcome to Medarametla</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
      <link href="http://www.jqueryscript.net/demo/Responsive-jQuery-News-Ticker-Plugin-with-Bootstrap-3-Bootstrap-News-Box/css/site.css" rel="stylesheet" type="text/css">
      <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
      <script src="http://www.jqueryscript.net/demo/Responsive-jQuery-News-Ticker-Plugin-with-Bootstrap-3-Bootstrap-News-Box/scripts/jquery.bootstrap.newsbox.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/3.0.3/normalize.css">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="http://htovey.com/weather-app/weather.css">
      <style>
         .header-img-div{
         background-image: url("../images/mmt2.png");  
         background-repeat: no-repeat;
         height: 261px;
         background-size: 100% 108%;
         }
         .header-img{
         }
         .header-text{
         color: red;
         font-size: 26px;
         }
         .header-text.telugu{
         color: yellow;
         font-size: 26px;
         }
         .nav-div{
         background-color:gray;
         width: 585px;
         text-align: center;
         font-size: 20px;
         }
         .nav-div a{
         color: red;
         text-decoration: none;
         }
         .nav-div a.telugu{
         color:yellow;
         text-decoration: none;
         }
         .row{
         /*background-color: #001f3f;*/
         }
         .left-menu{
         /*background-color:red;*/
         height:400px;
         }
         .right-menu{
         /*background-color:violet;*/
         height:400px;
         }
         .news-line{
         color:white;
         }
      </style>
      <style type="text/css">
         .backpack.dropzone {
         font-family: 'SF UI Display', 'Segoe UI';
         font-size: 15px;
         text-align: center;
         display: flex;
         flex-direction: column;
         justify-content: center;
         align-items: center;
         width: 250px;
         height: 150px;
         font-weight: lighter;
         color: white;
         will-change: right;
         z-index: 2147483647;
         bottom: 20%;
         background: #333;
         position: fixed;
         user-select: none;
         transition: left .5s, right .5s;
         right: 0px; }
         .backpack.dropzone .animation {
         height: 80px;
         width: 250px;
         background: url("https://sxt.cdn.skype.com/assets/dropzone/hoverstate.png") left center; }
         .backpack.dropzone .title::before {
         content: 'Save to'; }
         .backpack.dropzone.closed {
         right: -250px; }
         .backpack.dropzone.hover .animation {
         animation: sxt-play-anim-hover 0.91s steps(21);
         animation-fill-mode: forwards;
         background: url("https://sxt.cdn.skype.com/assets/dropzone/hoverstate.png") left center; }
         @keyframes sxt-play-anim-hover {
         from {
         background-position: 0px; }
         to {
         background-position: -5250px; } }
         .backpack.dropzone.saving .title::before {
         content: 'Saving to'; }
         .backpack.dropzone.saving .animation {
         background: url("https://sxt.cdn.skype.com/assets/dropzone/saving_loop.png") left center;
         animation: sxt-play-anim-saving steps(59) 2.46s infinite; }
         @keyframes sxt-play-anim-saving {
         100% {
         background-position: -14750px; } }
         .backpack.dropzone.saved .title::before {
         content: 'Saved to'; }
         .backpack.dropzone.saved .animation {
         background: url("https://sxt.cdn.skype.com/assets/dropzone/saved.png") left center;
         animation: sxt-play-anim-saved steps(20) 0.83s forwards; }
         @keyframes sxt-play-anim-saved {
         100% {
         background-position: -5000px; } }
      </style>
      <script>
         $(document).ready(function(){
          $.ajax({ 
         type: "GET",
         url: "/headlines"
         ,
         success: function(data, textStatus, XmlHttpRequest) {
             console.log(data);
             //parsing data
             //var jsonData = JSON.parse(data);
             for (var i = 0; i < data.length; i++) {
                 var counter = data[i];
                 console.log("heading:"+counter["heading"]);
                                  if(counter["heading"] != 'undefined' && counter["article_type"] == 'news'){
                 $("#nheadin"+i).text(counter["heading"]);
                 $("#scrollimg"+i).attr("src",counter["photo"]);
             }
             }
             //center carousel population
             var addedCenterElements = 0;
             for (var i = 0; i < data.length; i++) {
                 var counter = data[i];
                 console.log("heading:"+counter["heading"]);
                                  if(counter["heading"] != 'undefined' && counter["article_type"] == 'article'){
                                      if(addedCenterElements==0){
                     var carElement = '<div class="item">'+
                        '<img src="'+counter["photo"]+'" alt="" style="width:100%;" height="200">'+
                        '<h5 class="news-line">'+counter["heading"]+'</h5>'+
                        '</div>';
                 $("#center-carousel").append(carElement);
                 addedCenterElements = addedCenterElements + 1;
                                      }else{
                                          var carElement = '<div class="item">'+
                        '<img  src="'+counter["photo"]+'" alt="" style="width:100%;" height="200">'+
                        '<h5 class="news-line">'+counter["heading"]+'</h5>'+
                        '</div>';
                 $("#center-carousel").append(carElement);
                 addedCenterElements = addedCenterElements + 1;
                                      }
             }else if (counter["heading"] != 'undefined' && counter["article_type"] == 'quotation'){
                              var quotationHtml = '';
                              $("#quotation-heading").text(counter["heading"]);
                             $("#quotation-image").attr("src",counter["photo"]);
                              $("#quotation-description").text(counter["news_description"]);

             }            
             }
             var addedLeftElements = 0;
             for (var i = 0; i < data.length; i++) {
                 var counter = data[i];
                 console.log("heading:"+counter["heading"]);
                                  if(counter["heading"] != 'undefined' && counter["article_type"] == 'advertisement'){
                                      if(addedLeftElements==0){
                     var carElement = '<div class="item active">'+
                        '<img src="'+counter["photo"]+'" alt="" style="width:100%;" height="200">'+
                        '<h5 class="news-line">'+counter["heading"]+'</h5>'+
                        '</div>';
                 $("#left-carousel").append(carElement);
                 addedLeftElements = addedLeftElements + 1;
                                      }else{
                                          var carElement = '<div class="item">'+
                        '<img  src="'+counter["photo"]+'" alt="" style="width:100%;" height="200">'+
                        '<h5 class="news-line">'+counter["heading"]+'</h5>'+
                        '</div>';
                 $("#left-carousel").append(carElement);
                 addedLeftElements = addedLeftElements + 1;
                                      }
             }            
             }
             //center carousel population
             //parsing data
          if (XmlHttpRequest.status === 200) {
              var response = XmlHttpRequest.responseText;
          }
         },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert("error:"+Thrown);
         }
         
         });
         }
         );
 $(document).ready(function(){
 $(".rmlink").click(function(){
 });
 });
 
      
         $(function () {
             $(".demo1").bootstrapNews({
                 newsPerPage: 6,
                 autoplay: true,
         		 pauseOnHover:true,
                 direction: 'up',
                 newsTickerInterval: 4000,
                 onToDo: function () {
                     //console.log(this);
                 }
             });
         });
         
     </script>
   <style type="text/css">.backpack.dropzone {
  font-family: 'SF UI Display', 'Segoe UI';
  font-size: 15px;
  text-align: center;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 250px;
  height: 150px;
  font-weight: lighter;
  color: white;
  will-change: right;
  z-index: 2147483647;
  bottom: 20%;
  background: #333;
  position: fixed;
  user-select: none;
  transition: left .5s, right .5s;
  right: 0px; }
  .backpack.dropzone .animation {
    height: 80px;
    width: 250px;
    background: url("https://sxt.cdn.skype.com/assets/dropzone/hoverstate.png") left center; }
  .backpack.dropzone .title::before {
    content: 'Save to'; }
  .backpack.dropzone.closed {
    right: -250px; }
  .backpack.dropzone.hover .animation {
    animation: sxt-play-anim-hover 0.91s steps(21);
    animation-fill-mode: forwards;
    background: url("https://sxt.cdn.skype.com/assets/dropzone/hoverstate.png") left center; }

@keyframes sxt-play-anim-hover {
  from {
    background-position: 0px; }
  to {
    background-position: -5250px; } }
  .backpack.dropzone.saving .title::before {
    content: 'Saving to'; }
  .backpack.dropzone.saving .animation {
    background: url("https://sxt.cdn.skype.com/assets/dropzone/saving_loop.png") left center;
    animation: sxt-play-anim-saving steps(59) 2.46s infinite; }

@keyframes sxt-play-anim-saving {
  100% {
    background-position: -14750px; } }
  .backpack.dropzone.saved .title::before {
    content: 'Saved to'; }
  .backpack.dropzone.saved .animation {
    background: url("https://sxt.cdn.skype.com/assets/dropzone/saved.png") left center;
    animation: sxt-play-anim-saved steps(20) 0.83s forwards; }

@keyframes sxt-play-anim-saved {
  100% {
    background-position: -5000px; } }
</style>
   </head>   <body>
      <div class="primary">
      <div class="container">
         <div class="row">
             <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                 <h3 id="quotation-heading"></h3>
                 <img id="quotation-image" height="140" width="150" src=""/>
                 <p><h5 id="quotation-description"></h5></p>
             </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 header-img-div">
               <article>
                  <header>
                     <marquee>
                        <h1 class="header-text">Welcome to Medarametla...........</h1>
                        <h1 class="header-text telugu">మేదరమెట్లకు స్వాగతం...........</h1>
                     </marquee>
                  </header>
               </article>
                
            </div>
             
             <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                 <iframe src="../html/weatherreport.html" height="280" width="273" scrolling="no"></iframe>
             </div>
         </div>
      </div>
      <!--<div class="container">
         <div class="row">
            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3"></div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
               
            </div>
            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3"></div>
         </div>
      </div>-->
      <div class="container">
         <div class="row">
            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 left-menu">
                
               <!-- Carousel starts here-->
               <div id="myCarouself" class="carousel slide" data-ride="carousel">
                  <!-- Indicators -->
                  <ol class="carousel-indicators">
                     <li data-target="#myCarouself" data-slide-to="0" class="active"></li>
                     <li data-target="#myCarouself" data-slide-to="1"></li>
                     <li data-target="#myCarouself" data-slide-to="2"></li>
                  </ol>
                  <!-- Wrapper for slides -->
                  <div class="carousel-inner" id="left-carousel">
                     <!--<div class="item active">
                        <img src="../images/parents-marriage.jpg" alt="Los Angeles"  style="width:100%;height:375px !important;">
                        <h5 class="news-line">My parents marriage photo..</h5>
                     </div>
                     <div class="item">
                        <img src="../images/family1.jpg" alt="Chicago" height=375 style="width:100%;height:375px !important; ">
                        <h5 class="news-line">Me with my Niece and Nephew..</h5>
                     </div>
                     <div class="item">
                        <img src="../images/yamaha-bike.jpg" alt="New york" height=375 style="width:100%;height:375px !important;">
                        <h5 class="news-line">My bike..</h5>
                     </div>-->
                  </div>
                  <!-- Left and right controls -->
                  <a class="left carousel-control" href="#myCarouself" data-slide="prev">
                  <span class="glyphicon glyphicon-chevron-left"></span>
                  <span class="sr-only">Previous</span>
                  </a>
                  <a class="right carousel-control" href="#myCarouself" data-slide="next">
                  <span class="glyphicon glyphicon-chevron-right"></span>
                  <span class="sr-only">Next</span>
                  </a>
               </div>
               <!--Carousel ends here-->
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <div class="nav-div">
                <nav class="header-nav">
                  <a href="http://www.eenadu.net" target="_blank">News</a> |
                  <a href="mongodb/index.htm">Shop</a> |
                  <a href="mysql/index.htm">Current Affairs</a> |
                  <a href="plsql/index.htm">Technology</a> |
                  <a href="sql/index.htm">Blog|</a> 
                  <a href="sql/index.htm">More...</a> |
                  <a class="telugu" href="http://www.eenadu.net" target="_blank">వార్తలు</a> |
                  <a class="telugu" href="mongodb/index.htm">షాప్</a> |
                  <a class="telugu" href="mysql/index.htm">కరెంట్ అఫైర్స్</a> |
                  <a class="telugu" href="plsql/index.htm">టెక్నాలజీ</a> |
                  <a class="telugu" href="sql/index.htm">బ్లాగు</a> |
                  <a class="telugu" href="">మరిన్ని...</a> |
               </nav>
                </div>
<!-- news description section-->
<%DatabaseUtil dbUtil = new DatabaseUtil();
Connection con = null;
        System.out.println("before getting database connection in article.jsp:"+dbUtil);
         con = dbUtil.getDbConnection();
        System.out.println("con......in article.jsp"+con);
        PreparedStatement ps = null;
                    ps = con.prepareStatement(  
                    "select news_heading,photo,news_description from news_latest where s_no="+Integer.parseInt(request.getParameter("newsId")));
                    ResultSet rs = null;  
                    rs = ps.executeQuery();
        %>

               <div id="news-desc-div" class="">
                   <% while (rs.next()) {
                   //reading image
                   Blob blob = rs.getBlob("photo");
                        if(blob != null){
                        System.out.println("blob:"+blob);
                        int blobLength = (int) blob.length();  
                        byte[] blobAsBytes = blob.getBytes(1, blobLength);
                        //release the blob and free up memory. (since JDBC 4.0)
                        blob.free();
                         imageString = "data:image/png;base64,"+Base64.encodeBase64String(blobAsBytes);
                        System.out.println("imageString:"+imageString);
                        }
                   //reading image
                   %>
                   <h1><%=rs.getString(1)%></h1>
                   <img src="<%=imageString%>"/>
                   <p>
                   <% 
                       out.print(rs.getString(3));
                   }%>
                   </p>
            </div>
            
         </div>
             
             <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 right-menu">
               <!-- Carousel starts here-->
               <div class="">
               <div class="panel panel-default">
                  <div class="panel-heading"> <span class="glyphicon glyphicon-list-alt"></span><b>తాజా వార్తలు</b></div>
                  <div class="panel-body">
                     <div class="row">
                        <div class="col-xs-12">
                           <ul class="demo1" style="overflow-y: hidden;"> 
                              <li style="" class="news-item">
                                 <table cellpadding="4">
                                    <tbody>
                                       <tr>
                                          <td><img id="scrollimg1" src="" width="60" class="img-circle"></td>
                                          <td><a class="rmlink" href="#"><span id="nheadin1"></span></a></td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </li>
                              <li style="" class="news-item">
                                 <table cellpadding="4">
                                    <tbody>
                                       <tr>
                                          <td><img id="scrollimg2" src="" width="60" class="img-circle"></td>
                                          <td><a class="rmlink" href="#"><span id="nheadin2"></span></a></td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </li>
                              <li style="" class="news-item">
                                 <table cellpadding="4">
                                    <tbody>
                                       <tr>
                                          <td><img id="scrollimg3" src="" width="60" class="img-circle"></td>
                                          <td><a class="rmlink" href="#"><span id="nheadin3"></span></a></td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </li>
                              <li style="display:none;" class="news-item">
                                 <table cellpadding="4">
                                    <tbody>
                                       <tr>
                                          <td><img id="scrollimg4" src="" width="60" class="img-circle"></td>
                                          <td><a class="rmlink" href="#"><span id="nheadin4"></span></a></td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </li>
                              <li style="display:none;" class="news-item">
                                 <table cellpadding="4">
                                    <tbody>
                                       <tr>
                                          <td><img id="scrollimg5" src="" width="60" class="img-circle"></td>
                                          <td><a class="rmlink" href="#"><span id="nheadin5"></span></a></td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </li>
                              <li style="display:none;" class="news-item">
                                 <table cellpadding="4">
                                    <tbody>
                                       <tr>
                                          <td><img id="scrollimg6" src="" width="60" class="img-circle"></td>
                                          <td><a class="rmlink" href="#"><span id="nheadin6"></span></a></td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </li>
                              <li style="display:none;" class="news-item">
                                 <table cellpadding="4">
                                    <tbody>
                                       <tr>
                                          <td><img id="scrollimg7" src="" width="60" class="img-circle"></td>
                                          <td><a class="rmlink" href="#"><span id="nheadin7"></span></a></td>
                                       </tr>
                                    </tbody>
                                 </table>
                              </li>
                           </ul>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
               <!--Carousel ends here-->
            </div>
      </div>
   </body>
</html>
<!--Dedicated to SHYM-->