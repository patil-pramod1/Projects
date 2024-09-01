package com.shoppingcart.usermodel;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Order {
    private int orderId;
    private int cartId;
    private String fullName;
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private String phone;
    private String paymentMethod;
    private Timestamp orderDate;
    private String email;
    private int productId;
    private String productName;
    private int quantity;
    private BigDecimal price;
    private String userOrderNumber;
    private String sellerEmail;
    private String orderStatus; 
    private String paymentStatus;
  

    // Other fields and methods

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }


    // Default Constructor
    public Order() {
        super();
    }

    // Parameterized Constructor
    public Order(int orderId, int cartId, String fullName, String address, String city, String state, String zipCode,
                 String phone, String paymentMethod, Timestamp orderDate, String email, int productId, String productName,
                 int quantity, BigDecimal price, String userOrderNumber, String sellerEmail, String orderStatus,String paymentStatus) {
        super();
        this.orderId = orderId;
        this.cartId = cartId;
        this.fullName = fullName;
        this.address = address;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.phone = phone;
        this.paymentMethod = paymentMethod;
        this.orderDate = orderDate;
        this.email = email;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.userOrderNumber = userOrderNumber;
        this.sellerEmail = sellerEmail;
        this.orderStatus = orderStatus;
        this.paymentStatus=paymentStatus;
        
    }

    // Getters and Setters for all fields

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
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

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(java.util.Date orderDate) {
        this.orderDate = (Timestamp) orderDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public void setPrice(BigDecimal bigDecimal) {
        this.price = bigDecimal;
    }

    public String getUserOrderNumber() {
        return userOrderNumber;
    }

    public void setUserOrderNumber(String userOrderNumber) {
        this.userOrderNumber = userOrderNumber;
    }

    public String getSellerEmail() {
        return sellerEmail;
    }

    public void setSellerEmail(String sellerEmail) {
        this.sellerEmail = sellerEmail;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
}