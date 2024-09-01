package com.shoppingcart.dao;

import com.shoppingcart.usermodel.Order;

public class OrderService {

    public static void sendOrderNotificationEmails(Order order) {
        String buyerEmail = order.getEmail();
        String sellerEmail = order.getSellerEmail();

        // Constructing the buyer's email content
        String buyerSubject = "Order Confirmation";
        String buyerMessage = "Dear " + order.getFullName() + ",\n\n" +
                "Thank you for your order! Your order number is " + order.getUserOrderNumber() + ".\n" +
                "We will notify you once your order is shipped.\n\n" +
                "Order Details:\n" +
                "Product: " + order.getProductName() + "\n" +
                "Quantity: " + order.getQuantity() + "\n" +
                "Price: $" + order.getPrice() + "\n\n" +
                "Shipping to:\n" +
                order.getAddress() + ", " + order.getCity() + ", " + order.getState() + " " + order.getZipCode() + "\n\n" +
                "Thank you for shopping with us!\n";

        // Constructing the seller's email content
        String sellerSubject = "New Order Received";
        String sellerMessage = "Dear Seller,\n\n" +
                "You have received a new order.\n\n" +
                "Order Number: " + order.getUserOrderNumber() + "\n" +
                "Buyer: " + order.getFullName() + "\n" +
                "Product: " + order.getProductName() + "\n" +
                "Quantity: " + order.getQuantity() + "\n\n" +
                "Please prepare the product for shipment.\n";

        try {
            // Send email to buyer
            if (buyerEmail != null && !buyerEmail.isEmpty()) {
                EmailUtil.sendEmail(buyerEmail, buyerSubject, buyerMessage);
                System.out.println("Order confirmation email sent to buyer: " + buyerEmail);
            } else {
                System.err.println("Buyer email is null or empty. Cannot send confirmation email.");
            }

            // Send email to seller
            if (sellerEmail != null && !sellerEmail.isEmpty()) {
                EmailUtil.sendEmail(sellerEmail, sellerSubject, sellerMessage);
                System.out.println("Order notification email sent to seller: " + sellerEmail);
            } else {
                System.err.println("Seller email is null or empty. Cannot send order notification email.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to send order notification emails: " + e.getMessage());
        }
    }
}
