<%-- 
    Document   : index
    Created on : 28/12/2019, 5:08:11 PM
    Author     : dmiller
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>        
    </head>
    <body>
<table align="center">
<tr><td>
  <h1 id="txtMainTitle">Dales Pet Toy Store (Demo)</h1>
</td></tr>
<tr><td>
  <table align="center" cellpadding="0" border="1" id="tblToys">

  </table>
</td></tr>
<tr><td align="right">
        <input type="button" style="font-size:14pt" value="Modify >" id="btnModify" onclick="window.location.href='modify.jsp';" />
</td></tr>
</table>    
<script type="text/javascript">
var ids = [];
var names = [];
var descriptions = [];
var imgs = [];
var prices = [];
var totalToys = 0;

function loadInitialData() {
  $.post( "petToyStoreAPI.jsp", { command: "getAllToys"})
    .done(function( data ) {
      var json = JSON.parse(data);
      totalToys = json.totalRows;
      for (x = 0 ; x < totalToys ; x++) {
          ids[x] = json.data[x].id;
          names[x] = json.data[x].name;
          descriptions[x] = json.data[x].description;
          imgs[x] = json.data[x].img;
          prices[x] = json.data[x].price;
      }
      //load dynamically into the webpage
      var tbl = document.getElementById('tblToys')
      var tblInner = '';
      for (x = 0 ; x < totalToys ; x++) {
        tblInner = tblInner + '<tr><td><table align="left" cellpadding="3"><td><img src="img/' + imgs[x] + '.jpg" style="width:100px" /></td><td align="center" style="width:500px"><font style="font-size:16pt">' + names[x] + '</font><br />' + descriptions[x] + '<br /><br /><font style="font-size:16pt">$' + prices[x] + '</font></td></table></td></tr>';  
      }
      tbl.innerHTML = tblInner;
  });  
}
    
window.onload = function() {
  loadInitialData();
};    

</script>
    </body>
</html>
