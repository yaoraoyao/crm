package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class CustomerDevPlan {
    private Long id;
    /**
     * 计划时间
     */
    private Date planTime;
    /**
     * 计划主题
     */
    private String planSubject;
    /**
     * 计划内容
     */
    private String planDetails;
    /**
     * 计划实施方式
     */
    private SystemDictionaryItem planType;
    /**
     * 潜在客户
     */
    private Customer customer;
    /**
     * 创建人
     */
    private Employee inputUser;
    /**
     * 创建时间
     */
    private Date inputTime = new Date();
    /**
     * 计划实行结果：
     */
    private Integer state = 0;
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
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    public Date getPlanTime() {
        return planTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setPlanTime(Date planTime) {
        this.planTime = planTime;
    }

    public String getPlanSubject() {
        return planSubject;
    }

    public void setPlanSubject(String planSubject) {
        this.planSubject = planSubject;
    }

    public String getPlanDetails() {
        return planDetails;
    }

    public void setPlanDetails(String planDetails) {
        this.planDetails = planDetails;
    }

    public SystemDictionaryItem getPlanType() {
        return planType;
    }

    public void setPlanType(SystemDictionaryItem planType) {
        this.planType = planType;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Employee getInputUser() {
        return inputUser;
    }

    public void setInputUser(Employee inputUser) {
        this.inputUser = inputUser;
    }
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    public Date getInputTime() {
        return inputTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setInputTime(Date inputTime) {
        this.inputTime = inputTime;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @Override
    public String toString() {
        return "CustomerDevPlan{" +
                "id=" + id +
                ", planTime=" + planTime +
                ", planSubject='" + planSubject + '\'' +
                ", planDetails='" + planDetails + '\'' +
                ", planType=" + planType +
                ", customer=" + customer +
                ", inputUser=" + inputUser +
                ", inputTime=" + inputTime +
                ", state=" + state +
                ", tenant=" + tenant +
                '}';
    }
}
