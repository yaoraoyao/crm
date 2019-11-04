package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class CustomerTransfer {
    private Long id;
    /**
     * 客户
     */
    private Customer customer;
    /**
     *移交人员
     */
    private Employee transUser;
    /**
     *移交时间
     */
    private Date transTime = new Date();
    /**
     *老市场专员
     */
    private Employee oldSeller;
    /**
     *新市场专员
     */
    private Employee newSeller;
    /**
     * 移交原因
     */
    private String transReason;
    /**
     * 所属租户
     */
    private Tenant tenant;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Employee getTransUser() {
        return transUser;
    }

    public void setTransUser(Employee transUser) {
        this.transUser = transUser;
    }
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    public Date getTransTime() {
        return transTime;
    }

    public void setTransTime(Date transTime) {
        this.transTime = transTime;
    }

    public Employee getOldSeller() {
        return oldSeller;
    }

    public void setOldSeller(Employee oldSeller) {
        this.oldSeller = oldSeller;
    }

    public Employee getNewSeller() {
        return newSeller;
    }

    public void setNewSeller(Employee newSeller) {
        this.newSeller = newSeller;
    }

    public String getTransReason() {
        return transReason;
    }

    public void setTransReason(String transReason) {
        this.transReason = transReason;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @Override
    public String toString() {
        return "CutomerTransfer{" +
                "id=" + id +
                ", customer=" + customer +
                ", transUser=" + transUser +
                ", transTime=" + transTime +
                ", oldSeller=" + oldSeller +
                ", newSeller=" + newSeller +
                ", transReason='" + transReason + '\'' +
                ", tenant=" + tenant +
                '}';
    }
}
