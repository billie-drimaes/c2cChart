package com.bill.vo;

import java.sql.Time;
import java.util.Date;

/*
 * 차량번호, trip 아이디, 사용자 아이디, 사용자 이름, OBD 넘버, 
*/
public class CarMainVO {

	private String tripId; 	// trip ID 
	private Date insDate;	// trip 생성 날짜
	private double mileage;	// 주행 거리
	private Time operateTime; // 운행 시간
	private String userId;	// 사용자 ID
	private String userName; // 사용자 이름
	private String carNo; 	// 차량 번호
	
	public String getTripId() {
		return tripId;
	}
	public void setTripId(String tripId) {
		this.tripId = tripId;
	}
	public Date getInsDate() {
		return insDate;
	}
	public void setInsDate(Date insDate) {
		this.insDate = insDate;
	}
	public double getMileage() {
		return mileage;
	}
	public void setMileage(double mileage) {
		this.mileage = mileage;
	}
	public Time getOperateTime() {
		return operateTime;
	}
	public void setOperateTime(Time operateTime) {
		this.operateTime = operateTime;
	}
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
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	@Override
	public String toString() {
		return "CarMainVO [tripId=" + tripId + ", insDate=" + insDate + ", mileage=" + mileage + ", operateTime="
				+ operateTime + ", userId=" + userId + ", userName=" + userName + ", carNo=" + carNo + "]";
	}
	
	
	
}
