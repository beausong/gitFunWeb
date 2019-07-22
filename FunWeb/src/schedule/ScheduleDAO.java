package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import schedule.ScheduleBean;


public class ScheduleDAO {
	
		// finally문에서 정리해줄 변수 미리 지정
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		
		//-------------------------------------------------------------------
		// 커넥션 풀 : 서버에 DB 연결정보 저장
		private Connection getConnection() throws Exception {
			
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");
			Connection con = ds.getConnection();
			
			return con;		
		}	
		
		
		//-------------------------------------------------------------------	
		public void insertSchedule(ScheduleBean sb) {
			
			try {
				
				// DB 연결
				con = getConnection();

				int num = 0;
				
				// num 구하기 : 등록되어 있는 글번호 중 가장 큰 번호에 +1을 해준다
				sql = "SELECT max(num) FROM schedule";
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					sb.setNum(rs.getInt("max(num)")+1);
					num = sb.getNum();
				}
				
				// 3. schedule의 모든 데이터를 가져와 num 기준으로 내림차순 정렬
				
				// 3. 게시판에 입력한 값들을 DB에 저장하기
				sql = "INSERT INTO schedule(num,id,subject,content,readcount,date,file) VALUES(?,?,?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				pstmt.setString(2, sb.getId());
				pstmt.setString(3, sb.getSubject());
				pstmt.setString(4, sb.getContent());
				pstmt.setInt(5, 0);  // readcount 조회수 0
				pstmt.setString(6, sb.getFile());
				
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
		}
		
