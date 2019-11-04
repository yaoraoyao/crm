package cn.it.crm.test;

import cn.it.crm.domain.Employee;
import cn.it.crm.mapper.EmployeeMapper;
import cn.it.crm.service.shiro.EncryptPassword;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class PasswordTest {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Test
    public void testPassword () throws Exception{
        List<Employee> list = employeeMapper.findAll();
        for (Employee employee : list) {
            employee.setPassword(EncryptPassword.encrypt(employee.getUsername()));
            employeeMapper.update(employee);
        }
    }
}
