package com.shoppingcart.usermodel;

import java.math.BigDecimal;

public class CartItem {
	private String email;
    private int cartId;
    private int productId;
    private String productName;
    private int quantity;
    private BigDecimal price;

    public CartItem() { }

    public CartItem(String email,int cartId, int productId, String productName, int quantity, BigDecimal price) {
        this.cartId = cartId;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.email=email;
    }

    // Getters and Setters
    

    public int getCartId() {
        return cartId;
    }

    public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

    public void setPrice(BigDecimal d) {
        this.price = d;
    }
}
