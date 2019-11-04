package cn.it.crm.query;


import cn.it.crm.core.query.BaseQuery;

public class DepartmentQuery extends BaseQuery {
    private String name;
    private String sn;
    private String  manager;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    @Override
    public String toString() {
        return "DepartmentQuery{" +
                "name='" + name + '\'' +
                ", sn='" + sn + '\'' +
                ", manager='" + manager + '\'' +
                '}';
    }
}
