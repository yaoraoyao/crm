package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Customer;
import cn.it.crm.domain.CustomerDevPlan;
import cn.it.crm.mapper.CustomerDevPlanMapper;
import cn.it.crm.mapper.CustomerMapper;
import cn.it.crm.service.ICustomerDevPlanService;
import cn.it.crm.service.ICustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerDevPlanServiceImpl extends BaseServiceImpl<CustomerDevPlan> implements ICustomerDevPlanService{

    @Autowired
    private CustomerDevPlanMapper customerDevPlanMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    protected IBaseMapper<CustomerDevPlan> getMapper() {
        return customerDevPlanMapper;
    }

    @Override
    public void update(CustomerDevPlan customerDevPlan){
        Customer customer = customerMapper.findOne(customerDevPlan.getCustomer().getId());
        if(customerDevPlan.getState() != 0 && customerDevPlan.getState() != 2){
            customer.setState(customerDevPlan.getState());
        }else{
            customer.setState(0);
        }
        customerMapper.update(customer);
        customerDevPlanMapper.update(customerDevPlan);
    }
}
