package cn.it.crm.query;

import cn.it.crm.core.query.BaseQuery;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ContractQuery extends BaseQuery {
    //住户ID
    private  Long tenantId;
    private String name;

    private Date beginTime;

    private Date endTime;
    @Override
    public Long getTenantId() {
        return tenantId;
    }

    @Override
    public void setTenantId(Long tenantId) {
        this.tenantId = tenantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBeginTime() {
        return beginTime;
    }
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    public void setEndTime(Date endTime) {
        this.endTime = DateUtils.addDays(endTime, 1);
    }

    @Override
    public String toString() {
        return "ContractQuery{" +
                "tenantId=" + tenantId +
                ", name='" + name + '\'' +
                ", beginTime=" + beginTime +
                ", endTime=" + endTime +
                '}';
    }
}
