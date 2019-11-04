package cn.it.crm.query;

import cn.it.crm.core.query.BaseQuery;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class CustomerDevPlanQuery extends BaseQuery {
    private Date beginDate;
    private Date endDate;
    private String customerName;
    private Integer state;

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

    public Integer getState() {
        return state;
    }

    public void setState(String state) {
        if(state != null){
            if(state.contains("未")){
                this.state = 0;
            }else if(state.contains("待定")){
                this.state = 2;
            }else if(state.contains("成功")){
                this.state = 1;
            }else if(state.equals("失败")){
                this.state = -1;
            }
        }
    }

    @Override
    public String toString() {
        return "CustomerDevPlanQuery{" +
                "beginDate=" + beginDate +
                ", endDate=" + endDate +
                ", customerName='" + customerName + '\'' +
                ", state=" + state +
                '}';
    }
}
