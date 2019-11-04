package cn.it.crm.service;

import cn.it.crm.core.service.IBaseService;
import cn.it.crm.domain.Customer;
import cn.it.crm.query.CustomerQuery;

import java.util.List;

public interface ICustomerService extends IBaseService<Customer> {
    void updateSeller(CustomerQuery customerQuery);
    List<Customer> findAllQuery(CustomerQuery customerQuery);
}
