package com.bill.vo;

import java.util.Date;

public class UserVO {
	
	private String userId;	// 사용자 ID
	private String password; // 사용자 PW
	private String userName; // 사용자 이름
	private String useYN; // 활성 사용자 여부
	private Date birthDate; // 사용자 생년월
	private String email; // 사용자 이메일
	private String phoneNumber; // 사용자 연락처
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUseYN() {
		return useYN;
	}
	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}	
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	@Override
	public String toString() {
	return "UserVO [userId=" + userId + ", password=" + password + ", userName=" + userName + ", useYN=" + useYN + "]";
	 }
}
