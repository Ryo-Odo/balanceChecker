package service;

import dao.UserDAO;
import domain.User;
import dto.UserDTO;

public class UserEditService {
	
	public boolean  userEditDo(User user) {
		System.out.println("UserEditService開始");
		UserDTO dto = new UserDTO(user.getLoginId(), user.getPassword(), user.getName());
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
