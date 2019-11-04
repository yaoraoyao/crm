package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Tenant {
    private Long id;
    private String companyName;
    private String password;
    private String companyTel;
    private String companyNum;
    private String email;
    private String sysName;
    private Date registerTime;
    private Integer state;//状态-0 注册 ，1付费，2欠费
    private String address;
    private String coordinate;
    private String LogoUrl;
    private Long setMealId;//选择套餐
    private Boolean isPay;
    private String mealName;//套餐名称

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCompanyTel() {
        return companyTel;
    }

    public void setCompanyTel(String companyTel) {
        this.companyTel = companyTel;
    }

    public String getCompanyNum() {
        return companyNum;
    }

    public void setCompanyNum(String companyNum) {
        this.companyNum = companyNum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSysName() {
        return sysName;
    }

    public void setSysName(String sysName) {
        this.sysName = sysName;
    }

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getRegisterTime() {
        return registerTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCoordinate() {
        return coordinate;
    }

    public void setCoordinate(String coordinate) {
        this.coordinate = coordinate;
    }

    public String getLogoUrl() {
        return LogoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        LogoUrl = logoUrl;
    }

    public Long getSetMealId() {
        return setMealId;
    }

    public void setSetMealId(Long setMealId) {
        this.setMealId = setMealId;
    }

    public Boolean getPay() {
        return isPay;
    }

    public void setPay(Boolean pay) {
        isPay = pay;
    }

    public String getMealName() {
        return mealName;
    }

    public void setMealName(String mealName) {
        this.mealName = mealName;
    }

    @Override
    public String toString() {
        return "Tenant{" +
                "id=" + id +
                ", companyName='" + companyName + '\'' +
                ", password='" + password + '\'' +
                ", companyTel='" + companyTel + '\'' +
                ", companyNum='" + companyNum + '\'' +
                ", email='" + email + '\'' +
                ", sysName='" + sysName + '\'' +
                ", registerTime=" + registerTime +
                ", state=" + state +
                ", address='" + address + '\'' +
                ", coordinate='" + coordinate + '\'' +
                ", LogoUrl='" + LogoUrl + '\'' +
                ", setMealId=" + setMealId +
                ", isPay=" + isPay +
                ", mealName='" + mealName + '\'' +
                '}';
    }
}
