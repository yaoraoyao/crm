package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.SystemDictionary;
import cn.it.crm.mapper.SystemDictionaryMapper;
import cn.it.crm.service.ISystemDictionaryService;
import cn.it.crm.util.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Service
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class SystemDictionaryServiceImpl extends BaseServiceImpl<SystemDictionary> implements ISystemDictionaryService {
    @Autowired
    private SystemDictionaryMapper systemDictionaryMapper;

    @Override
    public IBaseMapper<SystemDictionary> getMapper() {
        return systemDictionaryMapper;
    }

    @Override
    @Operation
    public List<SystemDictionary> findAllByTenantId(Serializable tenantId) {
        return systemDictionaryMapper.findAllByTenantId(tenantId);
    }

}
