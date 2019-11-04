package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 合同
 */
public class Contract {

    private Long id;
    //合同编号
    private String sn;
    //定金客户
    private Customer customer;
    //签订时间
    private Date signTime;
    //销售员id
   private Employee  seller;
   //合同金额
    private Double   sum;
    //备注
  private String  intro;
    //租户id
   private Long   tenantId;

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


    @JsonFormat(pattern = "yyyy-mm-dd",timezone = "GMT+8")
    public Date getSignTime() {
        return signTime;
    }
    @DateTimeFormat(pattern ="yyyy-mm-dd")
    public void setSignTime(Date signTime) {
        this.signTime = signTime;
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
        return "Contract{" +
                "id=" + id +
                ", sn='" + sn + '\'' +
                ", customer=" + customer +
                ", signTime=" + signTime +
                ", seller=" + seller +
                ", sum=" + sum +
                ", intro='" + intro + '\'' +
                ", tenantId=" + tenantId +
                '}';
    }
}
