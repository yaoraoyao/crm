package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.CustomerTransfer;
import cn.it.crm.mapper.CustomerTransferMapper;
import cn.it.crm.service.ICustomerTransferService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerTransferServiceImpl extends BaseServiceImpl<CustomerTransfer> implements ICustomerTransferService{
    @Autowired
    private CustomerTransferMapper customerTransferMapper;

    @Override
    protected IBaseMapper<CustomerTransfer> getMapper() {
        return customerTransferMapper;
    }
}
