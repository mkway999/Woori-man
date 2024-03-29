/*====================
	FriendsDAO.java
====================*/

package com.woori.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.woori.util.DBConn;
import com.woori.dto.FriendsDTO;
import com.woori.dto.NoteDTO;

public class NoteDAO
{
	private Connection conn;
	
	// 데이터베이스 연결
	public void connection() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
	}
	
	// 데이터베이스 연결 해제
	public void close() throws SQLException
	{
		DBConn.close();
	}
	
	// 받은 쪽지(전체) 
	public ArrayList<NoteDTO> receiveNote(String receiver) throws SQLException
	{
		ArrayList<NoteDTO> result = new ArrayList<NoteDTO>();
		
		String sql = "SELECT NOTE_CODE, NOTE_TITLE, NOTE_DATE, SENDER, RECEIVER"
				+ ", SENDERID, RECEIVERID, NOTE_READ, NOTE_RECEIVEDELETE, NOTE_STATUS"
				+ " FROM NOTE_VIEW WHERE RECEIVER = ? ORDER BY NOTE_DATE DESC";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(receiver));
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			NoteDTO dto = new NoteDTO();
			
			dto.setNote_code(rs.getString("NOTE_CODE"));
			dto.setNote_title(rs.getString("NOTE_TITLE"));
			dto.setNote_date(rs.getString("NOTE_DATE"));
			dto.setSender(rs.getString("SENDER"));
			dto.setReceiver(rs.getString("RECEIVER"));
			dto.setSenderid(rs.getString("SENDERID"));
			dto.setReceiverid(rs.getString("RECEIVERID"));
			dto.setNote_read(rs.getString("NOTE_READ"));
			dto.setNote_receivedelete(rs.getString("NOTE_RECEIVEDELETE"));
			dto.setNote_status(rs.getString("NOTE_STATUS"));
						
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();				
		
		return result;
	}
	
	// 받은 쪽지(관리자) 
	public ArrayList<NoteDTO> receiveAdminNote(String receiver) throws SQLException
	{
		ArrayList<NoteDTO> result = new ArrayList<NoteDTO>();
		
		String sql = "SELECT NOTE_CODE, NOTE_TITLE, NOTE_DATE, SENDER, RECEIVER"
				+ ", SENDERID, RECEIVERID, NOTE_READ, NOTE_RECEIVEDELETE, NOTE_STATUS"
				+ " FROM ADMIN_NOTE_VIEW WHERE RECEIVER = ? ORDER BY NOTE_DATE DESC";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(receiver));
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			NoteDTO dto = new NoteDTO();
			
			dto.setNote_code(rs.getString("NOTE_CODE"));
			dto.setNote_title(rs.getString("NOTE_TITLE"));
			dto.setNote_date(rs.getString("NOTE_DATE"));
			dto.setSender(rs.getString("SENDER"));
			dto.setReceiver(rs.getString("RECEIVER"));
			dto.setSenderid(rs.getString("SENDERID"));
			dto.setReceiverid(rs.getString("RECEIVERID"));
			dto.setNote_read(rs.getString("NOTE_READ"));
			dto.setNote_receivedelete(rs.getString("NOTE_RECEIVEDELETE"));
			dto.setNote_status(rs.getString("NOTE_STATUS"));
						
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();				
		
		return result;
	}
	
	// 받은 쪽지(친구) 
	public ArrayList<NoteDTO> receiveFriendNote(String receiver) throws SQLException
	{
		ArrayList<NoteDTO> result = new ArrayList<NoteDTO>();
		
		String sql = "SELECT NOTE_CODE, NOTE_TITLE, NOTE_DATE, SENDER"
				+ ", RECEIVER, SENDERID, RECEIVERID, NOTE_READ, NOTE_RECEIVEDELETE, NOTE_STATUS"
				+ " FROM FRIEND_NOTE_VIEW WHERE RECEIVER = ? ORDER BY NOTE_DATE DESC";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(receiver));
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			NoteDTO dto = new NoteDTO();
			
			dto.setNote_code(rs.getString("NOTE_CODE"));
			dto.setNote_title(rs.getString("NOTE_TITLE"));
			dto.setNote_date(rs.getString("NOTE_DATE"));
			dto.setSender(rs.getString("SENDER"));
			dto.setReceiver(rs.getString("RECEIVER"));
			dto.setSenderid(rs.getString("SENDERID"));
			dto.setReceiverid(rs.getString("RECEIVERID"));
			dto.setNote_read(rs.getString("NOTE_READ"));
			dto.setNote_receivedelete(rs.getString("NOTE_RECEIVEDELETE"));
			dto.setNote_status(rs.getString("NOTE_STATUS"));
						
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();				
		
		return result;
	}

	// 보낸 쪽지
	public ArrayList<NoteDTO> sendNote(String sender) throws SQLException
	{
		ArrayList<NoteDTO> result = new ArrayList<NoteDTO>();
		
		String sql = "SELECT NOTE_CODE, NOTE_TITLE, NOTE_DATE, RECEIVER, RECEIVERID, SENDER, SENDERID, NOTE_SENDDELETE"
				+ " FROM FRIEND_NOTE_VIEW WHERE SENDER = ? AND NOTE_SENDDELETE IS NULL ORDER BY NOTE_DATE DESC";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sender);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			NoteDTO dto = new NoteDTO();
			
			dto.setNote_code(rs.getString("NOTE_CODE"));
			dto.setNote_title(rs.getString("NOTE_TITLE"));
			dto.setNote_date(rs.getString("NOTE_DATE"));			
			dto.setReceiver(rs.getString("RECEIVER"));
			dto.setReceiverid(rs.getString("RECEIVERID"));
			dto.setSender(rs.getString("SENDER"));
			dto.setSenderid(rs.getString("SENDERID"));
			dto.setNote_senddelete(rs.getString("NOTE_SENDDELETE"));
						
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();				
		
		return result;
	}
	
	// 보낸쪽지 페이징처리용 리스트
	public ArrayList<NoteDTO> sendNoteList(String sender, int start, int end) throws SQLException
	{
		ArrayList<NoteDTO> result = new ArrayList<NoteDTO>();
		
		String sql = "SELECT RNUM, NOTE_CODE, NOTE_TITLE, NOTE_DATE, RECEIVER, RECEIVERID, SENDER, SENDERID, NOTE_SENDDELETE" + 
				" FROM(SELECT ROWNUM AS RNUM, DATA.* FROM(SELECT NOTE_CODE, NOTE_TITLE, NOTE_DATE, RECEIVER, RECEIVERID, SENDER, SENDERID, NOTE_SENDDELETE" + 
				" FROM FRIEND_NOTE_VIEW WHERE SENDER = ? AND NOTE_SENDDELETE IS NULL ORDER BY NOTE_DATE DESC)DATA) WHERE RNUM >= ? AND RNUM <= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sender));
		pstmt.setInt(2, start);
		pstmt.setInt(3, end);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			NoteDTO dto = new NoteDTO();
			
			dto.setNum(rs.getString("RNUM"));
			dto.setNote_code(rs.getString("NOTE_CODE"));
			dto.setNote_title(rs.getString("NOTE_TITLE"));
			dto.setNote_date(rs.getString("NOTE_DATE"));			
			dto.setReceiver(rs.getString("RECEIVER"));
			dto.setReceiverid(rs.getString("RECEIVERID"));
			dto.setSender(rs.getString("SENDER"));
			dto.setSenderid(rs.getString("SENDERID"));
			dto.setNote_senddelete(rs.getString("NOTE_SENDDELETE"));
						
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();	
		
		return result;
	}
	
	// 보낸 쪽지 갯수 카운트
	public int sendNoteCount(String sender) throws NumberFormatException, SQLException
	{
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT FROM FRIEND_NOTE_VIEW WHERE SENDER = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sender));
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
		{
			result = rs.getInt("COUNT");
		}
		rs.close();
		pstmt.close();
		
		return result;
	}
	
	// 수신자(친구) 검색 
	public ArrayList<FriendsDTO> FriendSearch(String us_code, String shearchValue) throws SQLException
	{
		ArrayList<FriendsDTO> result = new ArrayList<FriendsDTO>();
		
		String sql = "SELECT FR_CODE, US_CODE2, US_ID, US_NAME, US_PROFILE FROM FRIENDS_LIST_VIEW"
				+ " WHERE US_CODE2 = ? OR US_ID = ? OR US_NAME = ? AND US_CODE2 != ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		if (!shearchValue.matches("[+-]?\\d*(\\.\\d+)?"))
		{
			System.out.println("여기");
			String val = "1";
			pstmt.setInt(1, 0);
			pstmt.setString(2, shearchValue);
			pstmt.setString(3, shearchValue);
			pstmt.setInt(4, Integer.parseInt(us_code));
		}
		else
		{
			pstmt.setInt(1, Integer.parseInt(shearchValue));
			pstmt.setString(2, shearchValue);
			pstmt.setString(3, shearchValue);
			pstmt.setInt(4, Integer.parseInt(us_code));
		}
		
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			FriendsDTO dto = new FriendsDTO();
			dto.setFr_code(rs.getString("FR_CODE"));
			dto.setUs_code2(rs.getString("US_CODE2"));
			dto.setUs_id(rs.getString("US_ID"));
			dto.setUs_name(rs.getString("US_NAME"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		
		return result;
	}
	
	// 쪽지 작성
	public int noteWrite(NoteDTO dto) throws SQLException
	{
		int result = 0;
		
		String sql = "INSERT INTO NOTE(NOTE_CODE, NOTE_TITLE, NOTE_CONTENT, FR_CODE)"
				+ " VALUES(SEQ_NOTE.NEXTVAL, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getNote_title());
		pstmt.setString(2, dto.getNote_content());
		pstmt.setString(3, dto.getFr_code());		
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		
		return result;
	}
	
	// 쪽지 상세
	public NoteDTO noteArticle(String note_code) throws SQLException
	{
		NoteDTO result = new NoteDTO();
		
		String sql = "SELECT NOTE_CODE, SENDERID, RECEIVERID, RECEIVER, NOTE_TITLE, NOTE_CONTENT, NOTE_DATE"
				+ " FROM NOTE_VIEW WHERE NOTE_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, note_code);
		
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{	
		    result.setNote_code(rs.getString("NOTE_CODE"));
			result.setSenderid(rs.getString("SENDERID"));
			result.setReceiverid(rs.getString("RECEIVERID"));
			result.setNote_title(rs.getString("NOTE_TITLE"));
			result.setNote_content(rs.getString("NOTE_CONTENT"));
			result.setNote_date(rs.getString("NOTE_DATE"));
			result.setReceiver(rs.getString("RECEIVER"));
			
		}
		
		rs.close();
		pstmt.close();
		//System.out.println("DAO 종료~!~!");
		return result;			
	}
	
	
	
	// 쪽지 상세 받은거(전체)
	public NoteDTO receiveNoteArticle(String receiver, String note_code) throws SQLException
	{
		NoteDTO result = new NoteDTO();
		
		String sql = "SELECT NOTE_CODE, SENDERID, RECEIVERID, NOTE_TITLE, NOTE_CONTENT, NOTE_DATE"
				+ " FROM NOTE_VIEW WHERE RECEIVER = ? AND NOTE_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, receiver);
		pstmt.setString(2, note_code);
		
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result.setNote_code(rs.getString("NOTE_CDOE"));
			result.setSenderid(rs.getString("SENDERID"));
			result.setReceiverid(rs.getString("RECEIVERID"));
			result.setNote_title(rs.getString("NOTE_TITLE"));
			result.setNote_content(rs.getString("NOTE_CONTENT"));
			result.setNote_date(rs.getString("NOTE_DATE"));			
		}
		
		rs.close();
		pstmt.close();
		
		return result;			
	}
	
	// 쪽지 상세 받은거(관리자)
	public NoteDTO receiveAdminNoteArticle(String receiver, String note_code) throws SQLException
	{
		NoteDTO result = new NoteDTO();
		
		String sql = "SELECT NOTE_CODE, SENDERID, RECEIVERID, NOTE_TITLE, NOTE_CONTENT, NOTE_DATE"
				+ " FROM ADMIN_NOTE_VIEW WHERE RECEIVER = ? AND NOTE_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, receiver);
		pstmt.setString(2, note_code);
		
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result.setNote_code(rs.getString("NOTE_CDOE"));
			result.setSenderid(rs.getString("SENDERID"));
			result.setReceiverid(rs.getString("RECEIVERID"));
			result.setNote_title(rs.getString("NOTE_TITLE"));
			result.setNote_content(rs.getString("NOTE_CONTENT"));
			result.setNote_date(rs.getString("NOTE_DATE"));			
		}
		
		rs.close();
		pstmt.close();
		
		return result;			
	}
	
	// 쪽지 상세 받은거(친구)
	public NoteDTO receiveFriendNoteArticle(String receiver, String note_code) throws SQLException
	{
		NoteDTO result = new NoteDTO();
		
		String sql = "SELECT NOTE_CODE, RECEIVERID, SENDERID, NOTE_TITLE, NOTE_CONTENT, NOTE_DATE"
				+ " FROM FRIEND_NOTE_VIEW WHERE RECEIVER = ? AND NOTE_CODE = ?";				
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, receiver);
		pstmt.setString(2, note_code);
		
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result.setNote_code(rs.getString("NOTE_CDOE"));
			result.setReceiverid(rs.getString("RECEIVERID"));
			result.setSenderid(rs.getString("SENDERID"));
			result.setNote_title(rs.getString("NOTE_TITLE"));
			result.setNote_content(rs.getString("NOTE_CONTENT"));
			result.setNote_date(rs.getString("NOTE_DATE"));
		}
		
		rs.close();
		pstmt.close();
		
		return result;			
	}
	
	// 쪽지 상세 보낸거
	public NoteDTO sendNoteArticle(String sender, String note_code) throws SQLException
	{
		NoteDTO result = new NoteDTO();
		
		String sql = "SELECT NOTE_CODE, SENDERID, RECEIVERID, NOTE_TITLE, NOTE_CONTENT, NOTE_DATE"
				+ " FROM FRIEND_NOTE_VIEW WHERE SENDER = ? AND NOTE_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sender);
		pstmt.setString(2, note_code);
		
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next())
		{
			result.setNote_code(rs.getString("NOTE_CODE"));
			result.setSenderid(rs.getString("SENDERID"));
			result.setReceiverid(rs.getString("RECEIVERID"));
			result.setNote_title(rs.getString("NOTE_TITLE"));
			result.setNote_content(rs.getString("NOTE_CONTENT"));
			result.setNote_date(rs.getString("NOTE_DATE"));
		}
		
		rs.close();
		pstmt.close();
		
		return result;
				
	}
	
	// 받은 친구 쪽지 읽을 때
	public int friendRead(String note_code) throws SQLException
	{
		int result = 0;
		
		String sql = "UPDATE NOTE SET NOTE_READ = SYSDATE WHERE NOTE_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, note_code);
		
		result = pstmt.executeUpdate();
		
		return result;
	}
	
	// 받은 관리자 쪽지 읽을 때
	public int adminRead(String note_code) throws SQLException
	{
		int result = 0;
		
		String sql = "UPDATE ADMIN_NOTE_RECEIVE SET ANR_DATE = SYSDATE WHERE ANR_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, note_code);
		
		result = pstmt.executeUpdate();
		
		return result;
	}
	
	// 받은 친구 쪽지 삭제
	public int friendDelete(String note_code) throws SQLException
	{
		int result = 0;
		
		String sql = "UPDATE NOTE SET NOTE_READDELETE = SYSDATE WHERE NOTE_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, note_code);
		
		result = pstmt.executeUpdate();
		
		return result;
	}
	
	// 받은 관리자 쪽지 삭제
	public int adminDelete(String note_code) throws SQLException
	{
		int result = 0;
		
		String sql = "UPDATE ADMIN_NOTE_RECEIVE SET ANR_DELETE = SYSDATE WHERE ANR_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, note_code);
		
		result = pstmt.executeUpdate();
		
		return result;
	}
	
	// 보낸 쪽지 삭제
	public int sendDelete(String note_code) throws SQLException
	{
		int result = 0;
		
		String sql = "UPDATE NOTE SET NOTE_SENDDELETE = SYSDATE WHERE NOTE_CODE = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, note_code);
		
		result = pstmt.executeUpdate();
		
		return result;
	}
	

	
	
	
}
