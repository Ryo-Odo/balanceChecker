package dao;

import java.sql.Connection;
import java.sql.SQLException;

public class TransactionManager {
	private Connection conn;
	private boolean isCommit;
	
	public TransactionManager(Connection conn) {
		this.conn = conn;
		try {
			conn.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void commit() {
		if(conn == null) {
			System.err.print("トランザクションが開始されていません");
		} else {
			isCommit = true;
		}
	}
	
	public void rollback() {
		if(conn == null) {
			System.err.print("トランザクションが開始されていません");
		} else {
			isCommit = false;
		}
	}
	
	public void close() {
		try {
			if(conn != null) {
				if(isCommit) {
					conn.commit();
				} else {
					conn.rollback();
				}
				conn.close();
				conn = null;				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
