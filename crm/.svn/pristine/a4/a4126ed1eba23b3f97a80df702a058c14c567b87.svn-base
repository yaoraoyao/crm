package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 定金订单
 */
public class Order  {

    private Long id;
    //定金单号
    private String sn;
    //客户
    private Long customerId;
    private Customer customer;
    //签订时间
    private Date signTime;
    //营销人员

    private Long sellerId;
    private Employee seller;

    //金额
    private Double sum;
    //摘要(描述)
    private String intro;
    //租户
    private Long tenantId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }
    @JsonFormat(pattern = "yyyy-mm-dd",timezone ="GMT+8")
    public Date getSignTime() {
        return signTime;
    }
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    public void setSignTime(Date signTime) {
        this.signTime = signTime;
    }

    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public Long getTenantId() {
        return tenantId;
    }

    public void setTenantId(Long tenantId) {
        this.tenantId = tenantId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Employee getSeller() {
        return seller;
    }

    public void setSeller(Employee seller) {
        this.seller = seller;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", sn='" + sn + '\'' +
                ", customerId=" + customerId +
                ", customer=" + customer +
                ", signTime=" + signTime +
                ", sellerId=" + sellerId +
                ", seller=" + seller +
                ", sum=" + sum +
                ", intro='" + intro + '\'' +
                ", tenantId=" + tenantId +
                '}';
    }
}
