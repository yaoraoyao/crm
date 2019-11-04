package cn.it.crm.domain;

import java.util.ArrayList;
import java.util.List;

public class Permission {
    private Long id;
    //权限名称
    private String name;
    //权限地址
    private String url;
    //租客信息
    private Long tenant_id;
    //菜单
    private Long menu_id;
    /**
     * 多个权限对应一个菜单
     */
    private Menu menu;

    private Long roleId;

    private String sn;

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    //一个权限对应多个角色
    private List<Role> roles = new ArrayList<>();

    public Permission() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Long getTenant_id() {
        return tenant_id;
    }

    public void setTenant_id(Long tenant_id) {
        this.tenant_id = tenant_id;
    }

    public Long getMenu_id() {
        return menu_id;
    }

    public void setMenu_id(Long menu_id) {
        this.menu_id = menu_id;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", tenant_id=" + tenant_id +
                ", menu_id=" + menu_id +
                ", menu=" + menu +
                ", roleId=" + roleId +
                ", sn='" + sn + '\'' +
                ", roles=" + roles +
                '}';
    }
}


