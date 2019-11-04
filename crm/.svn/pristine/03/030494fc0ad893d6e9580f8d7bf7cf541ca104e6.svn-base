package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Resource;
import cn.it.crm.mapper.ResourceMapper;
import cn.it.crm.service.IResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResourceServiceImpl extends BaseServiceImpl<Resource> implements IResourceService{

    @Autowired
    private ResourceMapper resourceMapper;

    @Override
    protected IBaseMapper<Resource> getMapper() {
        return resourceMapper;
    }

    @Override
    public void save(Resource resource) {
         resourceMapper.save(resource);
    }

    @Override
    public void update(Resource resource) {
        resourceMapper.update(resource);
    }

}
