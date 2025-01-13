package com.myspring.test.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {
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
}
