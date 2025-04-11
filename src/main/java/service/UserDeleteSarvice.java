package service;

import dao.UserDAO;
import domain.User;
import dto.UserDTO;

public class UserDeleteSarvice {
	
	public boolean userDeleteDo(User user) {
		UserDAO userDAO = new UserDAO();
		UserDTO dto = new UserDTO(user.getLoginId(), null, null);
		int result = userDAO.delete(dto);
		
		if (result == 1) {
			return true;
		} else {
			return false;
		}
	}
}
