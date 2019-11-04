package cn.it.crm.core.mapper;


import cn.it.crm.core.query.BaseQuery;

import java.io.Serializable;
import java.util.List;

public interface IBaseMapper<T> {
    List<T> findAll();
    T findOne(Serializable id);
    void save(T t);
    void delete(Serializable id);
    void update(T t);
    List<T> findByQuery(BaseQuery baseQuery);
}
