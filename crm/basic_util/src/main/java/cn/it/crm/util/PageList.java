package cn.it.crm.util;

import java.util.ArrayList;
import java.util.List;

public class PageList <T>{
    //总共有多少行
    private Long total=0L;

    //当前页的数据集合
    private List<T> rows = new ArrayList<>();

    public PageList() {
    }

    public PageList(Long total, List<T> rows) {
        this.total = total;
        this.rows = rows;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
