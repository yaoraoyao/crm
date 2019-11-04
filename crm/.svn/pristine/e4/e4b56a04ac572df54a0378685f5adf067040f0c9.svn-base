package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Tenant;
import cn.it.crm.mapper.TenantMapper;
import cn.it.crm.service.ITenantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TenantServiceImpl extends BaseServiceImpl<Tenant> implements ITenantService {

    @Autowired
    private TenantMapper tenantMapper;

    @Override
    protected IBaseMapper<Tenant> getMapper() {
        return tenantMapper;
    }
}
