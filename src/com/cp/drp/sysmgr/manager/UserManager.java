package com.cp.drp.sysmgr.manager;

import java.sql.*;

import com.cp.drp.sysmgr.domain.User;
import com.cp.drp.util.DBUtil;


/**
 * 用户管理类
 * @author john
 *
 */
public class UserManager {
	
	//饿汉式
	/*private static UserManager instance = new UserManager();
	private UserManager() {};
	public static UserManager getInstance() {
		return instance;
	}*/
	
	//懒汉式
	private static UserManager instance = null;
	private UserManager() {};
	public static synchronized UserManager getInstance() {
		if(instance == null) {
			instance = new UserManager();
		}
		return instance;
	}
	
	/**
	 * 添加用户
	 * @param user
	 */
	public void addUser(User user) {
		String sql = "insert into t_user(user_id, user_name, password, contact_tel," +
				"email, create_date) values(?, ?, ?, ?, ?, ?)";
		System.out.println("UserManager.addUser() user=" + user);
		System.out.println(sql);
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getConnection();
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getContactTel());
			pstmt.setString(5, user.getEmail());
			pstmt.setTimestamp(6, new Timestamp(user.getCreateDate().getTime()));//注意Timestamp
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.err.println("添加用户失败" + e);
			e.printStackTrace();
		} finally {
			//必须guanbi
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
				
	}
	
	/**
	 * 根据用户Id查询
	 * @param userId
	 * @return 如果存在返回user对象，否则返回null
	 */
	public User findById(String userId) {
		String sql = "select * from t_user where user_id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			//存在用户信息
			if(rs.next()) {
				user = new User();
				user.setUserId(rs.getString(1));
				user.setUserName(rs.getString(2));
				user.setPassword(rs.getString(3));
				user.setContactTel(rs.getString(4));
				user.setEmail(rs.getString(5));
				user.setCreateDate(rs.getTimestamp(6));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
		return user;
	}

}
