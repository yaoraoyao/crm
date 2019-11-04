package cn.it.crm.mapper;


import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.SystemDictionary;

import java.io.Serializable;
import java.util.List;

public interface SystemDictionaryMapper extends IBaseMapper<SystemDictionary> {
    List<SystemDictionary> findAllByTenantId(Serializable tenantId);
}
