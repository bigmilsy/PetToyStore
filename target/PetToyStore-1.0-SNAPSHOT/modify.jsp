<%-- 
    Document   : modify
    Created on : 31/12/2019, 9:36:40 PM
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
        <h1 id="txtMainTitle"><input type="button" id="btnBack" style="font-size:14pt" value="< Back" onclick="window.location.href='index.jsp';" /> Modify Pet Toy Store (Demo)</h1>
</td></tr>
<tr><td>
  <table align="center" cellpadding="2" border="1" id="tblCreateToy">
      <td>ID ???</td><td align="right">Name: <input type="text" style="width:150px" id="txtName" />&nbsp;Img: <input type="text" style="width:80px" id="txtImg" />.jpg&nbsp;&nbsp;
          Price: <input type="text" style="width:80px" id="txtPrice" /><br />
          Description: <input type="text" style="width:250px" id="txtDescription" />&nbsp;&nbsp;<input type="button" id="btnCreate" value="CREATE >" onclick="createToy()" /></td>
  </table>
</td></tr>
<tr><td>
  <table align="center" cellpadding="0" border="1" id="tblToys">

  </table>
</td></tr>
</table>    
<form action="petToyStore.jsp" method="post" id="form1" target="">
<input id="command" name="command" type="hidden" value="" />  
<input id="name" name="title" type="hidden" value="" />  
<input id="description" name="code" type="hidden" value="" />  
<input id="img" name="mins" type="hidden" value="" />  
<input id="price" name="secs" type="hidden" value="" />  
<div id="form1R" style=""><!-- For server results --></div>
</form>
<script type="text/javascript">
var ids = [];
var names = [];
var descriptions = [];
var imgs = [];
var prices = [];
var totalToys = 0;
function createToy() {
    var name = document.getElementById('txtName').value;
    var description = document.getElementById('txtDescription').value;
    var price = document.getElementById('txtPrice').value;
    var img = document.getElementById('txtImg').value;
    
  $.post( "petToyStoreAPI.jsp", { command: "createToy", name: name, description: description, price: price, img: img})
    .done(function( data ) {

  });  

}
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
        tblInner = tblInner + '<tr><td><table align="left" cellpadding="3"><td><img src="img/' + imgs[x] + '.jpg" style="width:100px" /></td><td align="center" style="width:500px"><font style="font-size:16pt">' + names[x] + '</font><br />' + descriptions[x] + '<br /><br /><font style="font-size:16pt">$' + prices[x] + '</font>';
        tblInner = tblInner + '<br /><input type="button" value="Delete" id="btnDelete_' + ids[x] + '" onclick="deleteToy(' + ids[x] + ');" /></td></table></td></tr>';  
      }
      tbl.innerHTML = tblInner;
  });  
}
function deleteToy(txtId) {
  $.post( "petToyStoreAPI.jsp", { command: "deleteToy", id: txtId})
    .done(function( data ) {
      var json = JSON.parse(data);
      for (x = 0 ; x < totalToys ; x++) {
          if (ids[x] == txtId) {
              ids.splice(x, 1);
              names.splice(x, 1);
              descriptions.splice(x, 1);
              imgs.splice(x, 1);
              prices.splice(x, 1);
              totalToys--;
              x = totalToys
          }
      }
      loadInitialData();
  });
}
window.onload = function() {
  loadInitialData();
};    
</script>
    </body>
</html>
