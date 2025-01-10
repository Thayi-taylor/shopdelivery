package com.project.shopdelivery.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAO {

	@Autowired(required=true)
	DataSource dataSource;
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void finallyClose() {
		try {
			if(pstmt != null) { pstmt.close(); }
			if(conn != null) { conn.close(); }
			if(rs != null) { rs.close(); }
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void orderInsert(Order order) {
		try {
			conn = dataSource.getConnection();
			
			// itemorder 테이블에 삽입
			String itemOrderSql = "INSERT INTO itemorder (productIndex, productCount, orderAmount, orderDatetime, recipientName, occasionPhrase, senderName, orderNote) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(itemOrderSql, PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, order.getProductIndex());
			pstmt.setInt(2, order.getProductCount());
			pstmt.setInt(3, order.getOrderAmount());
			pstmt.setString(4, order.getOrderDatetime());
			pstmt.setString(5, order.getRecipientName());
			pstmt.setString(6, order.getOccasionPhrase());
			pstmt.setString(7, order.getSenderName());
			pstmt.setString(8, order.getOrderNote());
			pstmt.executeUpdate();
			
			// 생성된 orderIndex 가져오기
			rs = pstmt.getGeneratedKeys();
			int orderIndex = 0;
			if(rs.next()) {
				orderIndex = rs.getInt(1);
			}
			
			// delivery 테이블에 삽입
			String deliverySql = "INSERT INTO delivery (orderIndex, deliveryDatetime, deliveryAddress1, deliveryAddress2, receiverNumber1, receiverNumber2, receiverNumber3, receiverPhoneNumber1, receiverPhoneNumber2, receiverPhoneNumber3) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(deliverySql);
			pstmt.setInt(1, orderIndex);
			pstmt.setString(2, order.getDeliveryDatetime());
			pstmt.setString(3, order.getDeliveryAddress1());
			pstmt.setString(4, order.getDeliveryAddress2());
			pstmt.setString(5, order.getReceiverNumber1());
			pstmt.setString(6, order.getReceiverNumber2());
			pstmt.setString(7, order.getReceiverNumber3());
			pstmt.setString(8, order.getReceiverPhoneNumber1());
			pstmt.setString(9, order.getReceiverPhoneNumber2());
			pstmt.setString(10, order.getReceiverPhoneNumber3());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			finallyClose();
		}
	}
	
	public ArrayList<Order> getOrderList() {
		ArrayList<Order> orderList = new ArrayList<Order>();
		
		try {
			conn = dataSource.getConnection();
			
			String itemOrderSql = "SELECT i.orderIndex, i.productIndex, d.deliveryDatetime, d.deliveryAddress1, i.senderName FROM itemorder i JOIN delivery d ON i.orderIndex = d.orderIndex ORDER BY orderIndex DESC";
			pstmt = conn.prepareStatement(itemOrderSql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Order order = new Order();
				
				order.setOrderIndex(rs.getInt(1));
				order.setProductIndex(rs.getInt(2));
				order.setDeliveryDatetime(rs.getString(3));
				order.setDeliveryAddress1(rs.getString(4));
				order.setSenderName(rs.getString(5));
				
				String productSql = "SELECT p.productName, p.productUnitPrice FROM product p WHERE p.productIndex = ?";
				pstmt = conn.prepareStatement(productSql);
				pstmt.setInt(1, order.getProductIndex());
				ResultSet productRs = pstmt.executeQuery();
				
				if(productRs.next()) {
					order.setProductName(productRs.getString(1));
					order.setProductUnitPrice(productRs.getInt(2));
				}
				
				orderList.add(order);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			finallyClose();
		}
		
		return orderList;
	}
	
	public Order getOrderDetailInfo(int orderIndex) {
		Order order = new Order();
		
		try {
			conn = dataSource.getConnection();
			
			String itemDetailSql = "SELECT i.productIndex, i.productCount, i.occasionPhrase, i.senderName, d.deliveryAddress1, d.deliveryAddress2, d.receiverNumber1, d.receiverNumber2, d.receiverNumber3, d.receiverPhoneNumber1, d.receiverPhoneNumber2, d.receiverPhoneNumber3, d.deliveryDatetime, i.orderNote, i.orderDatetime, i.recipientName, i.orderAmount FROM itemorder i JOIN delivery d ON i.orderIndex = d.orderIndex WHERE i.orderIndex = ?";
			pstmt = conn.prepareStatement(itemDetailSql);
			pstmt.setInt(1, orderIndex);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				order.setProductIndex(rs.getInt(1));
				order.setProductCount(rs.getInt(2));
				order.setOccasionPhrase(rs.getString(3));
				order.setSenderName(rs.getString(4));
				order.setDeliveryAddress1(rs.getString(5));
				order.setDeliveryAddress2(rs.getString(6));
				order.setReceiverNumber1(rs.getString(7));
				order.setReceiverNumber2(rs.getString(8));
				order.setReceiverNumber3(rs.getString(9));
				order.setReceiverPhoneNumber1(rs.getString(10));
				order.setReceiverPhoneNumber2(rs.getString(11));
				order.setReceiverPhoneNumber3(rs.getString(12));
				order.setDeliveryDatetime(rs.getString(13));
				order.setOrderNote(rs.getString(14));
				order.setOrderDatetime(rs.getString(15));
				order.setRecipientName(rs.getString(16));
				order.setOrderAmount(rs.getInt(17));
			}
			
			String productDetailSql = "SELECT p.productIndex, p.productName, p.productUnitPrice FROM product p JOIN itemorder i ON i.productIndex = p.productIndex WHERE i.productIndex = ?";
			pstmt = conn.prepareStatement(productDetailSql);
			pstmt.setInt(1, order.getProductIndex());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				order.setProductIndex(rs.getInt(1));
				order.setProductName(rs.getString(2));
				order.setProductUnitPrice(rs.getInt(3));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			finallyClose();
		}
		
		return order;
	}
	
	public int getAllCount() {
		int count = 0;
		
		try {
			conn = dataSource.getConnection();
			
			String sql = "SELECT COUNT(*) FROM itemorder";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			finallyClose();
		}
		
		return count;
	}
	
	public List<Order> searchProducts(String productName) {
		List<Order> productList = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			
			String sql = "SELECT productIndex, productName, productUnitPrice FROM product WHERE productName LIKE ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + productName + "%");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Order product = new Order();
				
				product.setProductIndex(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setProductUnitPrice(rs.getInt(3));
				
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			finallyClose();
		}
		
		return productList;
	}
}
