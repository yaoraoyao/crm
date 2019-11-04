package cn.it.crm.service;

import cn.it.crm.core.service.IBaseService;
import cn.it.crm.domain.Employee;
import cn.it.crm.domain.Menu;
import cn.it.crm.domain.Permission;

import java.util.List;
import java.util.Set;

public interface IPermissionService extends IBaseService<Permission> {

    Set<String> findPermissionByEmpId(Long id);

    Employee selectOneByUserName(String username);

    /**
     * 获取所有父级菜单
     */
    List<Menu> selectParentMenu();
}
