package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Customer;
import cn.it.crm.domain.Order;
import cn.it.crm.mapper.OrderMapper;
import cn.it.crm.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl extends BaseServiceImpl<Order> implements IOrderService {
    @Autowired
    private OrderMapper orderMapper;

    @Override
    public IBaseMapper<Order> getMapper() {
        return orderMapper;
    }

    @Override
    public List<Customer> findCustomerByTelOrName(Customer customer) {
        return orderMapper.findCustomerByTelOrName(customer);
    }
}
