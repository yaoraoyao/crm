package cn.it.crm.query;

import cn.it.crm.core.query.BaseQuery;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class CustomerTraceHistoryQuery extends BaseQuery {
    private Date beginDate;
    private Date endDate;
    private String customerName;
    private String traceUserName;

    public Date getBeginDate() {
        return beginDate;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setBeginDate(Date beginDate) {
        this.beginDate = beginDate;
    }

    public Date getEndDate() {
        return endDate;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setEndDate(Date endDate) {
        if(endDate != null){
            Date date = DateUtils.addDays(endDate, 1);
            this.endDate = date;
        }
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getTraceUserName() {
        return traceUserName;
    }

    public void setTraceUserName(String traceUserName) {
        this.traceUserName = traceUserName;
    }

    @Override
    public String toString() {
        return "CustomerTraceHistoryQuery{" +
                "beginDate=" + beginDate +
                ", endDate=" + endDate +
                ", customerName='" + customerName + '\'' +
                ", traceUserName='" + traceUserName + '\'' +
                '}';
    }
}
