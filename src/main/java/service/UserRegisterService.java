package service;

import dao.UserDAO;
import domain.User;
import dto.UserDTO;

public class UserRegisterService {
	public boolean userEntryConfirm(User user) {
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = userDAO.selectByLoginId(user.getLoginId());
		
		if (userDTO == null) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean userEntryDo(User user) {
		System.out.println("userEntryDo開始↓");
		UserDAO userDAO = new UserDAO();
		UserDTO dto = new UserDTO(user.getLoginId(), user.getPassword(), user.getName());
		int result = userDAO.insert(dto);
		
		if(result  == 1) {
			return true;
		} else {
			return false;
		}
	}
}
