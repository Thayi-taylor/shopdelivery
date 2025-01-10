package com.myspring.test.UserDriver;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDriverDAO {
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
	public int checkUserDriverID(String id) {
		int check=1;
		int count=0;
		try {
			conn=dataSource.getConnection();
			String spl=" SELECT * FROM userDriver WHERE driverID=? ";
			pst= conn.prepareStatement(spl);
			pst.setString(1, id);
			rs=pst.executeQuery();
			if (rs.next()) {
				check=-1;
				count=rs.getInt(count);
				System.out.println("중복아이디 존재 check: COUNT:"+check+","+count);
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
	}
	public void DriverJoin(UserDriver userdriver) {
	    try {
	        conn = dataSource.getConnection();
	        // 7개의 값을 삽입하는 SQL 쿼리
	        String sql = "INSERT INTO userDriver (driverID, driverPW, driverName, driverMobile1, driverMobile2, driverMobile3, driverAvailavleArea) VALUES(?,?,?,?,?,?,?)";
	        pst = conn.prepareStatement(sql);
	        
	        // 각 인덱스에 맞게 값을 설정
	        pst.setString(1, userdriver.getDriverID());
	        pst.setString(2, userdriver.getDriverPW());
	        pst.setString(3, userdriver.getDriverName());
	        pst.setString(4, userdriver.getDriverMobile1());
	        pst.setString(5, userdriver.getDriverMobile2());
	        pst.setString(6, userdriver.getDriverMobile3());
	        pst.setString(7, userdriver.getDriverAvailableArea());  // 이 부분이 7번째 물음표에 대응
	        
	        // SQL 실행
	        pst.executeUpdate();
	        System.out.println("회원가입완료");
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        finallyClose();
	    }
	}

	public int loginDriverIDPW(UserDriver userdriver) {
		int check=-1;
		try {
			conn=dataSource.getConnection();
			String sql=" SELECT driverName FROM userDriver WHERE driverID=? AND driverPW=? ";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userdriver.getDriverID());
			pst.setString(2, userdriver.getDriverPW());
			rs=pst.executeQuery();
			if (rs.next()) {
				check=1;
				userdriver.setDriverName(rs.getString("driverName"));
				System.out.println("name:"+userdriver.getDriverName());
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
	}
	public int findDriverID(UserDriver userdriver) {
		int check=-1;
		try {
			conn=dataSource.getConnection();
			String sql=" SELECT driverID FROM userDriver WHERE driverName=? AND driverMobile1=? AND driverMobile2=? AND driverMobile3=? ";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userdriver.getDriverName());
			pst.setString(2, userdriver.getDriverMobile1());
			pst.setString(3, userdriver.getDriverMobile2());
			pst.setString(4, userdriver.getDriverMobile3());
			rs=pst.executeQuery();
			if (rs.next()) {
				check=1;
				userdriver.setDriverID(rs.getString("driverID"));
				System.out.println("driverID:"+userdriver.getDriverID());
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
	}
	public int findDriverPw(UserDriver userdriver) {
		int check=-1;
		try {
			conn=dataSource.getConnection();
			String sql=" SELECT driverPW FROM userDriver WHERE driverID=? AND  driverName=? AND driverMobile1=? AND driverMobile2=? AND driverMobile3=? ";
			pst=conn.prepareStatement(sql);
			pst.setString(1, userdriver.getDriverID());
			pst.setString(2, userdriver.getDriverName());
			pst.setString(3, userdriver.getDriverMobile1());
			pst.setString(4, userdriver.getDriverMobile2());
			pst.setString(5, userdriver.getDriverMobile3());
			rs=pst.executeQuery();
			if (rs.next()) {
				check=1;
				userdriver.setDriverPW(rs.getString("driverPW"));
				System.out.println("userdriver.pw:"+userdriver.getDriverPW());
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			finallyClose();
		}
		return check;
		
	}
	
}
