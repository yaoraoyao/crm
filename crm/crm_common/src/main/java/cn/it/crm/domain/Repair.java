package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Repair {

    private Long id;
    //父级合同单号
    private String sn;
    //保修单号
    private String warrantysn;
    //保修客户
    private String customer;
    //开始时间
    private Date startTime;
    //到期时间
    private Date endTime;
    //保修状态
    private Integer status;
    //所属租户
    private Long tenant_id;

    @Override
    public String toString() {
        return "Repair{" +
                "id=" + id +
                ", sn='" + sn + '\'' +
                ", warrantysn='" + warrantysn + '\'' +
                ", customer='" + customer + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", status=" + status +
                ", tenant_id=" + tenant_id +
                '}';
    }

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

    public String getWarrantysn() {
        return warrantysn;
    }

    public void setWarrantysn(String warrantysn) {
        this.warrantysn = warrantysn;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getStartTime() {
        return startTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getEndTime() {
        return endTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Long getTenant_id() {
        return tenant_id;
    }

    public void setTenant_id(Long tenant_id) {
        this.tenant_id = tenant_id;
    }
}
