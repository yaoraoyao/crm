package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.text.SimpleDateFormat;
import java.util.Date;

public class SystemLog {
    private Long id;
    private String opUser;
    private Date opTime = new Date();
    private String opIp;
    private String function;
    private String params;
    private Long tenantId;
    private String opTimeStr;

    public void setOpTimeStr(String opTimeStr) {
        this.opTimeStr = opTimeStr;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOpUser() {
        return opUser;
    }

    public void setOpUser(String opUser) {
        this.opUser = opUser;
    }
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getOpTime() {
        return opTime;
    }

    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    public String getOpIp() {
        return opIp;
    }

    public void setOpIp(String opIp) {
        this.opIp = opIp;
    }

    public String getFunction() {
        return function;
    }

    public void setFunction(String function) {
        this.function = function;
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }

    public Long getTenantId() {
        return tenantId;
    }

    public void setTenantId(Long tenantId) {
        this.tenantId = tenantId;
    }

    public String getOpTimeStr(){
        SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
        return format.format(opTime);
    }
    @Override
    public String toString() {
        return "SystemLog{" +
                "id=" + id +
                ", opUser='" + opUser + '\'' +
                ", opTime=" + opTime +
                ", opIp='" + opIp + '\'' +
                ", function='" + function + '\'' +
                ", params='" + params + '\'' +
                ", tenantId=" + tenantId +
                '}';
    }
}
