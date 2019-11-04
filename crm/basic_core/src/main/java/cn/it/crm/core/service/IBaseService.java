package cn.it.crm.core.service;

import cn.it.crm.core.query.BaseQuery;
import cn.it.crm.util.PageList;

import java.io.Serializable;
import java.util.List;

public interface IBaseService<T> {
    List<T> findAll();
    T findOne(Serializable id);
    void save(T t);
    void delete(Serializable id);
    void update(T t);
    PageList<T> findByPage(BaseQuery baseQuery);
}
