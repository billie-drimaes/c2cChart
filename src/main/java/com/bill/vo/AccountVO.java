package com.bill.vo;

import java.util.Date;

/*
 * 차량번호, trip 아이디, 사용자 아이디, 사용자 이름, OBD 넘버, 
*/
public class AccountVO {

	// 사용자, 관리자 정보
	private String userId;
	private String userName;
	private String adminId;
	private String adminName;
	private Date birthDate;
	
	// 유저 차량 정보
	private String carId;
	private String brandCode;
	private String brandName;
	private String modelCode;
	private String modelName;
	private String modelDtlCode;
	private String modelDtlName;
	private String fuelCode;
	private String fuelName;
	private String driverId; 
	private String driverName;
	private String ownerId;
	private String ownerName;
	

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getCarId() {
		return carId;
	}
	public void setCarId(String carId) {
		this.carId = carId;
	}
	public String getBrandCode() {
		return brandCode;
	}
	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getModelCode() {
		return modelCode;
	}
	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getModelDtlCode() {
		return modelDtlCode;
	}
	public void setModelDtlCode(String modelDtlCode) {
		this.modelDtlCode = modelDtlCode;
	}
	public String getModelDtlName() {
		return modelDtlName;
	}
	public void setModelDtlName(String modelDtlName) {
		this.modelDtlName = modelDtlName;
	}
	public String getFuelCode() {
		return fuelCode;
	}
	public void setFuelCode(String fuelCode) {
		this.fuelCode = fuelCode;
	}
	public String getFuelName() {
		return fuelName;
	}
	public void setFuelName(String fuelName) {
		this.fuelName = fuelName;
	}
	public String getDriverId() {
		return driverId;
	}
	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public String getOwnerId() {
		return ownerId;
	}
	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	
	@Override
	public String toString() {
		return "AccountVO [userId=" + userId + ", userName=" + userName + ", adminId=" + adminId + ", adminName="
				+ adminName + ", birthDate=" + birthDate + ", carId=" + carId + ", brandCode=" + brandCode
				+ ", brandName=" + brandName + ", modelCode=" + modelCode + ", modelName=" + modelName
				+ ", modelDtlCode=" + modelDtlCode + ", modelDtlName=" + modelDtlName + ", fuelCode=" + fuelCode
				+ ", fuelName=" + fuelName + ", driverId=" + driverId + ", driverName=" + driverName + ", ownerId="
				+ ownerId + ", ownerName=" + ownerName + "]";
	}
	
}
