package cn.it.crm.mapper;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.SetMeal;

import java.io.Serializable;
import java.util.List;

public interface SetMealMapper extends IBaseMapper<SetMeal> {
    List<SetMeal> findStatus(Serializable id);

}
