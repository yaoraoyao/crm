package cn.it.crm.query;

import cn.it.crm.core.query.BaseQuery;

public class CustomerQuery extends BaseQuery {
    private String seller;
    private Long sellerId;
    private String ids;
    private String name;
    private Integer state;
    private Integer states;
    private Long id;

    public Integer getStates() {
        return states;
    }

    public void setStates(Integer states) {
        this.states = states;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public String getSeller() {
        return seller;
    }

    public void setSeller(String seller) {
        this.seller = seller;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getState() {
        return state;
    }

    public void setState(String state) {
        if(state != null){
            if(state.contains("潜在")){
                this.state = 0;
            }else if(state.contains("正式") || state.equals("1")){
                this.state = 1;
            }else if(state.contains("资源池")){
                this.state = -1;
            }else if(state.equals("10")){
                this.state = 10;
            }
        }
    }

    @Override
    public String toString() {
        return "CustomerQuery{" +
                "seller='" + seller + '\'' +
                ", sellerId=" + sellerId +
                ", ids='" + ids + '\'' +
                ", name='" + name + '\'' +
                ", state=" + state +
                ", states=" + states +
                ", id=" + id +
                '}';
    }
}
