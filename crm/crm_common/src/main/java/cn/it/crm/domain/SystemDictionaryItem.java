package cn.it.crm.domain;

/**
 * 系统数据字典明细
 */
public class SystemDictionaryItem {
    /**
     * id
     */
    private Long id;
    /**
     * 数据字典类型
     */
    private SystemDictionary parent;
    /**
     * 明细类型
     */
    private String name;
    /**
     * 明细编号
     */
    private String sn;
    /**
     * 介绍
     */
    private String intro;
    /**
     * 所属租户
     */
    private Long tenantId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public SystemDictionary getParent() {
        return parent;
    }

    public void setParent(SystemDictionary parent) {
        this.parent = parent;
    }

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

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public Long getTenantId() {
        return tenantId;
    }

    public void setTenantId(Long tenantId) {
        this.tenantId = tenantId;
    }

    public SystemDictionaryItem() {
    }

    @Override
    public String toString() {
        return "SystemDictionaryItem{" +
                "id=" + id +
                ", parent=" + parent +
                ", name='" + name + '\'' +
                ", sn='" + sn + '\'' +
                ", intro='" + intro + '\'' +
                ", tenantId=" + tenantId +
                '}';
    }
}
