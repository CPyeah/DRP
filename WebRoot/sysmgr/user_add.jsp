<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>�����û�</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script src="../script/client_validate.js"></script>
		<script type="text/javascript">
	function goBack() {
		window.self.location="user_maint.html"
	}
	
	function addUser() {
		var userIdField = document.getElementById("userId");
		//�û����벻��Ϊ��
		if(trim(userIdField.value)=="") {
			alert("�û����벻��Ϊ�գ���");
			userIdField.focus();
			return;
		}
		//�û���������4���ַ�
		/*if((trim(userIdField.value)).length < 4) {
			alert("�û���������4���ַ�����");
			userIdField.focus();
			return;
		}
		*/
		//�û��������ַ�����Ϊ��ĸ
		/*if(!((trim(userIdField.value)).charAt(0) >= 'a' &&
			(trim(userIdField.value)).charAt(0) <= 'z' ||
			(trim(userIdField.value)).charAt(0) >= 'A' &&
			(trim(userIdField.value)).charAt(0) <= 'Z')) {
			alert("�û��������ַ�����Ϊ��ĸ!!");
			userIdField.focus();
			return;
		}
		*/
		//������������ж��û��������ַ�����Ϊ��ĸ
		var re = new RegExp(/^[a-zA-Z]/);
		if(!re.test(trim(userIdField.value))) {
			alert("�û��������ַ�����Ϊ��ĸ!!");
			userIdField.focus();
			return;
		}
		//�û�������������ֻ���ĸ���ַ�����������4-6λ
		re.compile(/^[a-zA-Z0-9]{4,6}$/);
		if(!re.test(trim(userIdField.value))) {
			alert("�û�������������ֻ���ĸ���ַ�����������4-6λ����");
			userIdField.focus();
			return;
		}
		
		//�û����Ʋ���Ϊ��
		var userNameField = document.getElementById("userName");
		if(trim(userNameField.value).length == 0) {
			alert("�û����Ʋ���Ϊ�գ���");
			userNameField.focus();
			return;
		}
		
		var passworldField = document.getElementById("password");
		if(trim(passworldField.value).length < 6) {
			alert("���벻������6λ����");
			passworldField.focus();
			return;
		}
		
		//�绰�����еĻ���������������λ����7-11λ
		re.compile(/^[0-9]{7,11}$/);
		var contactTelField = document.getElementById("contactTel");
		if(trim(contactTelField.value).length > 0) {
			if(!re.test(trim(contactTelField.value))) {
				alert("�绰�����еĻ���������������λ����7-11λ����");
				contactTelField.focus();
				return;
			}
		}
		
		re.compile(/^(\w)+(\.\w+)*@(\w)+/);
		var emailField = document.getElementById("email");
		if(trim(emailField.value).length > 0) {
			if(!re.test(trim(emailField.value))) {
				alert("��������ȷ��E-mail��ַ����");
				emailField.focus();
				return;
			}
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
							<b>ϵͳ����&gt;&gt;�û�ά��&gt;&gt;����</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="userId" type="text" class="text1" id="userId"
								size="10" maxlength="10" onkeypress="userIdOnKeyPress()">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
							</div>
						</td>
						<td>
							<input name="userName" type="text" class="text1" id="userName"
								size="20" maxlength="20">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>����:&nbsp;
							</div>
						</td>
						<td>
							<label>
								<input name="password" type="password" class="text1"
									id="password" size="20" maxlength="20">
							</label>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								��ϵ�绰:&nbsp;
							</div>
						</td>
						<td>
							<input name="contactTel" type="text" class="text1"
								id="contactTel" size="20" maxlength="20">
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
								size="20" maxlength="20">
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="����" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onclick="goBack()" />
				</div>
			</div>
		</form>
	</body>
</html>