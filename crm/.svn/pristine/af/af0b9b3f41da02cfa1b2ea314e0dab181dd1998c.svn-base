package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.CustomerTraceHistory;
import cn.it.crm.mapper.CustomerTraceHistoryMapper;
import cn.it.crm.service.ICustomerTraceHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerTraceHistoryServiceImpl extends BaseServiceImpl<CustomerTraceHistory> implements ICustomerTraceHistoryService{
    @Autowired
    private CustomerTraceHistoryMapper customerTraceHistoryMapper;

    @Override
    protected IBaseMapper<CustomerTraceHistory> getMapper() {
        return customerTraceHistoryMapper;
    }
}
