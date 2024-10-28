package kr.co.tutu.ad;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.sist.dao.DbConnection;
import kr.co.sist.user.member.WebMemberVO;

public class AdDAO {

	private static AdDAO mDAO;
	
	private AdDAO() {
	}
	
	public static AdDAO getInstance() {
		if(mDAO == null) {
			mDAO=new AdDAO();
		}//end if
		return mDAO;
	}//getInstance
	
	/**
	 * 아이디를 입력받아서 DB에서 검색하여 아이디가 존재하면 true, false반환
	 * @param id 중복검사할 아이디
	 * @return 사용중-true, 미사용-false
	 * @throws SQLException
	 */
	public boolean selectOneAd(int id)throws SQLException{
		boolean resultFlag=false;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		//1.JNDI사용객체 생성
		//2.DBCP에서 DataSource 얻기
		DbConnection dbCon=DbConnection.getInstance();
		//3.Connection얻기
		try {
		con=dbCon.getConn();
		//4.쿼리문 생성객체 얻기
		String selectId="select id from ad where id=?";
		pstmt=con.prepareStatement(selectId);
		//5.바인드에 변수 값 설정
		pstmt.setString(1, id);
		//6.쿼리문 수행 후 결과얻기
		rs=pstmt.executeQuery();
		
		resultFlag=rs.next();//아이디가 존재하면 true, false
		
		}finally {
		//7.연결끊기
			dbCon.dbClose(rs, pstmt, con);
		}//end finally
		
		return resultFlag;
	}//selectId
	
	public void insertAd(AdVO adVO)throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		//1.JNDI사용객체 생성
		//2.DBCP에서 DataSource 얻기
		DbConnection dbCon=DbConnection.getInstance();
		try {
		//3.Connection얻기
			con=dbCon.getConn();
		//4.쿼리문 생성 객체 얻기
			StringBuilder insertWebMember=new StringBuilder();
			insertWebMember
			.append("insert into ad")
			.append("(ad_id, ad_start_date, ad_end_date, advertiser, ad_detail, ad_phone, ad_img, ad_price, clicks, ad_active)")
			.append("values(?,?,?,?,?,?,?,?,?,?,?,?)");		
			
			pstmt=con.prepareStatement(insertWebMember.toString());
		//5.바인드변수에 값 설정
			pstmt.setInt(1, adVO.getAdId());
			pstmt.setString(2, adVO.getAdStartDate());
			pstmt.setString(3, adVO.getAdEndDate());
			pstmt.setString(4, adVO.getAdvertiser());
			pstmt.setString(5, adVO.getAdDetail());
			pstmt.setString(6, adVO.getAdPhone());
			pstmt.setString(7, adVO.getAdImg());
			pstmt.setString(8, adVO.getAdPhone());
			pstmt.setInt(9, adVO.getAdPrice());
			pstmt.setInt(10, adVO.getClicks());
			pstmt.setString(11, adVO.getAdActive());
		
		//6.쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
			if(adVO.getAdImg() != null) {
				insertAd(adVO);//관심언어 DB추가
			}//end if
		}finally {
		//7.연결끊기
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
	}//insertWebMember
		
}//class






	
	
	
}//class
