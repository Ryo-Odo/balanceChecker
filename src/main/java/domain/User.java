package domain;

import java.util.Date;

public class User {
	//実際にアプリ内で使用するデータが保存されているクラス、
	
	private int id;
	private String loginId;
	private String password;
	private String name;
    private Date createdAt;
	private String createdAtStr;
	//DTOと違う、アプリ内で使用しやすいように整えている
	
	public User() {
		//コントラクタ
	}
	
	public User(String loginId, String password, String name) {
		//コントラクタ
		this.loginId = loginId;
		this.password = password;
		this.name = name;
	}
	
	
	
	
	
	//以下セッターゲッター
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

//	public void setCreatedAt(Date createdAt) {
//		this.createdAt = createdAt;
//	}

	public String getCreatedAtStr() {
		return createdAtStr;
	}

	public void setCreatedAtStr(String createdAtStr) {
		this.createdAtStr = createdAtStr;
	}
	
	

}
