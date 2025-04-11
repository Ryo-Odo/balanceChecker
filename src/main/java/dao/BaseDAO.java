package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseDAO {
	//DBに接続するための情報を持ったクラス
	final String DB_URL = "jdbc:postgresql://localhost:5433/foods_db";
	final String DB_USER = "postgres";
	final String DB_PASSWORD = "password";
	private Connection  conn;
	//DBへの接続機能などのクラス、取得など
	
	public Connection getonConnection () {
		//データベースへ接続するもしくは確認するmethod、すでに接続している場合はそのままreturn
		if (conn == null) {
			//もし接続がされていなかったら
			try {
				conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				//上記定数を利用して接続、接続できなかったらエラー
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
}
