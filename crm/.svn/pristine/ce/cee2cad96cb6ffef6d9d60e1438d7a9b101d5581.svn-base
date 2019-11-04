package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Employee;
import cn.it.crm.domain.Menu;
import cn.it.crm.domain.Permission;
import cn.it.crm.mapper.PermissionMapper;
import cn.it.crm.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class PermissionServiceImpl extends BaseServiceImpl<Permission> implements IPermissionService{

    @Autowired
    private PermissionMapper permissionMapper;
    @Override
    public IBaseMapper<Permission> getMapper() {
        return permissionMapper;
    }

    @Override
    public void delete(Serializable id) {
        try {
            permissionMapper.deletePermissions((Long)id);
            permissionMapper.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Set<String> findPermissionByEmpId(Long id) {
        List<Permission> permissions = permissionMapper.findPermissionByEmpId(id);
        HashSet<String> set = new HashSet<>();
        for (Permission permission : permissions) {
            set.add(permission.getSn());
        }

        return set;
    }

    @Override
    public Employee selectOneByUserName(String username) {
        return permissionMapper.selectOneByUserName(username);
    }

    @Override
    public List<Menu> selectParentMenu() {
        return permissionMapper.selectParentMenu();
    }


}
