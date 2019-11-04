package cn.it.crm.mapper;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.Customer;
import cn.it.crm.query.CustomerQuery;

public interface CustomerMapper extends IBaseMapper<Customer> {
    void updateSeller(CustomerQuery customerQuery);
}
