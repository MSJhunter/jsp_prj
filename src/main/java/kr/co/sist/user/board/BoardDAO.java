package kr.co.sist.user.board;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;
import kr.co.sist.util.BoardUtil;

/**
 *  게시판의 리스트, 상세조회, 추가, 삭제, 변경 업무
 */
public class BoardDAO {
	
	private static BoardDAO bDAO;
	
	private BoardDAO() {
		
	}
	
	public static BoardDAO getInstance() {
		//bDAO가 null인 경우에만 새로운 인스턴스를 생성하고
		//이후에는 항상 같은 인스턴스를 반환
		//싱글턴 패턴을 적용하여 외부에서 하나의 인스턴스만 접근하도록
		if(bDAO == null) {
			bDAO = new BoardDAO();
		}//end if
		return bDAO;
	}//getInstance
	
	
	/**
	 * 총 게시물의 수 검색
	 * @param sVO
	 * @return 게시물의 수
	 * @throws SQLException
	 */
	public int selectTotalCount(SearchVO sVO)throws SQLException{
		int totalCount=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		//1.JNDI 사용객체 생성
		//2.DBCP에서 DataSource 얻기
		
		try {
		//3.Connection얻기
			con=dbCon.getConn();
		//4.쿼리문생성객체 얻기
			StringBuilder selectCount=new StringBuilder();
			selectCount
			.append("select count(num) cnt from board ");
			
			//dynamic query: 검색 키워드르 판단 기준으로 where절이 동적 생성되어야 함
			if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
			    selectCount.append(" where instr(")
			               .append(BoardUtil.numToField(sVO.getField()))
			               .append(", ?) != 0"); // 동적 쿼리
			} // end if

			pstmt=con.prepareStatement(selectCount.toString());
			//5.바인드 변수에 값 설정
			
			if(sVO.getKeyword() != null && "".equals(sVO.getKeyword())) {
				pstmt.setString(1, sVO.getKeyword());
				
			}//end if
			
		//6.쿼리문 수행후 결과 얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				totalCount=rs.getInt("cnt");
			}//end if
		}finally {
		//7.연결 끊기
			dbCon.dbClose(rs, pstmt, con);
		}//end finally
		return totalCount;
	}//selectTotalCount
	
	// 게시판 리스트를 조회하는 메서드
	public List<BoardVO> selectBoard(SearchVO sVO) throws SQLException {
	    List<BoardVO> list = new ArrayList<>();

	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        // connection 얻기
	        con = dbCon.getConn();

	        // 동적 쿼리 생성
	        StringBuilder selectBoardBuilder = new StringBuilder();
	        selectBoardBuilder.append("SELECT num, subject, writer, input_date, ip ");
	        selectBoardBuilder.append("FROM (SELECT num, subject, writer, input_date, ip, ");
	        selectBoardBuilder.append("ROW_NUMBER() OVER (ORDER BY input_date DESC) rnum ");
	        selectBoardBuilder.append("FROM board ");

	        // 검색어가 있으면 WHERE 조건을 추가
	        if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
	            selectBoardBuilder.append("WHERE instr(").append(sVO.getField()).append(", ?) > 0 ");
	        }

	        selectBoardBuilder.append(") WHERE rnum BETWEEN ? AND ?");

	        
	        pstmt = con.prepareStatement(selectBoardBuilder.toString());

	        //바인드 변수에 값 설정
	        int bindInd=0; 
	        
	        // 검색어가 있으면 첫 번째 바인드 변수에 검색어를 설정
	        if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
	            pstmt.setString(++bindInd, sVO.getKeyword());
	        }//end if

	        // 시작 번호와 끝 번호를 설정
	        pstmt.setInt(++bindInd, sVO.getStartNum());
	        pstmt.setInt(++bindInd, sVO.getEndNum());

	        // 쿼리문 수행 후 결과 얻기
	        rs = pstmt.executeQuery();

	        // ResultSet에서 데이터 추출
	        while (rs.next()) {
	            BoardVO bVO = new BoardVO();
	            bVO.setNum(rs.getInt("num"));
	            bVO.setSubject(rs.getString("subject"));
	            bVO.setWriter(rs.getString("writer"));
	            bVO.setIp(rs.getString("ip"));
	            bVO.setInput_date(rs.getDate("input_date"));
	            list.add(bVO); // 리스트에 객체 추가
	        }

	    } finally {
	        // 자원 해제
	        dbCon.dbClose(rs, pstmt, con);
	    }

	    return list;
	}

	
	/**
	 * 입력 값을 board 테이블에 추가하는 일
	 * @param bVO
	 * @throws SQLException
	 */
	public void insertBoard(BoardVO bVO)throws SQLException{
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//connection얻기
			con=dbCon.getConn();
			//쿼리문 생성객체 얻기
			StringBuilder insertBoard=new StringBuilder();
			insertBoard
			.append("insert into board(num,subject,content,writer,ip) ")
			.append("values( seq_board.nextval,?,?,?,?)");
			
			pstmt=con.prepareStatement(insertBoard.toString());
			//바인드 변수에 값 설정
			pstmt.setString(1,bVO.getSubject());
			pstmt.setString(2,bVO.getContent());
			pstmt.setString(3,bVO.getWriter());
			pstmt.setString(4,bVO.getIp());
						
			//쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
	}//insertBoard
	
	
	/**
	 * 입력된 글번호에 해당하는 글 하나 조회
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public BoardVO selectDetailBoard( int num )throws SQLException{
		BoardVO bVO=null;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//connection얻기
			con=dbCon.getConn();
			//쿼리문 생성객체 얻기
			StringBuilder selectOneBoard=new StringBuilder();
			selectOneBoard
			.append("	select 	num,subject,content, writer,input_date,ip	")
			.append("	from	board	")
			.append("	where 	num=?  ");
			
			pstmt=con.prepareStatement(selectOneBoard.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1, num);
						
			//쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			if( rs.next() ) {
				bVO=new BoardVO();
				bVO.setNum( num );
				bVO.setSubject(rs.getString("subject"));
				bVO.setWriter(rs.getString("writer"));
				bVO.setInput_date(rs.getDate("input_date"));
				bVO.setIp(rs.getString("ip"));
				
				//CLOB데이터를 읽어들이기 위해서 별도의 stream을 연결한다.
				BufferedReader br=new BufferedReader(
						rs.getClob("content").getCharacterStream());
				
				StringBuilder content=new StringBuilder();
				String temp;//한줄 읽어들인 데이터를 저장할 변수
				try {
					while( (temp=br.readLine()) != null) {
						//한줄 읽어들여 content에 저장
						content.append(temp).append("\n");
					}//end while
					//모든 줄을 읽어들여 저장한 변수를 BoardVO객체에 할당한다.
					bVO.setContent(content.toString());
					
				}catch(IOException ie) {
					ie.printStackTrace();
				}//end catch
				
			}//end if
			
		}finally {
			dbCon.dbClose(rs, pstmt, con);
		}//end finally
		
		return bVO;
	}//selectBoard
	
	/** 글번호와 아이디에 해당하는 글의 내용을 변경
	 * @param bVO
	 * @return
	 * @throws SQLException
	 */
	public int updateBoard(BoardVO bVO)throws SQLException{
		
		int rowCnt = 0; 
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//connection얻기
			con=dbCon.getConn();
			//쿼리문 생성객체 얻기
			StringBuilder updateBoard=new StringBuilder();
			updateBoard
			.append("	update 	board")
			.append("	set	   	content=?  ")
			.append("	where  	num=? and writer=? ")
			;
			pstmt=con.prepareStatement(updateBoard.toString());
			//바인드 변수에 값 설정
			pstmt.setString(1,bVO.getContent());
			pstmt.setInt(2,bVO.getNum());
			pstmt.setString(3,bVO.getWriter());
						
			//쿼리문 수행 후 결과 얻기
			rowCnt=pstmt.executeUpdate();
			
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
	
		return rowCnt; 
		
	}//board
	
	public int deleteBoard(BoardVO bVO)throws SQLException{
		
		int rowCnt = 0; 
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//connection얻기
			con=dbCon.getConn();
			//쿼리문 생성객체 얻기
			StringBuilder deleteBoard=new StringBuilder();
			deleteBoard
			.append(" delete from board	")
			.append(" where  num=? and writer=?	  ")
			;
			pstmt=con.prepareStatement(deleteBoard.toString());
			//바인드 변수에 값 설정
			pstmt.setInt(1,bVO.getNum());
			pstmt.setString(2,bVO.getWriter());
						
			//쿼리문 수행 후 결과 얻기
			rowCnt=pstmt.executeUpdate();
			
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
	
		return rowCnt; 
		
	}//board
	
	
	
}//class
