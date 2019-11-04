package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;

public class Employee {
    //员工id
    private Long id;
    //员工账号
    private String username;
    //真实姓名
    private String realname;
    //密码
    private String password;
    //电话
    private String tel;
    //邮箱
    private String email;
    //部门
    /*private Long dept_id;

    public Long getDept_id() {
        return dept_id;
    }

    public void setDept_id(Long dept_id) {
        this.dept_id = dept_id;
    }*/
    private Long department_id;
    private Department department;
    //录入时间

    private Date inputTime;
    //状态
    private Integer state;

    //所属租户外键
    private Long  tenant_id;
    private Tenant tenant;

    private String openid;

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getInputTime() {
        return inputTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setInputTime(Date inputTime) {
        this.inputTime = inputTime;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Long getTenant_id() {
        return tenant_id;
    }

    public Long getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(Long department_id) {
        this.department_id = department_id;
    }

    public void setTenant_id(Long tenant_id) {
        this.tenant_id = tenant_id;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", realname='" + realname + '\'' +
                ", password='" + password + '\'' +
                ", tel='" + tel + '\'' +
                ", email='" + email + '\'' +
                ", department_id=" + department_id +
                ", department=" + department +
                ", inputTime=" + inputTime +
                ", state=" + state +
                ", tenant_id=" + tenant_id +
                ", tenant=" + tenant +
                ", openid='" + openid + '\'' +
                '}';
    }
}
