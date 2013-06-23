<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page import ="cht.paas.hiair.sms.sdk.*"%>
<%@ page import ="cht.paas.hiair.sms.bean.*"%>
<%@ page import ="java.text.*"%>
<%@ page import ="java.io.*"%>
<%@ page import ="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title></title>
<%!  
final String strIsvAccount = "367f7deaa1ce47b185a0c91cb6d8f714";
final String strSdkSecretKey = "n+ABj+1w6e1Ht2A2ziBh0Q==";
String action = null;
SmsSDK sdk = null;
String strURL = null;
String strMsgid = null;
String strMsisdn = null;
String strMsg = null;
String result = "";
%>
</head>
<body>
<%
action = request.getParameter("action");
strMsisdn = request.getParameter("mobile");
strMsg = request.getParameter("msg");
if (action !=null && "DO".equalsIgnoreCase(action)) {
   sdk = new SmsSDK();
   strURL = SmsSDK.getRemoteServerBaseURL();
   SmsSDK.resetRemoteServerBaseURL(strURL);
   sdk.initIsvAccount(strIsvAccount, strSdkSecretKey);
   strMsgid = sdk.getSendService(strMsisdn, strMsg, null, 15);
   if (strMsgid != null) {
      result = "傳送 SMS 服務訊息成功，訊息識別碼：" + strMsgid; 
   } else {
      result = "傳送 SMS 服務訊息失敗：" + sdk.getErrMsg();      
   }
}
%>
<form name="smsform" action="index.jsp">
<input type="hidden" name="action" value="DO">
<table>
   <tr>
      <td>手機號碼</td>
      <td><input type="text" name="mobile" id="mobile"></input></td>
   </tr>
   <tr>
      <td>簡訊內容</td>
      <td><textarea rows="4" cols="50" name="msg"></textarea></input></td>
   </tr>
   <tr>
      <td>系統訊息</td>
      <td><textarea rows="4" cols="50" name="sysmsg"><%=result  %></textarea></td>
   </tr>
   <tr>
      <td><input type="submit"  value="Submit" class="button"></td>
      <td><input type="reset" value="Reset" class="button"></td>
   </tr>
</table>
</form>
</body>
</html>