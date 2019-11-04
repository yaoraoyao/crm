package cn.it.crm.service.shiro;

import cn.it.crm.domain.Employee;
import org.apache.shiro.SecurityUtils;


public class ShiroUtil {

    public static final String SESSION_KEY = "loginUser";

    public static void setEmployee(Employee employee) {
        SecurityUtils.getSubject().getSession().setAttribute(SESSION_KEY, employee);
    }

    public static Employee getEmployee() {
        return (Employee) SecurityUtils.getSubject().getSession().getAttribute(SESSION_KEY);
    }

    public static String getIp(){
        return SecurityUtils.getSubject().getSession().getHost();
    }
}
