<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="com.cp.drp.sysmgr.manager.*"%>

<%
	//out.println("hello!");
	//Thread.currentThread().sleep(3000);
	String userId = request.getParameter("userId");
	if(UserManager.getInstance().findById(userId) != null) {
		out.println("用户代码已存在");
	}
	
 %>	
	
