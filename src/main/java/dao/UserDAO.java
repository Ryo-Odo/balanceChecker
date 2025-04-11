package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.UserDTO;

public class UserDAO extends BaseDAO{
	//DBへ接続し操作するクラス、１テーブルに１クラスが基本
	
	public UserDTO selectByLoginId(String loginId) {
		
		UserDTO dto = null;
		//ユーザー情報保持のための変数を初期化
		
		Connection conn = getonConnection();
		//DBへ接続
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE login_id = ?");
			//SQL文を格納、プレースホルダー(?)で下記からセット
			
			ps.setString(1, loginId);
			//SQL文の条件セット、第一引数はプレースホルダーの順番
			
			ResultSet rs = ps.executeQuery();
			//上記SQL文の実行結果をrsに格納
			
			
			if(rs.next()) {
				//DBから１行データを取り出せたなら
				dto = new UserDTO();
				//初期化
				dto.setId(rs.getInt(1));
				dto.setLoginId(rs.getString(2));
				dto.setPassword(rs.getString(3));
				dto.setName(rs.getString(4));
				dto.setCreatedAt(rs.getTimestamp(5));
				//セッターを使用して各変数へ取得した値を格納				
			}
			
		} catch (SQLException e) {
			System.out.println("エラー：DBからデータを取り出せていない");
			e.printStackTrace();
		}
		return dto;
		//ユーザー情報を返す、データ取り出せていなかったらnullを返す
	}
	
	public int insert(UserDTO dto) {
		int result = 0;
		
		Connection conn = getonConnection();
		
		TransactionManager tm = new TransactionManager(conn);
		
		try {
			System.out.println("DB登録try開始");
			System.out.println("ID" + dto.getLoginId());
			System.out.println("パスワード" + dto.getPassword());
			System.out.println("名前" + dto.getName());
			PreparedStatement ps = conn.prepareStatement("INSERT INTO users(login_id, password, name) VALUES(?, ?, ?)");
			ps.setString(1, dto.getLoginId());
			ps.setString(2, dto.getPassword());
			ps.setString(3, dto.getName());
			System.out.println("SQL文作成完了");
			
			result = ps.executeUpdate();
			System.out.println(result);
			
			tm.commit();
		} catch (SQLException e) {
			System.out.println(e);
			tm.rollback();
			e.printStackTrace();
		}
		tm.close();
		return result;
	}
	
	public int edit(UserDTO dto) {
		int result = 0;
		
		Connection conn = getonConnection();
		
		TransactionManager tm = new TransactionManager(conn);
		
		try {
			System.out.println("editSQL開始");
			PreparedStatement ps = conn.prepareStatement("UPDATE users SET password = ?, name = ? WHERE login_id = ?");
			ps.setString(1, dto.getPassword());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getLoginId());
			System.out.println(ps);
			result = ps.executeUpdate();
			tm.commit();
		} catch (SQLException e) {
			System.out.println("UserDAO edit　SQLエラー");
			tm.close();
			e.printStackTrace();
		}
		tm.close();
		return result;
		
	}
	
	public int delete(UserDTO dto) {
		int result = 0;
		
		Connection conn = getonConnection();
		
		TransactionManager tm = new TransactionManager(conn);
		
		try {
			PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE login_id = ?");
			ps.setString(1, dto.getLoginId());
			
			result = ps.executeUpdate();
			tm.commit();
		} catch (SQLException e) {
			tm.rollback();
			e.printStackTrace();
		}
		tm.close();
		return result;
		
	}

}
