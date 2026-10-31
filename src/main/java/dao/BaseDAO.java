package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseDAO {
	//DBに接続するための情報を持ったクラス
	final String DB_URL = getConfig("balancechecker.db.url", "BALANCECHECKER_DB_URL", "jdbc:postgresql://localhost:5433/foods_db");
	final String DB_USER = getConfig("balancechecker.db.user", "BALANCECHECKER_DB_USER", "postgres");
	final String DB_PASSWORD = getRequiredConfig("balancechecker.db.password", "BALANCECHECKER_DB_PASSWORD");
	private Connection  conn;
	//DBへの接続機能などのクラス、取得など
	
	public Connection getonConnection () {
		
		//データベースへ接続するもしくは確認するmethod、すでに接続している場合はそのままreturn
		try {
			if (conn == null || conn.isClosed()) {
			//もし接続がされていなかったら
			try {
				Class.forName("org.postgresql.Driver");
				conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				//上記定数を利用して接続、接続できなかったらエラー
				
			} catch (ClassNotFoundException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	protected void closeConnection() {
		if (conn == null) {
			return;
		}
		try {
			if (!conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn = null;
		}
	}

	private static String getConfig(String propertyName, String environmentName, String defaultValue) {
		String value = System.getProperty(propertyName);
		if (value == null || value.isBlank()) {
			value = System.getenv(environmentName);
		}
		return value == null || value.isBlank() ? defaultValue : value;
	}

	private static String getRequiredConfig(String propertyName, String environmentName) {
		String value = getConfig(propertyName, environmentName, null);
		if (value == null || value.isBlank()) {
			throw new IllegalStateException(environmentName + " is not configured.");
		}
		return value;
	}
}
