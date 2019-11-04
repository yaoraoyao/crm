package cn.itsource.ssm.mapper;

import cn.itsource.ssm.domain.Department;
import cn.itsource.ssm.service.IDepartmentService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class DepartmentMapperTest {

    @Autowired
    private IDepartmentService departmentService;

    @Test
    public void getOne() {
    }

    @Test
    public void getAll() {
    }

    @Test
    public void save() {
        Department department = new Department();
        department.setName("nnnnaaabbbbb");
        departmentService.save(department);


    }
}