package com.shoppingcart.servlet;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.shoppingcart.connection.DBconnection;
import com.shoppingcart.dao.SellerDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AddProductServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "product.images"; // Relative path to your webapp directory

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        String stockQuantityStr = request.getParameter("stockQuantity");

        // Get the seller's email from the session
        HttpSession session = request.getSession();
        String sellerEmail = (String) session.getAttribute("auth");    // Get email from session

        if (sellerEmail == null) {
            System.out.println("Seller email not found in session. Redirecting to login.");
            response.sendRedirect("login_seller.jsp");
            return;
        }

        // Validate input
        if (productName == null || productName.trim().isEmpty() ||
            description == null || description.trim().isEmpty() ||
            priceStr == null || priceStr.trim().isEmpty() ||
            category == null || category.trim().isEmpty() ||
            stockQuantityStr == null || stockQuantityStr.trim().isEmpty()) {

            request.setAttribute("error", "Please fill out all required fields.");
            request.getRequestDispatcher("addproduct.jsp").forward(request, response);
            return;
        }

        double price;
        int stockQuantity;
        

        try {
            price = Double.parseDouble(priceStr.trim());
            stockQuantity = Integer.parseInt(stockQuantityStr.trim());
            if (price < 0 || stockQuantity < 1) {
                request.setAttribute("error", "Price must be at least 1 and stock quantity must be at least 1.");
                request.getRequestDispatcher("addProduct.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid number format.");
            request.getRequestDispatcher("addproduct.jsp").forward(request, response);
            return;
        }

        // Handle file upload
        Part filePart = request.getPart("imageFile"); // Retrieves <input type="file" name="imageFile">
        String fileName = extractFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        // Ensure the directory exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Save the file on the server
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Relative path to store in the database
        String imageUrl = UPLOAD_DIR + "/" + fileName;

        // Current date and time
        String dateAdded = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String lastUpdated = dateAdded;

        // Initially, set the buyer's email to an empty string
        String buyerEmail = "";

        // Get vendorId from form input or session
        String vendorIdStr = request.getParameter("vendorId"); // Assuming vendorId is passed as a form input
        int vendorId = Integer.parseInt(vendorIdStr.trim());

        // Database connection and insertion
        try (Connection connection = DBconnection.getConnection()) {
            SellerDao sellerDao = new SellerDao(connection);
            // Pass all required parameters to the DAO method in the correct sequence
            boolean isProductAdded = sellerDao.addProductseller(productName, description, price, imageUrl, category, stockQuantity, dateAdded, lastUpdated, vendorId, buyerEmail, sellerEmail);

            if (isProductAdded) {
                // Redirect to avoid form resubmission on refresh (PRG Pattern)
                response.sendRedirect("sellerHomepage.jsp?success=true");
            } else {
                request.setAttribute("error", "Failed to add product.");
                request.getRequestDispatcher("addproduct.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("addproduct.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Class not found: " + e.getMessage());
            request.getRequestDispatcher("addproduct.jsp").forward(request, response);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
