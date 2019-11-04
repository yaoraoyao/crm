package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.SystemDictionaryItem;
import cn.it.crm.mapper.SystemDictionaryItemMapper;
import cn.it.crm.service.ISystemDictionaryItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class SystemDictionaryItemServiceImpl extends BaseServiceImpl<SystemDictionaryItem> implements ISystemDictionaryItemService {
    @Autowired
    private SystemDictionaryItemMapper systemDictionaryItemMapper;

    @Override
    public IBaseMapper<SystemDictionaryItem> getMapper() {
        return systemDictionaryItemMapper;
    }
}
