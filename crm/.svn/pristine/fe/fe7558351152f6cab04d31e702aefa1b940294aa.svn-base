package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 售后
 */
public class AfterSale {

   private Long  id;
   /*保修单号*/
   private String  sn;
   //保修客户
   private Customer customer;
   //质保到期时间
   private Date expireTime;
   //租户ID
   private   Long tenantId;

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

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone ="GMT+8")
    public Date getExpireTime() {
        return expireTime;
    }
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    public void setExpireTime(Date expireTime) {
        this.expireTime = expireTime;
    }

    public Long getTenantId() {
        return tenantId;
    }

    public void setTenantId(Long tenantId) {
        this.tenantId = tenantId;
    }
}
