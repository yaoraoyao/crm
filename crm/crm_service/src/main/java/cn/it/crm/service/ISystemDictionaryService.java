package cn.it.crm.service;


import cn.it.crm.core.service.IBaseService;
import cn.it.crm.domain.SystemDictionary;

import java.io.Serializable;
import java.util.List;

public interface ISystemDictionaryService extends IBaseService<SystemDictionary> {
    List<SystemDictionary> findAllByTenantId(Serializable tenantId);
}