package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Employee;
import cn.it.crm.mapper.EmployeeMapper;
import cn.it.crm.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiceImpl extends BaseServiceImpl<Employee> implements IEmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;
    protected IBaseMapper<Employee> getMapper() {
        return employeeMapper;
    }

    @Override
    public Employee findByUsernames(String username) {
        return employeeMapper.findByUsernames(username);
    }

    @Override
    public Employee findByOpenid(String openid) {
        return employeeMapper.findByOpenid(openid);
    }
}