		//-------------------------------------------------------------------	
		public int getScheduleCount() {
			int count=0;
			
			try {
				// DB 연결
				con = getConnection();
				
				// sql
				sql = "SELECT count(*) FROM schedule";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				// 게시판 글의 총 개수 리턴
				if(rs.next()) {
					count = rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
			return count;
		}
		
		//-------------------------------------------------------------------
		public int getScheduleCount2(String search) {

			int count=0;
			
			try {
				// DB 연결
				con=getConnection();
				
				// 조건 num에 해당하는 게시판글 가져오기
				String sql="SELECT count(*) FROM schedule WHERE subject LIKE ?";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					count=rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
			return count;
		}
		
		
		
		//-------------------------------------------------------------------	
		// 게시판의 전체 글을 리턴
		public List getScheduleList() {    
			
			// 리턴해줄 List 타입 변수 선언 
			List scheduleList = new ArrayList();
			
			try {
				
				// DB 연결
				con = getConnection();
				
				// schedule의 모든 데이터를 가져와 num 기준으로 내림차순 정렬
				sql = "SELECT * FROM schedule ORDER BY num DESC";
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				// scheduleList 에 sb 들을 저장
				while(rs.next()) {
					
					// ScheduleBean sb 객체 생성
					ScheduleBean sb = new ScheduleBean();
					
					sb.setNum(rs.getInt("num"));
					sb.setId(rs.getString("id"));
					sb.setSubject(rs.getString("subject"));
					sb.setContent(rs.getString("content"));
					sb.setDate(rs.getDate("date"));
					sb.setReadcount(rs.getInt("readcount"));
					
					scheduleList.add(sb);  
				}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
			// List 타입의 변수 ScheduleList 배열 리턴
			return scheduleList; 
		}

		
		//-------------------------------------------------------------------	
		// 한 페이지에 띄울 개수만큼의 게시판 글만 선택해서 리턴
		public List getScheduleList(int startRow, int pageSize) {  
			
			List scheduleList = new ArrayList();
			
			try {
				
				// DB 연결
				con = getConnection();
				
				// Schedule의 모든 데이터를 가져와 num 기준으로 내림차순 정렬
				// mysql에만 있는 명령문  "LIMIT 시작행-1, 글의 개수"  
				//  => 시작행부터 글의 개수만큼 자르겠다 (LIMIT은 시작행을 포함하지 않고 다음부터 자르기 때문에 -1 필요)
				sql = "SELECT * FROM schedule ORDER BY num DESC LIMIT ?, ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
					
					// 글 하나에 포함된 데이터들을  scheduleBean 객체에 저장
					ScheduleBean sb = new ScheduleBean();
					
					sb.setNum(rs.getInt("num"));
					sb.setId(rs.getString("id"));
					sb.setSubject(rs.getString("subject"));
					sb.setContent(rs.getString("content"));
					sb.setDate(rs.getDate("date"));
					sb.setFile(rs.getString("file"));
					sb.setReadcount(rs.getInt("readcount"));
					
					// scheduleList 에 sb 들을 저장
					scheduleList.add(sb);
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
			// List 타입의 변수 ScheduleList 배열 리턴
			return scheduleList; 
		}
		
		
		//-------------------------------------------------------------------	
		//getScheduleList()
		public List getScheduleList(int startRow,int pageSize,String search) {
			
			List scheduleList = new ArrayList();
			
			try {
				// DB 연결
				con=getConnection();
				
				// schedule 모든데이터 가져오기 정렬 num 기준 내림차순
				// String sql="select * from schedule order by num desc limit 시작행-1,글개수";
				// String sql="select * from schedule where subject like '%검색어%' order by num desc limit ?,?";
				String sql="select * from schedule where subject like ? order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2,startRow-1);
				pstmt.setInt(3, pageSize);
				
				rs=pstmt.executeQuery();
				
				// 한 개글 ScheduleBean => 배열한칸 저장
				while(rs.next()) {
					ScheduleBean sb=new ScheduleBean();
					sb.setNum(rs.getInt("num"));
					sb.setId(rs.getString("id"));
					sb.setSubject(rs.getString("subject"));
					sb.setContent(rs.getString("content"));
					sb.setDate(rs.getDate("date"));
					sb.setFile(rs.getString("file"));
					sb.setReadcount(rs.getInt("readcount"));
					
					scheduleList.add(sb);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
			return scheduleList;
		}	
		
		//-------------------------------------------------------------------	
		public ScheduleBean getSchedule(int num) {
			
			ScheduleBean sb = new ScheduleBean();
			
			try {
				// 1. DB 연결
				con = getConnection();
				
				sql = "SELECT * FROM schedule WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {

					sb.setNum(rs.getInt("num"));
					sb.setId(rs.getString("id"));
					sb.setSubject(rs.getString("subject"));
					sb.setContent(rs.getString("content"));
					sb.setDate(rs.getDate("date"));
					sb.setReadcount(rs.getInt("readcount"));	
					sb.setFile(rs.getString("file"));
				}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
			return sb;
		}		
		
		//-------------------------------------------------------------------
		public void updateSchedule(ScheduleBean sb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				//1단계 드라이버로더 //2단계 디비연결
				con=getConnection();
				//3단계 insert
				String sql="update schedule set subject=?,content=?,file=? where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, sb.getSubject());
				pstmt.setString(2, sb.getContent());
				pstmt.setString(3, sb.getFile());
				pstmt.setInt(4, sb.getNum());
				//4단계 실행
				pstmt.executeUpdate();
				
				System.out.println("성공");
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
		}
		
		//-------------------------------------------------------------------
		public void deleteSchedule(int num) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			
			try {
				//1단계 드라이버로더 //2단계 디비연결
				con=getConnection();
				
				//3단계 insert
				String sql="delete from Schedule where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				//4단계 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				//예외상관없이 마무리(기억장소정리)
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
		}
		
		//-------------------------------------------------------------------
		public void updateReadconut(int num) {
			
			try {
				// 1. DB 연결
				con = getConnection();
				
				// 2. readcont 1씩 증가하도록 UPDATE sql문 작성
				sql = "UPDATE schedule SET readcount=readcount+1 WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				System.out.println("성공");
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
				if(con != null) try {con.close();} catch(SQLException ex) {}
				if(rs != null) try {rs.close();} catch(SQLException ex) {}
			}
		}
		

}
