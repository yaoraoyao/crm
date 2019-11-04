package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Customer;
import cn.it.crm.mapper.CustomerMapper;
import cn.it.crm.query.CustomerQuery;
import cn.it.crm.service.ICustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl extends BaseServiceImpl<Customer> implements ICustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    protected IBaseMapper<Customer> getMapper() {
        return customerMapper;
    }

    @Override
    public void updateSeller(CustomerQuery customerQuery) {
        customerMapper.updateSeller(customerQuery);
    }

    @Override
    public List<Customer> findAllQuery(CustomerQuery customerQuery) {
        return customerMapper.findByQuery(customerQuery);
    }
}
