package cn.it.crm.mapper;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.Permission;
import cn.it.crm.domain.Role;

import java.util.List;


public interface RoleMapper extends IBaseMapper<Role> {
    /**
     * 根据角色id获取权限
     * @param id
     * @return
     */
    List<Permission> selectPermissionByRoleId(Long id);

    void savePerssions(List<Permission> permissions);

    void deletePermissions(Long roleId);
}
