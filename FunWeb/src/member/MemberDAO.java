package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import member.MemberBean;

public class MemberDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
		
	
	// DB 연결
	private Connection getConnection() throws Exception {
			
		// 커넥션 풀 => 서버에 연결정보 저장하기 : 자원 효율 증가
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");
		Connection con = ds.getConnection();
		
		return con;
	}
	
	
	// 회원가입시 id 중복 체크
	public int idCheck(String id) {
		
		int check = -1;
		
		try {
			// DB 연결
			con = getConnection();
			
			// sql
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
		
			if(rs.next()) {  
				check = 1;  // id 중복됨
			}else {  
				check = 0;  // id 중복안됨
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		
		return check;
	}
	


	// 회원가입
	public void insertMember(MemberBean mb) {  

		try {
			
			// DB 연결
			con = getConnection();
			
			// sql
			String sql = "insert into member(id, pass, name, age, phone, mobile, email, address, reg_date) values(?,?,?,?,?,?,?,?,?);";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setInt(4, mb.getAge());
			pstmt.setString(5, mb.getPhone());
			pstmt.setString(6, mb.getMobile());
			pstmt.setString(7, mb.getEmail());
			pstmt.setString(8, mb.getAddress());
			pstmt.setTimestamp(9, mb.getReg_date());
			
			// 4. sql 실행
			pstmt.executeUpdate();
			
		} catch (Exception e) {  // 오류 위치 추적 출력
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		
	} 
	
	
	// 로그인, 회원정보 수정
	public int userCheck(String id, String pass) {
		
		int check=0;
		
		try {
			// DB 연결
			con = getConnection();
						
			// 3. sql
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
		
		if(rs.next()) {  // id 일치
				if(pass.equals(rs.getString("pass"))) {
					check = 1;   // 비밀번호 일치
				}else if(!(pass.equals(rs.getString("pass")))) {
					check = 0;   // 비밀번호 일치 안함
				}
			}else {  
				check = -1;  // id 일치안함
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return check;
	} 
	
	
	// 회원정보 info
	public MemberBean getMember(String id) {
		
		MemberBean mb = null;  
		
		try {
			// DB 연결
			con = getConnection();
			
			// 3. sql
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mb = new MemberBean(); 
				
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setAge(rs.getInt("age"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs!=null) try {pstmt.close();} catch(SQLException ex) {}
		}
		return mb;
	}
	
	
	
	// 회원정보 수정
	public void updateMember(MemberBean mb) {
		
		try {
			// DB 연결
			con = getConnection();
			
			// 3. sql - UPDATE
			
			String sql = "UPDATE member SET name=?, age=?, email=?, phone=?, mobile=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mb.getName());
			pstmt.setInt(2, mb.getAge());
			pstmt.setString(3, mb.getEmail());
			pstmt.setString(4, mb.getPhone());
			pstmt.setString(5, mb.getMobile());
			pstmt.setString(6, mb.getId());
		
			// 4. sql 실행
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {		
			e.printStackTrace();
			
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {pstmt.close();} catch(SQLException ex) {}
		}
		
	} 

	// 탈퇴 (회원 삭제)
	public void deleteMember(String id) {
		
		try {
			// DB 연결
			con = getConnection();
			
			// 3. sql - DELETE
			String sql = "DELETE FROM member WHERE id=?";
				pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			// 4. sql 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(con!=null) try {pstmt.close();} catch(SQLException ex) {}
		}
	} 
	
	
	// 회원목록
	public List getMemberList() {
		
		List memberList = new ArrayList();
		
		try {
			// DB 연결
			con = getConnection();
						
			// sql
			String sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			
			// sql 실행, 실행결과 저장
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
					
				// 자바빈 MemberBean mb에 회원 1명의 정보들을 저장
				MemberBean mb = new MemberBean();
				
	 			mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setAge(rs.getInt("age"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
			
				// List 배열 한 칸에 회원 1명에 대한 mb를 저장
				memberList.add(mb);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return memberList;
	} 
	

}
