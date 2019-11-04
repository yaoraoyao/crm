package cn.it.crm.mapper;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.Employee;
import cn.it.crm.domain.Menu;
import cn.it.crm.domain.Permission;

import java.util.List;


public interface PermissionMapper extends IBaseMapper<Permission> {
    //根据权限id删除权限和角色中间表关联
    void deletePermissions(Long id);

    /**
     * 根据员工id获取对应角色相应的权限集合
     * @param id
     * @return
     */
    List<Permission> findPermissionByEmpId(Long id);

    Employee selectOneByUserName(String username);

    /**
     * 获取所有父级菜单
     */
    List<Menu> selectParentMenu();

}
