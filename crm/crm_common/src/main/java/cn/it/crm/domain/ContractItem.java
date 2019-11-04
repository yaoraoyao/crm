package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 合同付款明细
 */
public class ContractItem {

    private  Long id;
    //合同编号
    private String contractId;
    //付款日期
    private Date payTime;
    //付款金额
    private Double  money;
    //所占比例
    private  Double scale;
    //是否付款
    private  Boolean  isPayment=false;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContractId() {
        return contractId;
    }

    public void setContractId(String contractId) {
        this.contractId = contractId;
    }

    @JsonFormat(pattern = "yyyy-mm-dd",timezone = "GMT+8")
    public Date getPayTime() {
        return payTime;
    }
    @DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Double getScale() {
        return scale;
    }

    public void setScale(Double scale) {
        this.scale = scale;
    }

    public Boolean getIsPayment() {
        return isPayment;
    }

    public void setIsPayment(Boolean payment) {
        isPayment = payment;
    }

    @Override
    public String toString() {
        return "ContractItem{" +
                "id=" + id +
                ", contractId=" + contractId +
                ", payTime=" + payTime +
                ", money=" + money +
                ", scale=" + scale +
                ", isPayment=" + isPayment +
                '}';
    }
}
