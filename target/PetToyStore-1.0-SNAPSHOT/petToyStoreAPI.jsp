<%@page import="java.util.HashMap"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.dale.APIInterface"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
APIInterface api = new APIInterface();
Enumeration en = request.getParameterNames();
HashMap<String, String> pars = new HashMap<String, String>();

// enumerate through the keys and extract the values 
// from the keys! 
while (en.hasMoreElements()) {
    String parameterName = (String) en.nextElement();
    String parameterValue = request.getParameter(parameterName);
    pars.put(parameterName, parameterValue);
}
String command = (String)pars.get("command");
if (command == null) {
    command = "";
}
String result = new String();
if (command.equals("getAllToys")) {
    result = api.getAllToys();
} else if (command.equals("createToy")) {
    result = api.createToy(pars);
} else if (command.equals("getToyIdByName")) {
    result = api.getToyIdByName(pars);
} else if (command.equals("updateToy")) {
    result = api.updateToy(pars);
} else if (command.equals("deleteToy")) {
    result = api.deleteToy(pars);
} else {
    System.out.println("ERROR: API Command not found " + command);
}
%><%=result%>