package cn.itsource.ssm.service.impl;

import cn.itsource.ssm.domain.Department;
import cn.itsource.ssm.mapper.DepartmentMapper;
import cn.itsource.ssm.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Transactional(propagation = Propagation.SUPPORTS,readOnly = true)//只读
@Service
public class DepartmentServiceImpl implements IDepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAll() {
        return departmentMapper.getAll();
    }

    @Transactional(propagation = Propagation.REQUIRED,readOnly = false)//只写=等价事务=>@Transactional
    @Override
    public void save(Department department) {
        departmentMapper.save(department);
        int i=1/0;
    }
}
