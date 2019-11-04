package cn.it.crm.domain;


import cn.afterturn.easypoi.excel.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.util.Date;

public class Customer {
    private Long id;
    @Excel(name = "姓名")
    @NotNull(message = "用户名不为空!")
    String name;
    @Excel(name = "年龄")
    @Min(value = 16,message = "年龄小于16!")
    private Integer age;
    @Excel(name = "性别", replace = {"男_1","女_0"})
    @NotNull(message = "性别不为空!")
    private Integer gender;
    @Excel(name = "电话")
    @NotNull(message = "电话号码不为空!")
    private String tel;
    private String email;
    private String qq;
    private String wechat;
    /**
     *营销人员
     */
    private Employee seller;
    /**
     * 职业
     */
    private SystemDictionaryItem job;
    /**
     * 收入水平
     */
    private SystemDictionaryItem salaryLevel;
    /**
     * 客户来源
     */
    private SystemDictionaryItem customerSource;
    /**
     * 创建人
     */
    private Employee inputUser;
    /**
     * 录入时间
     */
    private Date inputTime = new Date();
    /**
     * 成功机率
     */
    @Excel(name = "成功率")
    @NotNull(message = "成功率不能为空!")
    private Double successRate;
    /**
     * 客户状态：0-潜在客户，1-正式客户，-1-失败客户
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat;
    }

    public Employee getSeller() {
        return seller;
    }

    public void setSeller(Employee seller) {
        this.seller = seller;
    }

    public SystemDictionaryItem getJob() {
        return job;
    }

    public void setJob(SystemDictionaryItem job) {
        this.job = job;
    }

    public SystemDictionaryItem getSalaryLevel() {
        return salaryLevel;
    }

    public void setSalaryLevel(SystemDictionaryItem salaryLevel) {
        this.salaryLevel = salaryLevel;
    }

    public SystemDictionaryItem getCustomerSource() {
        return customerSource;
    }

    public void setCustomerSource(SystemDictionaryItem customerSource) {
        this.customerSource = customerSource;
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

    public Double getSuccessRate() {
        return successRate;
    }

    public void setSuccessRate(Double successRate) {
        this.successRate = successRate;
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
        return "Customer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", gender=" + gender +
                ", tel='" + tel + '\'' +
                ", email='" + email + '\'' +
                ", qq='" + qq + '\'' +
                ", wechat='" + wechat + '\'' +
                ", seller=" + seller +
                ", job=" + job +
                ", salaryLevel=" + salaryLevel +
                ", customerSource=" + customerSource +
                ", inputUser=" + inputUser +
                ", inputTime=" + inputTime +
                ", successRate=" + successRate +
                ", state=" + state +
                ", tenant=" + tenant +
                '}';
    }
}
