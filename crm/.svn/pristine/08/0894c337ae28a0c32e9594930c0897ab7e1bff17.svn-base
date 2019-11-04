package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class CustomerTraceHistory {
    private Long id;
    /**
     * 客户
     */
    private Customer customer;
    /**
     * 跟进人
     */
    private Employee traceUser;
    /**
     * 跟进时间
     */
    private Date traceTime;
    /**
     * 跟进方式
     */
    private SystemDictionaryItem traceType;
    /**
     * 跟进效果
     */
    private Integer traceResult;
    /**
     * 跟进主题
     */
    private String title;
    /**
     * 备注
     */
    private String remark;
    /**
     * 租户
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

    public Employee getTraceUser() {
        return traceUser;
    }

    public void setTraceUser(Employee traceUser) {
        this.traceUser = traceUser;
    }
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    public Date getTraceTime() {
        return traceTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setTraceTime(Date traceTime) {
        this.traceTime = traceTime;
    }

    public SystemDictionaryItem getTraceType() {
        return traceType;
    }

    public void setTraceType(SystemDictionaryItem traceType) {
        this.traceType = traceType;
    }

    public Integer getTraceResult() {
        return traceResult;
    }

    public void setTraceResult(Integer traceResult) {
        this.traceResult = traceResult;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @Override
    public String toString() {
        return "CustomerTraceHistory{" +
                "id=" + id +
                ", customer=" + customer +
                ", traceUser=" + traceUser +
                ", traceTime=" + traceTime +
                ", traceType=" + traceType +
                ", traceResult=" + traceResult +
                ", title='" + title + '\'' +
                ", remark='" + remark + '\'' +
                ", tenant=" + tenant +
                '}';
    }
}
