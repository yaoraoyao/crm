package cn.itsource.ssm.service;

import cn.itsource.ssm.domain.Department;

import java.util.List;

public interface IDepartmentService {

    List<Department> getAll();

    void save(Department department);
}
