package cn.itsource.ssm.mapper;

import cn.itsource.ssm.domain.Department;

import java.util.List;

public interface DepartmentMapper {

    Department getOne(Long id);
    List<Department> getAll();

    void save(Department department);
}
