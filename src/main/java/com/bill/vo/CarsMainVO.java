package com.bill.vo;

/*
 * 차량번호, trip 아이디, 사용자 아이디, 사용자 이름, OBD 넘버, 
*/
public class CarsMainVO {

	private String VinCode;
	private String carId;
	private String TripRuntime;
	private String TripDistance;
	private String CurLatitude;
	private String CurLongitude;
	private String Speed;
	
	
	public String getCurLatitude() {
		return CurLatitude;
	}
	public void setCurLatitude(String curLatitude) {
		CurLatitude = curLatitude;
	}
	public String getCurLongitude() {
		return CurLongitude;
	}
	public void setCurLongitude(String curLongitude) {
		CurLongitude = curLongitude;
	}
	public String getVinCode() {
		return VinCode;
	}
	public void setVinCode(String vinCode) {
		VinCode = vinCode;
	}
	public String getCarId() {
		return carId;
	}
	public void setCarId(String carId) {
		this.carId = carId;
	}
	public String getTripRuntime() {
		return TripRuntime;
	}
	public void setTripRuntime(String tripRuntime) {
		TripRuntime = tripRuntime;
	}
	public String getTripDistance() {
		return TripDistance;
	}
	public void setTripDistance(String tripDistance) {
		TripDistance = tripDistance;
	}
	public String getSpeed() {
		return Speed;
	}
	public void setSpeed(String speed) {
		Speed = speed;
	}
	
	@Override
	public String toString() {
		return "CarsMainVO [VinCode=" + VinCode + ", carId=" + carId + ", TripRuntime=" + TripRuntime
				+ ", TripDistance=" + TripDistance + ", CurLatitude=" + CurLatitude + ", CurLongitude=" + CurLongitude
				+ ", Speed=" + Speed + "]";
	}
	
}
