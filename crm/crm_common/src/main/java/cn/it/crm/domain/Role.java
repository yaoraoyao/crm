package cn.it.crm.domain;

import java.util.ArrayList;
import java.util.List;

public class Role {
    private Long id;
    //角色编号
    private String sn;
    //角色名称
    private String name;
    //租客id
    private Long tenant_id;

    //一个角色对应多个权限
    private List<Permission> rpermissions = new ArrayList<>();

    private Tenant tenant;

    public Role() {
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getTenant_id() {
        return tenant_id;
    }

    public void setTenant_id(Long tenant_id) {
        this.tenant_id = tenant_id;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    public List<Permission> getRpermissions() {
        return rpermissions;
    }

    public void setRpermissions(List<Permission> rpermissions) {
        this.rpermissions = rpermissions;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", sn='" + sn + '\'' +
                ", name='" + name + '\'' +
                ", tenant_id=" + tenant_id +
                ", rpermissions=" + rpermissions +
                ", tenant=" + tenant +
                '}';
    }
}
