<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<% request.setCharacterEncoding("utf-8");%>

<% 
   String id = request.getParameter("id");
   String pw= request.getParameter("pw");
   String pwCheck = request.getParameter("pwCheck");
   Timestamp register=new Timestamp(System.currentTimeMillis());
   


   Connection conn=null;
   PreparedStatement pstmt=null;
   String str="";
   try{
	   String jdbcUrl = "jdbc:mysql://localhost:3306/coronainside?serverTimezone=UTC";
	   String dbId = "root";
	   String dbPass = "a1786511!";
 	 
 	 Class.forName("com.mysql.jdbc.Driver");
 	 conn=DriverManager.getConnection(jdbcUrl,dbId ,dbPass );
 	
 	 String sql= "insert into user values (?,?)";
 	 pstmt=conn.prepareStatement(sql);
 	 pstmt.setString(1,id);
     pstmt.setString(2,pw);
 	 pstmt.executeUpdate();
 	 
 	 
 	 
 	 System.out.println("member 테이블에 새로운 레코드를 추가했습니다.");
 	 out.println("<script>alert('회원가입되었습니다');");
 	 out.println("window.location.href='login'</script>");
 	 
 	 //response.sendRedirect("login");
	 
 	 
 	}catch(Exception e){ 
 		e.printStackTrace();
 		System.out.println("member 테이블에 새로운 레코드를 추가에 실패했습니다");
 	}finally{
 		if(pstmt != null) 
 			try{pstmt.close();}catch(SQLException sqle){}
 		if(conn != null) 
 			try{conn.close();}catch(SQLException sqle){}
 	}
 %>