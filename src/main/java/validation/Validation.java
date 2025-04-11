package validation;

import java.util.ArrayList;
import java.util.List;

public class Validation {
	
	private List<String> errorMsgList;
	
	public Validation() {
		this.errorMsgList = new ArrayList<>();
	}
	
	public boolean hasErrorMsg() {
		if(errorMsgList.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public void isBlank(String textName, String text) {
		if(text == null || text.isEmpty()) {
			this.errorMsgList.add(textName + "が入力されていません");
		}
	}
	
	public void length(String textName, String text, int min, int max) {
		if (text == null || text.length() < min || text.length() > max) {
			this.errorMsgList.add(textName + "は" + min + "文字以上" + max + "以下で入力してください");
		}		
	}
	
	public void length(String textName, String text, int max) {
		if (text == null || text.length() > max) {
			this.errorMsgList.add(textName + "は" + max + "以下で入力してください");
		}		
	}
	
	public void addErrorMsg(String msg) {
		errorMsgList.add(msg);
	}
	
	public List<String> getErrorMsgList() {
		return errorMsgList;
	}
 }
