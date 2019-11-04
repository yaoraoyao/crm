package cn.it.crm.domain;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * 员工管理domain
 *
 */
public class Department {
    /**
     *部门id
     * */
    private Long id;
    /**
     *部门编号
     * */
    private String sn;
    /**
     *部门名称
     * */
    private String name;
    /**
     *部门经理
     * */
    private String  manager_id;
    /**
     *上级部门
     * */
    private Long parent_id;
    private Department parent;
    /**
     *子部门
     * */
    private List<Department> childrens=new ArrayList<Department>();

    /**
     *路径
     * */

    /**
     *部门状态
     *1正常 ，0停用
     * */
    private Integer state;
    /**
     *租户
     * */
    private Long tenant_id;
    private Tenant tenant;
    private Employee employee;

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Long getParent_id() {
        return parent_id;
    }

    public void setParent_id(Long parent_id) {
        this.parent_id = parent_id;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
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

    public String getManager_id() {
        return manager_id;
    }

    public void setManager_id(String manager_id) {
        this.manager_id = manager_id;
    }

    public Department getParent() {
        return parent;
    }

    public void setParent(Department parent) {
        this.parent = parent;
    }

    public List<Department> getChildrens() {
        return childrens;
    }

    public void setChildrens(List<Department> childrens) {
        this.childrens = childrens;
    }



    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Long getTenant_id() {
        return tenant_id;
    }

    public void setTenant_id(Long tenant_id) {
        this.tenant_id = tenant_id;
    }

    @Override
    public String toString() {
        return "Department{" +
                "id=" + id +
                ", sn='" + sn + '\'' +
                ", name='" + name + '\'' +
                ", manager='" + manager_id + '\'' +
                ", parent_id=" + parent_id +
                ", parent=" + parent +
                ", childrens=" + childrens +
                ", state=" + state +
                ", tenant_id=" + tenant_id +
                ", tenant=" + tenant +
                '}';
    }
}
