package cn.it.crm.mapper;


import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.Customer;
import cn.it.crm.domain.Order;

import java.util.List;

public interface OrderMapper extends IBaseMapper<Order> {
   List<Customer>  findCustomerByTelOrName(Customer customer);

}
