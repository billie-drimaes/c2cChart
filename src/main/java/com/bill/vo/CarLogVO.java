package com.bill.vo;

import java.sql.Time;
import java.util.Date;

/*
 * 차량번호, trip 아이디, 사용자 아이디, 사용자 이름, OBD 넘버, 
*/
public class CarLogVO {

	private String tripId; 	// trip ID 
	private String insDte;	// trip 생성 날짜
	private String carNo; 	// 차량 번호
	private String userId;	// 사용자 ID
	private String DRIVING_DISTANCE;	// 주행 거리
	private String DRIVING_TIME; // 운행 시간
	private String START_TIME;
	private String END_TIME;
	private String START_GPS;
	private String END_GPS;
	
	public String getTripId() {
		return tripId;
	}
	public void setTripId(String tripId) {
		this.tripId = tripId;
	}
	public String getInsDte() {
		return insDte;
	}
	public void setInsDte(String insDte) {
		this.insDte = insDte;
	}
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDRIVING_DISTANCE() {
		return DRIVING_DISTANCE;
	}
	public void setDRIVING_DISTANCE(String dRIVING_DISTANCE) {
		DRIVING_DISTANCE = dRIVING_DISTANCE;
	}
	public String getDRIVING_TIME() {
		return DRIVING_TIME;
	}
	public void setDRIVING_TIME(String dRIVING_TIME) {
		DRIVING_TIME = dRIVING_TIME;
	}
	public String getSTART_TIME() {
		return START_TIME;
	}
	public void setSTART_TIME(String sTART_TIME) {
		START_TIME = sTART_TIME;
	}
	public String getEND_TIME() {
		return END_TIME;
	}
	public void setEND_TIME(String eND_TIME) {
		END_TIME = eND_TIME;
	}
	public String getSTART_GPS() {
		return START_GPS;
	}
	public void setSTART_GPS(String sTART_GPS) {
		START_GPS = sTART_GPS;
	}
	public String getEND_GPS() {
		return END_GPS;
	}
	public void setEND_GPS(String eND_GPS) {
		END_GPS = eND_GPS;
	}
	@Override
	public String toString() {
		return "CarLogVO [tripId=" + tripId + ", insDte=" + insDte + ", carNo=" + carNo + ", userId=" + userId
				+ ", DRIVING_DISTANCE=" + DRIVING_DISTANCE + ", DRIVING_TIME=" + DRIVING_TIME + ", START_TIME="
				+ START_TIME + ", END_TIME=" + END_TIME + ", START_GPS=" + START_GPS + ", END_GPS=" + END_GPS + "]";
	}
	
}
