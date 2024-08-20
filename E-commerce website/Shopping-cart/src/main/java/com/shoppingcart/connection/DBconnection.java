package com.shoppingcart.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
    // Single instance of the Connection object
    private static Connection connection = null;

    // Method to get the Connection object
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish the connection to the database
                connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/revshop", // Fixed URL format
                    "root", 
                    "Pramod@1605"
                );
                
                System.out.println("Connected to the database");
            } catch (ClassNotFoundException | SQLException e) {
                // Log the error (you might want to use a logger in real applications)
                e.printStackTrace();
                throw e;
            }
        }
        return connection;
    }

    // Method to close the connection (if needed)
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null; // Reset the connection variable
                System.out.println("Database connection closed");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
