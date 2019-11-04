package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class AfterSaleItem {

    private Long id;

    private String sn;
    //保修日期
    private Date repairTime;
    //保修内容
    private  String  content;
    //是否解决
    private Boolean isSolve=false;

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
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone ="GMT+8")
    public Date getRepairTime() {
        return repairTime;
    }
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    public void setRepairTime(Date repairTime) {
        this.repairTime = repairTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Boolean getIsSolve() {
        return isSolve;
    }

    public void setIsSolve(Boolean solve) {
        isSolve = solve;
    }
}
