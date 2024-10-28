package kr.co.tutu.ad;

public class AdVO {

    private int adId;                  	// ad_id
    private String adStartDate;         // ad_start_date
    private String adEndDate;           // ad_end_date
    private String advertiser;          // advertiser
    private String adDetail;            // ad_detail
    private String adPhone;             // ad_phone
    private String adImg;               // ad_img
    private int adPrice;                // ad_price
    private int clicks;                 // clicks
    private java.sql.Date inputDate;    // input_date
    private String adActive;            // ad_active
    private String deleteFlag;          // delete_flag
	public int getAdId() {
		return adId;
	}
	public void setAdId(int adId) {
		this.adId = adId;
	}
	public String getAdStartDate() {
		return adStartDate;
	}
	public void setAdStartDate(String adStartDate) {
		this.adStartDate = adStartDate;
	}
	public String getAdEndDate() {
		return adEndDate;
	}
	public void setAdEndDate(String adEndDate) {
		this.adEndDate = adEndDate;
	}
	public String getAdvertiser() {
		return advertiser;
	}
	public void setAdvertiser(String advertiser) {
		this.advertiser = advertiser;
	}
	public String getAdDetail() {
		return adDetail;
	}
	public void setAdDetail(String adDetail) {
		this.adDetail = adDetail;
	}
	public String getAdPhone() {
		return adPhone;
	}
	public void setAdPhone(String adPhone) {
		this.adPhone = adPhone;
	}
	public String getAdImg() {
		return adImg;
	}
	public void setAdImg(String adImg) {
		this.adImg = adImg;
	}
	public int getAdPrice() {
		return adPrice;
	}
	public void setAdPrice(int adPrice) {
		this.adPrice = adPrice;
	}
	public int getClicks() {
		return clicks;
	}
	public void setClicks(int clicks) {
		this.clicks = clicks;
	}
	public java.sql.Date getInputDate() {
		return inputDate;
	}
	public void setInputDate(java.sql.Date inputDate) {
		this.inputDate = inputDate;
	}
	public String getAdActive() {
		return adActive;
	}
	public void setAdActive(String adActive) {
		this.adActive = adActive;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	@Override
	public String toString() {
		return "AdVO [adId=" + adId + ", adStartDate=" + adStartDate + ", adEndDate=" + adEndDate + ", advertiser="
				+ advertiser + ", adDetail=" + adDetail + ", adPhone=" + adPhone + ", adImg=" + adImg + ", adPrice="
				+ adPrice + ", clicks=" + clicks + ", inputDate=" + inputDate + ", adActive=" + adActive
				+ ", deleteFlag=" + deleteFlag + "]";
	}

	
	
}//class
