package board;

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

public class BoardDAO {
	
	// finally문에서 정리해줄 변수 미리 지정
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
//-------------------------------------------------------------------	
	private Connection getConnection() throws Exception {
		
//		// jdbc 드라이버 로드
//		Class.forName("com.mysql.jdbc.Driver");
//		// DB 연결
//		String dbUrl = "jdbc:mysql://localhost:3306/jspdb1";
//		String dbUser = "jspid";
//		String dbPass = "jsppass";
//		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		
		// 커넥션 풀 => 서버에 연결정보 저장하기 : 자원 효율 증가
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");
		Connection con = ds.getConnection();
		
		return con;		
	}// DB 연결 메서드 getConnection()

//-------------------------------------------------------------------	
	public void insertBoard(BoardBean bb) {
		
		try {
			
			// 1. DB 연결
			con = getConnection();
			
			// 2. num 구하기 : 등록되어 있는 글번호 중 가장 큰 번호에 +1을 해준다
			sql = "SELECT max(num) FROM board";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int num = 0;
			if(rs.next()) {
				bb.setNum(rs.getInt("max(num)")+1);
			}
			
			// 3. board의 모든 데이터를 가져와 num 기준으로 내림차순 정렬
			
			// 3. 게시판에 입력한 값들을 DB에 저장하기
			sql = "INSERT INTO board(num,name,pass,subject,content,readcount,date) VALUES(?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getNum());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);  // readcount 조회수 0
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
	}//insertBoard(bb) : 게시판 글 등록
	
//-------------------------------------------------------------------	
	public void fInsertBoard(BoardBean bb) {
		try {
			
			// 1. DB 연결
			con = getConnection();
			
			// 2. num 구하기 : 등록되어 있는 글번호 중 가장 큰 번호에 +1을 해준다
			sql = "SELECT max(num) FROM board";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int num = 0;
			if(rs.next()) {
				bb.setNum(rs.getInt("max(num)")+1);
			}
			
			// 3. board의 모든 데이터를 가져와 num 기준으로 내림차순 정렬
			
			// 3. 게시판에 입력한 값들을 DB에 저장하기
			sql = "INSERT INTO board(num,name,pass,subject,content,readcount,date,file) VALUES(?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getNum());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0);  // readcount 초기 조회수 0
			pstmt.setString(7, bb.getFile());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}		}
	}
	
	
//-------------------------------------------------------------------	
	// 게시판의 전체 글을 리턴하는 메서드
	public List getBoardList() {  
		
		// ★ 리턴해줄 List 타입 변수를 선언 (try문 안에서 선언하면 try문 밖에서 리턴 못해줌)
		// 배열이 하나 생성되면 주소값은 하나이지만 저장될 bb는 각각의 배열 칸에 들어가면 되므로 여기에 선언해도 괜찮다
		List boardList = new ArrayList();
		
		// ★ BoardBean을 여기에 선언하면 주소값을 하나만 가지게 되어
		// while문 안에서 bb의 기억공간은 계속 생성되지만
		// 그 때마다 bb의 주소값이 초기화 될 뿐 bb의 배열이 생성되지는 않는다
		
		try {
			
			// 1. DB 연결
			con = getConnection();
			
			// 2. board의 모든 데이터를 가져와 num 기준으로 내림차순 정렬
			sql = "SELECT * FROM board ORDER BY num DESC";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			// 3. 글 하나에 포함된 데이터들(rs.~)을 rs.next() == true 인 동안
			//	  BoardBean 클래스의 bb를 이용해 각각 저장(bb.set~)해 while문을 반복하며 배열이 채워짐
			while(rs.next()) {
				
				// BoardBean bb 는 while문을 실행할 때 마다 선언되어
				// 이름은 bb로 같지만 서로 다른 주소값을 가진 bb들이 각각 생성된다
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				// 4. bb에 저장되어 있는 글 하나에 포함된 데이터들을 묶어서
				//	  List 인터페이스 ArrayList 클래스의 add() 메서드를 이용해 배열에 저장
				//    ArrayList는 한 번에 10개의 칸을 가진 배열이 생성되고
				//    add()는 그 칸에 순서대로 값을 채워준다(index 생성 아님)
				//    10칸이 넘어가면 자동으로 새로운 10칸의 배열이 생성된다
				boardList.add(bb);  // ★ while 반복 한 번 할 때마다 배열 한 칸씩 저장
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		// 5. List 타입의 변수 boardList 배열을 통째로 리턴
		// try_catch 문 안에서 에러가 나면 예외처리를 받지못해 리턴이 비정상적으로 될 수 있으므로 밖에서 하는 것이 좋다
		return boardList; // ★ while문의 반복이 모두 끝나고 완성된 배열이 통째로 리턴됨
	}// getBoardList()

	
//-------------------------------------------------------------------	
	
	// 한 페이지에 띄울 개수만큼의 게시판 글만 선택해서 리턴하는 메서드  => 메서드 오버로딩
	public List getBoardList(int startRow, int pageSize) {  
		
		List boardList = new ArrayList();
		
		try {
			
			// 1. DB 연결
			con = getConnection();
			
			// 2. board의 모든 데이터를 가져와 num 기준으로 내림차순 정렬
			// * mysql에만 있는 명령문  "LIMIT 시작행-1, 글의 개수"  
			//   => 시작행부터 글의 개수만큼 자르겠다 (LIMIT은 시작행을 포함하지 않고 다음부터 자르기 때문에 -1 필요)
			sql = "SELECT * FROM board ORDER BY num DESC LIMIT ?, ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			// 3. 글 하나에 포함된 데이터들을  BoardBean 객체에 저장
			while(rs.next()) {
				
				BoardBean bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				// 4. bb에 저장되어 있는 글 하나에 포함된 데이터들을 묶어서
				//	  List 인터페이스 ArrayList 클래스의 add() 메서드를 이용해 배열에 저장
				boardList.add(bb);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		// 5. List 타입의 변수 boardList 배열을 통째로 리턴
		return boardList; // ★ while문의 반복이 모두 끝나고 완성된 배열이 통째로 리턴됨
	}
	
	
	
	//getBoardList()
	public List getBoardList(int startRow,int pageSize,String search) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List boardList=new ArrayList();
		try {
			//1,2단계 디비연결
			con=getConnection();
			//3단계 sql board 모든데이터 가져오기 정렬 num 기준 내림차순
			//String sql="select * from board order by num desc limit 시작행-1,글개수";
			//String sql="select * from board where subject like '%검색어%' order by num desc limit ?,?";
			String sql="select * from board where subject like ? order by num desc limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2,startRow-1);
			pstmt.setInt(3, pageSize);
			//4단계  rs = 실행 결과 저장
			rs=pstmt.executeQuery();
			//5단계 rs => 한개글 BoardBean => 배열한칸 저장
			while(rs.next()) {
				BoardBean bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				boardList.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//예외상관없이 마무리(기억장소정리)
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return boardList;
	}//getBoardList()	
	
	
	
		
//-------------------------------------------------------------------	
	public BoardBean getBoard(int num) {
		
		BoardBean bb = new BoardBean();
		
		try {
			// 1. DB 연결
			con = getConnection();
			
			// 2. 매개변수 num에 해당하는 게시판글 찾아 저장
			sql = "SELECT * FROM board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			// 3. 리턴해줄 BoardBean타입 bb에 결과 저장
			if(rs.next()) {

				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setReadcount(rs.getInt("readcount"));	
				bb.setFile(rs.getString("file"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return bb;
	}// getBoard(int num)
	
//---------------------------------------------------------------------------	
	public void updateReadconut(int num) {
		
		try {
			// 1. DB 연결
			con = getConnection();
			
			// 2. readcont 1씩 증가하도록 UPDATE sql문 작성
			sql = "UPDATE board SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(con != null) try {con.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
	}
		
//-------------------------------------------------------------------	
	public int getBoardCount() {
		int count=0;
		
		try {
			// DB 연결
			con = getConnection();
			
			// sql
			sql = "SELECT count(*) FROM board";
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
	
	//getBoardCount(String search)
	public int getBoardCount2(String search) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			//1,2 디비연결
			con=getConnection();
			// 3단계 sql 조건 num에 해당하는 게시판글 가져오기
			//String sql="select count(*) from board where subject like '%검색어%'";
			String sql="select count(*) from board where subject like ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			// 4단계 실행해서 결과 저장 
			rs=pstmt.executeQuery();
			// 5단계 rs => BoardBean 객체생성=> BoardBean 멤버변수 저장
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
	}//getBoardCount()
	
	
	//numPassCheck(bb)
	public int numPassCheck(BoardBean bb) {
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	int check=-1;
	try {
		//1,2 디비연결
		con=getConnection();
		
		// 3단계 sql 조건 num에 해당하는 게시판글 가져오기
		String sql="select * from board where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, bb.getNum());
		
		// 4단계 실행해서 결과 저장 
		rs=pstmt.executeQuery();
		
		// 5단계 rs => BoardBean 객체생성=> BoardBean 멤버변수 저장
		if(rs.next()) {
			if(bb.getPass().equals(rs.getString("pass"))) {
				check=1;
			}else {
				check=0;
			}
		}else {
			check=-1;
		}
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
		if(con != null) try {con.close();} catch(SQLException ex) {}
		if(rs != null) try {rs.close();} catch(SQLException ex) {}
	}
	return check;
	}
	
	//updateBoard(bb)
	public void updateBoard(BoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			//1단계 드라이버로더 //2단계 디비연결
			con=getConnection();
			//3단계 insert
			String sql="update board set subject=?,content=? where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, bb.getSubject());
			pstmt.setString(2, bb.getContent());
			pstmt.setInt(3, bb.getNum());
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
	
	//deleteBoard(bb)
		public void deleteBoard(BoardBean bb) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			
			try {
				//1단계 드라이버로더 //2단계 디비연결
				con=getConnection();
				
				//3단계 insert
				String sql="delete from board where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, bb.getNum());
				
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
		
} //클래스
