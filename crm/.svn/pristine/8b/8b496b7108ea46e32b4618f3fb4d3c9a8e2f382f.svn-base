package cn.it.crm.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 保修单明细
 */
public class RepairItem {

    private Long id;
    //归属保修单
    private String warrantysn;
    //保修时间
    private Date repairTime;
    //保修内容
    private String details;
    //是否解决
    private Integer solve;

    @Override
    public String toString() {
        return "RepairItem{" +
                "id=" + id +
                ", repairTime=" + repairTime +
                ", details='" + details + '\'' +
                ", solve=" + solve +
                '}';
    }

    public String getWarrantysn() {
        return warrantysn;
    }

    public void setWarrantysn(String warrantysn) {
        this.warrantysn = warrantysn;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    public Date getRepairTime() {
        return repairTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setRepairTime(Date repairTime) {
        this.repairTime = repairTime;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public Integer getSolve() {
        return solve;
    }

    public void setSolve(Integer solve) {
        this.solve = solve;
    }
}
