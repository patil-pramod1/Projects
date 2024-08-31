package com.shoppingcart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.shoppingcart.connection.DBconnection;

public class WishlistDAO {

    // Method to remove an item from the wishlist in the database
    public void removeFromWishlist(String email, String productId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM revshop.wishlist WHERE email = ? AND productId = ?";
        
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, productId);
            stmt.executeUpdate();
        }
    }
}
