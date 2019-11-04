package cn.it.crm.web.controller;

import cn.it.crm.domain.Employee;
import cn.it.crm.domain.Tenant;
import cn.it.crm.service.IEmployeeService;
import cn.it.crm.service.ITenantService;
import cn.it.crm.service.shiro.EncryptPassword;
import cn.it.crm.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
public class MainController {
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private ITenantService tenantService;

    @RequestMapping("/main")
    public String toMainPage(){
        return "main/main";
    }

    @RequestMapping( value = "/register", method = RequestMethod.GET)
    public String toRegisterPage(){
        return "/main/myregister";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult register(@RequestBody Tenant tenant){
        AjaxResult ajaxResult = userSole(tenant.getCompanyName());
        if(!ajaxResult.getSuccess()){
            return AjaxResult.Me().setSuccess(false)
                    .setMsg("注册失败").setMsg("用户名存在");
        }
        tenant.setRegisterTime(new Date());
        try {
            tenantService.save(tenant);
            Employee employee = new Employee();
            employee.setUsername(tenant.getSysName());
            employee.setRealname(tenant.getSysName());
            employee.setPassword(EncryptPassword.encrypt(tenant.getPassword()));
            employee.setTel(tenant.getCompanyTel());
            employee.setInputTime(new Date());
            employee.setEmail(tenant.getEmail());
            employee.setState(1);
            employee.setTenant_id(tenant.getId());
            employeeService.save(employee);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false)
                    .setMsg("注册失败:"+e.getMessage());
        }
    }

    /*用户名唯一性查询*/
    @RequestMapping("/userSole")
    @ResponseBody
    public AjaxResult userSole( String username){
        Employee employee = new Employee();
        employee.setUsername(username);
        Employee byUsernames = employeeService.findByUsernames(employee.getUsername());

        if(byUsernames==null){
         return    AjaxResult.Me().setSuccess(true);
        }
        return AjaxResult.Me().setSuccess(false);
    }
}
