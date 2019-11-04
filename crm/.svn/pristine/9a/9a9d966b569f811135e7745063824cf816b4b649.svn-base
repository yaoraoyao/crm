package cn.it.crm.domain;

import java.util.ArrayList;
import java.util.List;

/**
 * 菜单实体类
 */
public class Menu {
    /**
     * 主键
     */
    private Long id;
    /**
     * 菜单编号
     */
    private String sn;
    /**
     * 菜单名
     */
    private String label;
    /**
     * 父级菜单
     */
    private Menu parent;
    /**
     *父级菜单id
     */
    private Long parentId;
    /**
     * 子菜单
     */
    private List<Menu> children = new ArrayList<>();
    /**
     * link
     */
    private String url;
    /**
     * 菜单介绍
     */
    private String intro;

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

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public Menu getParent() {
        return parent;
    }

    public void setParent(Menu parent) {
        this.parent = parent;
    }

    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public Menu() {
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "id=" + id +
                ", sn='" + sn + '\'' +
                ", label='" + label + '\'' +
                ", parent=" + parent +
                ", parentId=" + parentId +
                ", children=" + children +
                ", url='" + url + '\'' +
                ", intro='" + intro + '\'' +
                '}';
    }
}
