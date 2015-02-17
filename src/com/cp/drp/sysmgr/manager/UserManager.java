package com.cp.drp.sysmgr.manager;

import java.sql.*;

import com.cp.drp.sysmgr.domain.User;
import com.cp.drp.util.DBUtil;


/**
 * �û�������
 * @author john
 *
 */
public class UserManager {
	
	//����ʽ
	/*private static UserManager instance = new UserManager();
	private UserManager() {};
	public static UserManager getInstance() {
		return instance;
	}*/
	
	//����ʽ
	private static UserManager instance = null;
	private UserManager() {};
	public static synchronized UserManager getInstance() {
		if(instance == null) {
			instance = new UserManager();
		}
		return instance;
	}
	
	/**
	 * ����û�
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
			pstmt.setTimestamp(6, new Timestamp(user.getCreateDate().getTime()));//ע��Timestamp
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.err.println("����û�ʧ��" + e);
			e.printStackTrace();
		} finally {
			//����guanbi
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
				
	}
	
	/**
	 * �����û�Id��ѯ
	 * @param userId
	 * @return ������ڷ���user���󣬷��򷵻�null
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
			//�����û���Ϣ
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
