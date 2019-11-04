package cn.it.crm.service.shiro;


import cn.it.crm.domain.Employee;
import cn.it.crm.domain.Permission;
import cn.it.crm.mapper.EmployeeMapper;
import cn.it.crm.mapper.PermissionMapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.List;


public class CRMRealm extends AuthorizingRealm {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public String getName() {
        return "crmRealm";
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
        String username = usernamePasswordToken.getUsername();
        Employee employee = employeeMapper.findByUsernames(username);
        if(employee != null){
            String password = employee.getPassword();
            ByteSource salt = ByteSource.Util.bytes("cn.it.crm");
            return new SimpleAuthenticationInfo(employee,password,salt,getName());
        }
        return null;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Employee employee = (Employee) principals.getPrimaryPrincipal();

        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        List<Permission> permissions = permissionMapper.findPermissionByEmpId(employee.getId());
        HashSet<String> set = new HashSet<>();
        for (Permission permission : permissions) {
            set.add(permission.getSn());
        }
        authorizationInfo.setStringPermissions(set);

        return authorizationInfo;
    }
}
