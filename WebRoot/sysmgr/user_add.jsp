<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<%@ page import="com.cp.drp.sysmgr.domain.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.cp.drp.sysmgr.manager.*" %>

<%		
		request.setCharacterEncoding("GB18030");
		String command = request.getParameter("command");
		//out.println("command="+command);
		String userId = "";
		String userName = "";
		String password = "";
		String contactTel = "";
		String email = "";
		
		if("add".equals(command)) {
			
			if(UserManager.getInstance().findById(request.getParameter("userId")) == null) {
				
						
				User user = new User();
				user.setUserId(request.getParameter("userId"));
				user.setUserName(request.getParameter("userName"));
				user.setPassword(request.getParameter("password"));
				user.setContactTel(request.getParameter("contactTel"));
				user.setEmail(request.getParameter("email"));
				user.setCreateDate(new Date());
				
				UserManager.getInstance().addUser(user); 
				out.println("添加成功！！");
			} else {
				userId = request.getParameter("userId");
				userName = request.getParameter("userName");
				password = request.getParameter("password");
				contactTel = request.getParameter("contactTel");
				email = request.getParameter("email");
				out.println("用户代码重复，代码=【" + request.getParameter("userId") + "】");
			}
		}
		
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>添加用户</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script src="../script/client_validate.js"></script>
		<script type="text/javascript">
	function goBack() {
		window.self.location="user_maint.html"
	}
	
	function addUser() {
		var userIdField = document.getElementById("userId");
		//用户代码不能为空
		if(trim(userIdField.value)=="") {
			alert("用户代码不能为空！！");
			userIdField.focus();
			return;
		}
		//用户代码至少4个字符
		/*if((trim(userIdField.value)).length < 4) {
			alert("用户代码至少4个字符！！");
			userIdField.focus();
			return;
		}
		*/
		//用户代码首字符必须为字母
		/*if(!((trim(userIdField.value)).charAt(0) >= 'a' &&
			(trim(userIdField.value)).charAt(0) <= 'z' ||
			(trim(userIdField.value)).charAt(0) >= 'A' &&
			(trim(userIdField.value)).charAt(0) <= 'Z')) {
			alert("用户代码首字符必须为字母!!");
			userIdField.focus();
			return;
		}
		*/
		//用正则表达是判断用户代码首字符必须为字母
		var re = new RegExp(/^[a-zA-Z]/);
		if(!re.test(trim(userIdField.value))) {
			alert("用户代码首字符必须为字母!!");
			userIdField.focus();
			return;
		}
		//用户代码必须是数字或字母，字符个数必须是4-6位
		re.compile(/^[a-zA-Z0-9]{4,6}$/);
		if(!re.test(trim(userIdField.value))) {
			alert("用户代码必须是数字或字母，字符个数必须是4-6位！！");
			userIdField.focus();
			return;
		}
		
		//用户名称不能为空
		var userNameField = document.getElementById("userName");
		if(trim(userNameField.value).length == 0) {
			alert("用户名称不能为空！！");
			userNameField.focus();
			return;
		}
		
		var passworldField = document.getElementById("password");
		if(trim(passworldField.value).length < 6) {
			alert("密码不能少于6位！！");
			passworldField.focus();
			return;
		}
		
		//电话号码有的话，必须是数字且位数的7-11位
		re.compile(/^[0-9]{7,11}$/);
		var contactTelField = document.getElementById("contactTel");
		if(trim(contactTelField.value).length > 0) {
			if(!re.test(trim(contactTelField.value))) {
				alert("电话号码有的话，必须是数字且位数是7-11位！！");
				contactTelField.focus();
				return;
			}
		}
		
		re.compile(/^(\w)+(\.\w+)*@(\w)+/);
		var emailField = document.getElementById("email");
		if(trim(emailField.value).length > 0) {
			if(!re.test(trim(emailField.value))) {
				alert("请输入正确的E-mail地址！！");
				emailField.focus();
				return;
			}
		}
		
		//取得form对象提交表单
		/*
		document.getElementById("userForm").method="post";
		document.getElementById("userForm").action="user_add.jsp";
		document.getElementById("userForm").submit();
		*/
		
		//效果同上
		with(document.getElementById("userForm")) {
			method="post";
			action="user_add.jsp?command=add";
			submit();
		}
	}
	
	function init() {
		document.getElementById("userId").focus();
	}
	
	function userIdOnKeyPress() {
		if(!((event.keyCode >= 48 && event.keyCode <= 57)||(event.keyCode >= 97 && event.keyCode <= 122))) {
			event.keyCode = 0;
		}
	}
	
	//Ajax
	var xmlHTTP;
	function createXMLHttpRequest() {
		if(window.XMLHttpRequest) {
			xmlHTTP = new XMLHttpRequest;
		} else if(window.ActiveXObject) {
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
	function validate(field) {
		//alert(document.getElementById("userId").value);
		//alert(field.value);
		if(trim(field.value).length != 0) {
			//创建XMLHttpRequest
			createXMLHttpRequest();
			var url = "user_validate.jsp?userId=" + trim(field.value) + "&timestamp = " + new Date().getTime();
			//alert(url);
			xmlHTTP.open("GET", url, true);
			//方法地址，处理完成后自动调用，回调
			xmlHTTP.onreadystatechange=callback;
			//将参数发挥到Ajax引擎
			xmlHTTP.send(null);
		} else {
			document.getElementById("userIdSpan").innerHTML = "";
		}
	}
	
	function callback() {
		if(xmlHTTP.readyState == 4) {
			if(xmlHTTP.status == 200) {
				//alert(xmlHTTP.responseText);
				document.getElementById("userIdSpan").innerHTML = "<font color='red'>" + xmlHTTP.responseText + "</font>";
			} else {
				alert("请求失败，错误吗 = " + xmlHTTP.status);
			}
		}
	}
	
	function document.onkeydown() {
		if(event.keyCode == 13 && event.srcElement.type != "button") {
			event.keyCode = 9;
		}
	}
	
	

</script>
	</head>

	<body class="body1" onload="init()">
		<form name="userForm" target="_self" id="userForm">
			<div align="center">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="25">
					<tr>
						<td width="522" class="p1" height="25" nowrap>
							<img src="../images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>系统管理&gt;&gt;用户维护&gt;&gt;添加</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>用户代码:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="userId" type="text" class="text1" id="userId"
								size="10" maxlength="10" onblur="validate(this)" onkeypress="userIdOnKeyPress()" 
								value="<%=userId %>" ><span id="userIdSpan"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>用户名称:&nbsp;
							</div>
						</td>
						<td>
							<input name="userName" type="text" class="text1" id="userName"
								size="20" maxlength="20" value=<%=userName %>>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>密码:&nbsp;
							</div>
						</td>
						<td>
							<label>
								<input name="password" type="password" class="text1"
									id="password" size="20" maxlength="20" value=<%=password %>>
									
							</label>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								联系电话:&nbsp;
							</div>
						</td>
						<td>
							<input name="contactTel" type="text" class="text1"
								id="contactTel" size="20" maxlength="20" value=<%=contactTel %>>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								email:&nbsp;
							</div>
						</td>
						<td>
							<input name="email" type="text" class="text1" id="email"
								size="20" maxlength="20" value=<%=email %>>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="添加" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onclick="goBack()" />
				</div>
			</div>
		</form>
	</body>
</html>
