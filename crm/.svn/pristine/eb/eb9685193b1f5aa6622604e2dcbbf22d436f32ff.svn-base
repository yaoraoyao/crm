package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Permission;
import cn.it.crm.domain.Role;
import cn.it.crm.mapper.RoleMapper;
import cn.it.crm.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;

@Service
public class RoleServiceImpl extends BaseServiceImpl<Role> implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;
    @Override
    public IBaseMapper<Role> getMapper() {
        return roleMapper;
    }
    @Override
    public void save(Role role) {
        System.out.println(role);
        if(role.getId()!=null){
            roleMapper.update(role);
        }else {
            roleMapper.save(role);
        }
        if(role.getRpermissions()!=null){
            roleMapper.deletePermissions(role.getId());

            for (Permission permission : role.getRpermissions()) {
                permission.setRoleId(role.getId());
            }
            roleMapper.savePerssions(role.getRpermissions());

        }

    }

    @Override
    public void delete(Serializable id) {
        try {
            roleMapper.deletePermissions((Long)id);
            roleMapper.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<Permission> getPermissionByRoleId(Long id) {
        return roleMapper.selectPermissionByRoleId(id);
    }
}
