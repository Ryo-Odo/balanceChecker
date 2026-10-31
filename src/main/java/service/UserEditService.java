package service;

import dao.UserDAO;
import domain.User;
import dto.UserDTO;
import security.PasswordHasher;

public class UserEditService {
	
	public boolean  userEditDo(User user) {
		UserDTO dto = new UserDTO(user.getLoginId(), PasswordHasher.hash(user.getPassword()), user.getName());
		UserDAO userDAO = new UserDAO();
		int result = userDAO.edit(dto);
		
		if(result == 1) {
			return true;
		} else {
			System.out.println("UserEditService＝false");
			return false;
		}
		
	}

}
