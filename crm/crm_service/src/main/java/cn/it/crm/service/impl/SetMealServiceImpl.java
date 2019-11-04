package cn.it.crm.service.impl;


import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.SetMeal;
import cn.it.crm.mapper.SetMealMapper;
import cn.it.crm.service.ISetMealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;

@Service
public class SetMealServiceImpl extends BaseServiceImpl<SetMeal> implements ISetMealService {

    @Autowired
    private SetMealMapper setMealMapper;
    @Autowired

    @Override
    protected IBaseMapper<SetMeal> getMapper() {
        return  setMealMapper;
    }

    @Override
    public List<SetMeal> findStatus(Serializable id) {
        List<SetMeal> status = setMealMapper.findStatus(id);
        return status;
    }
}
