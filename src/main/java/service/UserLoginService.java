package service;

import dao.UserDAO;
import domain.User;
import dto.UserDTO;
import security.PasswordHasher;

public class UserLoginService {
	//ロジック処理担当、コントローラーとDAO(DB操作)などの仲介
	
	public User loginCheck(String loginId, String password) {
		//ログインコントローラーから、ログイン情報が正しいかチェック
		
		UserDAO userDAO = new UserDAO();
		//DAOインスタンス作成
		
		UserDTO userDTO = userDAO.selectByLoginId(loginId);
		//DTOインスタンスへ格納、DAOのメソッドを利用してログインIDに合っているDTOインスタンスが帰ってくる、まだパスワードチェックしてない
		
		
		if(userDTO != null && PasswordHasher.verify(password, userDTO.getPassword())) {
			//DTOがnullじゃないかつ、パスワードが一致していたら
			if (!PasswordHasher.isHashed(userDTO.getPassword())) {
				userDAO.updatePassword(userDTO.getLoginId(), PasswordHasher.hash(password));
			}
			User user = new User(userDTO.getLoginId(), null, userDTO.getName());
			user.setId(userDTO.getId());
			
			return user;
			
		}
		return null;
	}
}
