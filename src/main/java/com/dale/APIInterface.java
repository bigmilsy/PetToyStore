/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dale;
//Database
import java.sql.*;
import java.util.HashMap;
/**
 *
 * @author dmiller
 */
public class APIInterface {
    public APIInterface() {
        
    }
    public String getAllToys() {
        Connection connect = null;
        Statement statement = null;
        ResultSet resultSet = null;    
        StringBuffer buf = new StringBuffer();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/pettoystore","dale","daledale");
            statement = connect.createStatement();
            resultSet = statement.executeQuery("select * from pettoystore.toys");
            int rowCount = 0;
            int totalRows = 0;
            while (resultSet.next()) {
                totalRows++;
            }
            resultSet.beforeFirst();
            buf.append("{");
            buf.append("\"data\":[");
            while (resultSet.next()) {
                buf.append("{\"id\": \"" + resultSet.getInt("id") + "\",");
                buf.append("\"name\": \"" + resultSet.getString("name") + "\",");
                buf.append("\"description\": \"" + resultSet.getString("description") + "\",");
                buf.append("\"img\": \"" + resultSet.getString("img") + "\",");
                buf.append("\"price\": \"" + resultSet.getFloat("price") + "\"}");
                rowCount++;
                if (rowCount != totalRows) {
                    buf.append(",");
                }
            }
            buf.append("]");
            buf.append(", \"totalRows\":" + totalRows);
            buf.append("}");
//{"data":[{"id": "1","name": "Plastic Bone","description": "A good plastic bone for any dog. Purchase one today!","img": "plaBon","price": "20.5"},{"id": "2","name": "Tug-Of-War","description": "Dogs cannot resist this tug of war toy! Very long lasting","img": "tugOfWar","price": "15.75"},{"id": "3","name": "Dog Ball","description": "Designed to last a long time, this plastic ball will keep your pooch occupid for days","img": "dogBal","price": "27.5"}], "totalRows":3}            
        } catch (Exception e) {
            System.out.println(e);
            return "fail";
        }        
        return buf.toString();
    }
    public String createToy(HashMap<String, String> pars) {
        //pull out all data
        String name = pars.get("name");
        String description = pars.get("description");
        String img = pars.get("img");
        String price = pars.get("price");        
        //add to DB
        Connection connect = null;
        Statement statement = null;
        //PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;    
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/pettoystore","dale","daledale");
            statement = connect.createStatement();
            statement.executeUpdate("INSERT INTO toys (name, description, img, price) VALUES ('" + name + "', '" + description + "', '" + img + "', " + price + ");");    
            connect.close();
        } catch (Exception e) {
            System.out.println(e);
            return "fail";
        }
        
        return "ok";
    }
    public String getToyIdByName(HashMap<String, String> pars) {
        String id = new String();
        String name = pars.get("name");
        Connection connect = null;
        Statement statement = null;
        ResultSet resultSet = null;            
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/pettoystore","dale","daledale");
            statement = connect.createStatement();
            resultSet = statement.executeQuery("select * from pettoystore.toys where name = '" + name + "';");
            resultSet.next();
            id = resultSet.getString("id");

        } catch (Exception e) {
            System.out.println("ERROR in getToyIdByName: " + e);
            return "fail";
        }
        return id;
    }
    public String updateToy(HashMap<String, String> pars) {
       Connection connect = null;
        Statement statement = null;
        //PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;    
        String id = new String(pars.get("id"));
        String name = new String(pars.get("name"));
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/pettoystore","dale","daledale");
            statement = connect.createStatement();
            statement.executeUpdate("UPDATE toys SET name = '" + name + "' WHERE name = 'TEST_TOY_API';");    

            connect.close();
        } catch (Exception e) {
            System.out.println(e);
            return "fail";
        }            
        return "ok";
    }
    public String deleteToy(HashMap<String, String> pars) {
       Connection connect = null;
        Statement statement = null;
        //PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;    
        String id = new String(pars.get("id"));
        System.out.println("id = " + id);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/pettoystore","dale","daledale");
            statement = connect.createStatement();
            statement.executeUpdate("DELETE FROM toys WHERE id = " + id + ";");    
            connect.close();
        } catch (Exception e) {
            System.out.println(e);
            return "fail";
        }            
        
        return "{\"data\":\"ok\"}";
    }
}
