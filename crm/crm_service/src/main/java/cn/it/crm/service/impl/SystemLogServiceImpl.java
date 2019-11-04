package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.SystemLog;
import cn.it.crm.lucene.LogLucene;
import cn.it.crm.mapper.SystemLogMapper;
import cn.it.crm.query.SystemLogQuery;
import cn.it.crm.service.ISystemLogService;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class SystemLogServiceImpl extends BaseServiceImpl<SystemLog> implements ISystemLogService {
    @Autowired
    private SystemLogMapper systemLogMapper;

    @Override
    public IBaseMapper<SystemLog> getMapper() {
        return systemLogMapper;
    }

    @Override
    public PageList<SystemLog> findBySystemLogQuery(SystemLogQuery query) throws Exception {
        return LogLucene.getInstance().query(query);
    }
}
