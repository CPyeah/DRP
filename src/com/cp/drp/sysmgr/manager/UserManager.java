package com.cp.drp.sysmgr.manager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.cp.drp.sysmgr.domain.User;
import com.cp.drp.util.DBUtil;
import com.cp.drp.util.PageModel;


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
				user.setUserId(rs.getString("user_id"));
				user.setUserName(rs.getString("user_name"));
				user.setPassword(rs.getString("password"));
				user.setContactTel(rs.getString("contact_tel"));
				user.setEmail(rs.getString("email"));
				user.setCreateDate(rs.getTimestamp("create_date"));
				
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
	
	/**
	 * 分页查询
	 * @param pageNo 第几页
	 * @param pageSize 每页多少条数据
	 * @return PageModel对象
	 */
	public PageModel<User> findAllUser(int pageNo, int pageSize) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append("select * from ( ")
				.append("select rownum rn , t.* from ( ")
					.append("select * from t_user where user_id <>'root' order by user_id ")
						.append(") t where rownum <=? ")
			.append(") where rn > ? ");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PageModel<User> pageModel = null;
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setInt(1, pageNo * pageSize);
			pstmt.setInt(2, (pageNo-1) * pageSize);
			rs = pstmt.executeQuery();
			List<User> userList = new ArrayList<User>();
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getString("user_id"));
				user.setUserName(rs.getString("user_name"));
				user.setPassword(rs.getString("password"));
				user.setContactTel(rs.getString("contact_tel"));
				user.setEmail(rs.getString("email"));
				user.setCreateDate(rs.getTimestamp("create_date"));
				userList.add(user);
			}
			pageModel = new PageModel<User>();
			pageModel.setList(userList);
			pageModel.setTotalRecords(getTotalRecords(conn));
			pageModel.setPageSize(pageSize);
			pageModel.setPageNo(pageNo);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
		return pageModel;
		
		/*PageModel p = new PageModel();
		p.setList(list);
		p.setTotalRecords(10);*/
	}
	
	/**
	 * 取得记录数
	 * @param conn
	 * @return 记录数
	 * @throws SQLException
	 */
	private int getTotalRecords(Connection conn) throws SQLException {
		String sql = "select count(*) from t_user where user_id <> 'root'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		
		return count;
	}
	/**
	 * 修改用户 
	 * @param user
	 */
	public void modifyUser(User user) {
		String sql = "update t_user set user_name=?, password=?, contact_tel=?, email=?" +
				"where user_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getContactTel());
			pstmt.setString(4, user.getEmail());
 			pstmt.setString(5, user.getUserId());
			pstmt.execute();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
			DBUtil.close(conn);
		}
	}
}
