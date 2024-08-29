package com.shoppingcart.usermodel;

import java.math.BigDecimal;

public class Product {
    private int productId;
    private String productName;
    private BigDecimal price;
    private int stock;
    private String description;
    private String imageUrl;
    private String category;
    private BigDecimal discount;
    
    
    

    public Product() {
		
	}

	public Product(int productId, String productName, BigDecimal price, int stock, String description, String imageUrl,
			String category,BigDecimal discount) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.stock = stock;
		this.description = description;
		this.imageUrl = imageUrl;
		this.category = category;
		this.discount=discount;
	}

	// Existing constructors, getters, and setters...
	
    public int getProductId() {
		return productId;
	}

	public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
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

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
