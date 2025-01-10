package com.myspring.test.UserStore;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserStoreDAO {

	@Autowired(required=true)
	DataSource dataSource;
	
	Connection conn;
	PreparedStatement pst;
	ResultSet rs;
	
	public void finallyClose() {
		try {
			if (pst != null) { pst.close();}
			if (conn != null) { conn.close(); }
			if (rs != null) { rs.close(); }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public int checkUserStoreId(String id) {
		int check=1;
		try {
			conn=dataSource.getConnection();
			String sql=" SELECT * FROM userstore WHERE storeID=? ";
			pst= conn.prepareStatement(sql);
			pst.setString(1, id);
			rs=pst.executeQuery();
			if(rs.next()) {
				check=-1;
				System.out.println("아이디 중복 check:"+check);
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
	}
	public void userJoin(UserStore userstore) {
		try {
			conn=dataSource.getConnection();
			String sql="INSERT INTO userstore (storeID, storePW, storeName, storePhone1, storePhone2, storePhone3, storeMobile1, storeMobile2, storeMobile3, storeMap) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?,?)";
			pst=conn.prepareStatement(sql);
			
			pst.setString(1, userstore.getStoreID());
			pst.setString(2, userstore.getStorePW());
			pst.setString(3, userstore.getStoreName());
			pst.setString(4, userstore.getStorePhone1());
			pst.setString(5, userstore.getStorePhone2());
			pst.setString(6, userstore.getStorePhone3());
			pst.setString(7, userstore.getStoreMobile1());
			pst.setString(8, userstore.getStoreMobile2());
			pst.setString(9, userstore.getStoreMobile3());
			pst.setString(10, userstore.getStoreMap());
			pst.executeUpdate();
			
			System.out.println("회원가입성공");
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		
	}
	public int fineUserStoreId(UserStore userstore) {
		int check= -1;
		try {
			conn=dataSource.getConnection();
			String sql=" SELECT storeID FROM userstore WHERE storeName=? AND storePhone1=? AND storePhone2=? AND storePhone3=? ";
			pst= conn.prepareStatement(sql);
			pst.setString(1, userstore.getStoreName());
			pst.setString(2, userstore.getStorePhone1());
			pst.setString(3, userstore.getStorePhone2());
			pst.setString(4, userstore.getStorePhone3());
			rs= pst.executeQuery();
			if (rs.next()) {
				check=1;
				userstore.setStoreID(rs.getString("storeID"));
				System.out.println("id:"+userstore.getStoreID());
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
	}
	public int findStorePw(UserStore userstore) {
		int check=-1;
		try {
			conn=dataSource.getConnection();
			String sql=" SELECT storePW FROM userstore WHERE storeID=? AND storeName=? AND storePhone1=? AND storePhone2=? AND storePhone3=? ";
			pst= conn.prepareStatement(sql);
			pst.setString(1, userstore.getStoreID());
			pst.setString(2, userstore.getStoreName());
			pst.setString(3, userstore.getStorePhone1());
			pst.setString(4, userstore.getStorePhone2());
			pst.setString(5, userstore.getStorePhone3());
			rs= pst.executeQuery();
			if (rs.next()) {
				check=1;
				userstore.setStorePW(rs.getString("storePW"));
				System.out.println("pw:"+userstore.getStorePW());
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
	}
	public int loginStoreIdPw(UserStore userstore) {
		int check=-1;
		try {
			conn=dataSource.getConnection();
			String sql=" SELECT storeName FROM userstore WHERE storeID=? AND storePW=? ";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userstore.getStoreID());
			pst.setString(2, userstore.getStorePW());
			rs=pst.executeQuery();
			if (rs.next()) {
				check=1;
				userstore.setStoreName(rs.getString("storeName"));
				System.out.println("name:"+userstore.getStoreName());
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
	}
}

