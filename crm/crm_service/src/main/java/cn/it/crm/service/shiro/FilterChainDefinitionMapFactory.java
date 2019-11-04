package cn.it.crm.service.shiro;

import cn.it.crm.domain.Permission;
import cn.it.crm.mapper.PermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class FilterChainDefinitionMapFactory {
    /**
     *
     */
    @Autowired
    private PermissionMapper permissionMapper;

    public Map<String, String> build() {
        Map<String, String> map = new LinkedHashMap<>();
        map.put("/favicon.ico", "anon");
        map.put("/login", "anon");
        map.put("/logout", "anon");
        map.put("/register", "anon");
        map.put("/userSole", "anon");
        map.put("/setMeal/findStatus", "anon");
        map.put("/wechart", "anon");
        map.put("/wechart2/callback", "anon");
        map.put("/**/wechart.jsp", "anon");
        map.put("/main/binding.jsp", "anon");
        map.put("/binding", "anon");
        map.put("/**/*.png", "anon");
        map.put("/**/*.jpg", "anon");
        map.put("/**/*.gif", "anon");
        map.put("/**/*.css", "anon");
        map.put("/**/*.js", "anon");
        map.put("/static/*", "anon");
        map.put("/exclusive/*", "anon");

        List<Permission> permissions = permissionMapper.findAll();

        // 以下配置是哪些资源需要权限认证
        for (Permission permission : permissions) {
            if (permission.getSn() != null) {
                map.put(permission.getUrl(), "crmPerms[" + permission.getSn() + "]");
            }
        }

        //everything else requires authentication:
        map.put("/**", "authc");

        return map;
    }

}
