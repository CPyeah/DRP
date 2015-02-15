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
				"contact_tel, email, create_date) values(?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getContactTel());
			pstmt.setString(5, user.getEmall());
			pstmt.setTimestamp(6, new Timestamp(user.getCreateDate().getTime()));//注意Timestamp
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO: handle exception
		} finally {
			//必须guanbi
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
				
	}

}
