package dto;

import java.sql.Timestamp;

public class UserDTO {
	//データベースから持ってきたユーザー情報を保持するクラス、主にデータの転送のみ、アプリ内で使用するデータはDmain
	
	private int id;
	private String loginId;
	private String password;
	private String name;
	private Timestamp createdAt;
	//持っている属性（フィールド）、このクラス内からのみ参照可能
	
	
	public UserDTO() {
		//引数なしコンストラクタ
	}
	
	public UserDTO(String loginId, String password, String name) {
		//引数ありコンストラクタ
		this.loginId = loginId;
		this.password = password;
		this.name = name;
	}

	
	
	//以下セッターとゲッター
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

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createAt) {
		this.createdAt = createAt;
	}

}
