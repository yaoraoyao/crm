package cn.it.crm.query;

import cn.it.crm.core.query.BaseQuery;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class SystemLogQuery extends BaseQuery {
    private String str;

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    private String function;

    private String opUser;

    private Date opTime;

    public String getFunction() {
        return function;
    }

    public void setFunction(String function) {
        this.function = function;
    }

    public String getOpUser() {
        return opUser;
    }

    public void setOpUser(String opUser) {
        this.opUser = opUser;
    }

    public Date getOpTime() {
        return opTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd HH-mm-ss")
    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    @Override
    public String toString() {
        return "SystemLogQuery{" +
                super.toString() +
                "function='" + function + '\'' +
                ", opUser='" + opUser + '\'' +
                ", opTime=" + opTime +
                '}';
    }
}
