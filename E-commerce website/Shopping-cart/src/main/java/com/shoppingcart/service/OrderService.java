package com.shoppingcart.service;

import java.util.List;

import com.shoppingcart.usermodel.Order;

public interface OrderService {
	List<Order> getAllOders(String userEmail);
	public void sendOrderNotificationEmails(Order order);
}
