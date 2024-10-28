package day1018;

import java.util.Date;

public class ProductVO {
	private int itemNo;
	private String img;
	private int price;
	private Date date;
	
	public ProductVO() {
	}

	public ProductVO(int itemNo, String img, int price, Date date) {
		this.itemNo = itemNo;
		this.img = img;
		this.price = price;
		this.date = date;
	}

	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "ProductVO [itemNo=" + itemNo + ", img=" + img + ", price=" + price + ", date=" + date + "]";
	}
	
}
