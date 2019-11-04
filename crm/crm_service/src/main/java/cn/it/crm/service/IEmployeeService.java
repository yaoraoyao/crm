package cn.it.crm.service;

import cn.it.crm.core.service.IBaseService;
import cn.it.crm.domain.Employee;

public interface IEmployeeService extends IBaseService<Employee> {
    Employee findByUsernames(String username);

    Employee findByOpenid(String openid);
}
