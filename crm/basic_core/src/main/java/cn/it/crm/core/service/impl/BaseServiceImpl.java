package cn.it.crm.core.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.query.BaseQuery;
import cn.it.crm.core.service.IBaseService;
import cn.it.crm.util.Execute;
import cn.it.crm.util.Operation;
import cn.it.crm.util.PageList;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import java.io.Serializable;
import java.util.List;

public abstract class BaseServiceImpl<T> implements IBaseService<T> {

    protected abstract IBaseMapper<T> getMapper();

    @Override
    public List<T> findAll() {
        return getMapper().findAll();
    }

    @Override
    public T findOne(Serializable id) {
        return getMapper().findOne(id);
    }

    @Override
    @Operation(execute = Execute.SAVE)
    public void save(T t) {
        getMapper().save(t);
    }

    @Override
    @Operation(execute = Execute.DELETE)
    public void delete(Serializable id) {
        getMapper().delete(id);
    }

    @Override
    @Operation(execute = Execute.UPDATE)
    public void update(T t) {
        getMapper().update(t);
    }

    @Override
    public PageList<T> findByPage(BaseQuery baseQuery) {
        PageList<T> pageList = new PageList<T>();
        Page<T> page = PageHelper.startPage(baseQuery.getPageNum(), baseQuery.getPageSize());
        List<T> query = getMapper().findByQuery(baseQuery);
        pageList.setTotal(page.getTotal());
        pageList.setRows(query);
        return pageList;
    }
}
