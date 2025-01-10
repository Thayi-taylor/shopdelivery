package com.project.shopdelivery.order;

import lombok.Data;

@Data	// Lombok API
public class Order {
	private int orderIndex;
	private int productCount;
	private int orderAmount;
	private String orderDatetime;
	private String deliveryDatetime;
	private String deliveryAddress1;
	private String deliveryAddress2;
	private String recipientName;
	private String receiverNumber1;
	private String receiverNumber2;
	private String receiverNumber3;
	private String receiverPhoneNumber1;
	private String receiverPhoneNumber2;
	private String receiverPhoneNumber3;
	private String occasionPhrase;
	private String senderName;
	private String orderNote;
	private int productIndex;
	private String productName;
	private int productUnitPrice;
}
