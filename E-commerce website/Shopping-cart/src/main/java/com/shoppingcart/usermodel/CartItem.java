package com.shoppingcart.usermodel;

import java.math.BigDecimal;

public class CartItem {
    private String email;
    private int cartId;
    private int productId;
    private String productName;
    private int quantity;
    private BigDecimal price;
    private String fullName;          // Full name of the customer
    private String address;           // Delivery address
    private String city;              // City
    private String state;             // State
    private String zipCode;           // Zip code
    private String phone;             // Phone number
    private String paymentMethod;     // Payment method used
    private String orderStatus;       // Order status
    private String sellerEmail;       // Seller's email

    // Default constructor
    public CartItem() { }

    // Parameterized constructor
    public CartItem(String email, int cartId, int productId, String productName, int quantity, BigDecimal price,
                    String fullName, String address, String city, String state, String zipCode, String phone, 
                    String paymentMethod, String orderStatus, String sellerEmail) {
        this.email = email;
        this.cartId = cartId;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.fullName = fullName;
        this.address = address;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.phone = phone;
        this.paymentMethod = paymentMethod;
        this.orderStatus = orderStatus;
        this.sellerEmail = sellerEmail;
    }

    // Getters and Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getSellerEmail() {
        return sellerEmail;
    }

    public void setSellerEmail(String sellerEmail) {
        this.sellerEmail = sellerEmail;
    }
}