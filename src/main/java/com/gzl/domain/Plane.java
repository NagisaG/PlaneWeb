package com.gzl.domain;

/**
 * 名称:plane
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-12-03 18:42
 */
public class Plane {
    private Integer plane_id;
    private String  cname;
    private String company;
    private String ename;
    private Integer ptype;
    private String img;
    private String first;
    private String license;
    private String wings;
    private String usage;
    private String seats;
    private String flight;
    private String price;
    private String power;

    public Integer getPlane_id() {
        return plane_id;
    }

    public void setPlane_id(Integer plane_id) {
        this.plane_id = plane_id;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public Integer getPtype() {
        return ptype;
    }

    public void setPtype(Integer ptype) {
        this.ptype = ptype;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getFirst() {
        return first;
    }

    public void setFirst(String first) {
        this.first = first;
    }

    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    public String getWings() {
        return wings;
    }

    public void setWings(String wings) {
        this.wings = wings;
    }

    public String getUsage() {
        return usage;
    }

    public void setUsage(String usage) {
        this.usage = usage;
    }

    public String getSeats() {
        return seats;
    }

    public void setSeats(String seats) {
        this.seats = seats;
    }

    public String getFlight() {
        return flight;
    }

    public void setFlight(String flight) {
        this.flight = flight;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getPower() {
        return power;
    }

    public void setPower(String power) {
        this.power = power;
    }

    @Override
    public String toString() {
        return "Plane{" +
                "plane_id=" + plane_id +
                ", cname='" + cname + '\'' +
                ", company='" + company + '\'' +
                ", ename='" + ename + '\'' +
                ", ptype=" + ptype +
                ", img='" + img + '\'' +
                ", first='" + first + '\'' +
                ", license='" + license + '\'' +
                ", wings='" + wings + '\'' +
                ", usage='" + usage + '\'' +
                ", seats='" + seats + '\'' +
                ", flight='" + flight + '\'' +
                ", price='" + price + '\'' +
                ", power='" + power + '\'' +
                '}';
    }
}
