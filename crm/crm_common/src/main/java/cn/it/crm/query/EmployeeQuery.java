package cn.it.crm.query;

import cn.it.crm.core.query.BaseQuery;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class EmployeeQuery extends BaseQuery {
    private String username;

    private Date beginTime;

    private Date endTime;


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getBeginTime() {
        return beginTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getEndTime() {
        return endTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "EmployeeQuery{" +
                "username='" + username + '\'' +
                ", beginTime=" + beginTime +
                ", endTime=" + endTime +
                '}';
    }
}
