package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

public class SetMeal {
    private Long id;
    private String mealName;
    private BigDecimal mealPrice;
    private Date expireDate = new Date();
    private  Integer status;//状态：0可用，1不可用

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMealName() {
        return mealName;
    }

    public void setMealName(String mealName) {
        this.mealName = mealName;
    }

    public BigDecimal getMealPrice() {
        return mealPrice;
    }

    public void setMealPrice(BigDecimal mealPrice) {
        this.mealPrice = mealPrice;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getExpireDate() {

        return expireDate;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setExpireDate(Date expireDate) {

        this.expireDate = expireDate;
    }
    @Override
    public String toString() {
        return "SetMeal{" +
                "id=" + id +
                ", mealName='" + mealName + '\'' +
                ", mealPrice=" + mealPrice +
                ", expireDate=" + expireDate +
                ", Status=" + status +
                '}';
    }
}
