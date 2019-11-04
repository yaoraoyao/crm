package cn.it.crm.web.controller;


import cn.it.crm.domain.Employee;
import cn.it.crm.domain.Login;
import cn.it.crm.service.IEmployeeService;
import cn.it.crm.service.shiro.EncryptPassword;
import cn.it.crm.service.shiro.ShiroUtil;
import cn.it.crm.util.AjaxResult;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {
    @Autowired
    private IEmployeeService employeeService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String index() {
        return "/main/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult login(@RequestBody Login login) {
//        login.setPassword(EncryptPassword.encrypt(login.getPassword()));
        UsernamePasswordToken token =
                new UsernamePasswordToken(login.getUsername(), login.getPassword());
        Subject currentUser = SecurityUtils.getSubject();
        try {
            currentUser.login(token);
            if (currentUser.isAuthenticated()) {
                Employee employee = (Employee) currentUser.getPrincipal();
                ShiroUtil.setEmployee(employee);
                return AjaxResult.Me();
            }
        } catch (UnknownAccountException e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("登录失败-用户名不存在！");
        } catch (IncorrectCredentialsException e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("登录失败-密码错误！");
        } catch (AuthenticationException e) {
            e.printStackTrace();
        }
        return AjaxResult.Me().setSuccess(false).setMsg("系统繁忙！");
    }

    @RequestMapping("/wechart")
    public String wechart(){
        return "wechart";
    }

    @RequestMapping(value = "/binding", method = RequestMethod.GET)
    public String  binding(){

        return "/main/binding";
    }


    @RequestMapping(value = "/binding", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult  binding1(@RequestBody Login login){
        System.out.println("绑定++++++++++++++++");
        Employee employee = employeeService.findByUsernames(login.getUsername());
        System.out.println(employee);
        if(employee!=null){
            try {
                SecurityUtils.getSubject().login(new UsernamePasswordToken(employee.getUsername(),employee.getUsername()));
                boolean authenticated = SecurityUtils.getSubject().isAuthenticated();
                if(authenticated){
                    String openid = ShiroUtil.getEmployee().getOpenid();
                    employee.setOpenid(openid);
                    ShiroUtil.setEmployee(employee);
                    employeeService.update(employee);
                    System.out.println(employee);
                }
                return AjaxResult.Me().setSuccess(true);
            } catch (AuthenticationException e) {
                e.printStackTrace();
                return AjaxResult.Me().setSuccess(false).setMsg("权限验证失败");
            }
        }else {
            return AjaxResult.Me().setSuccess(false).setMsg("没有该用户");
        }

    }

    @RequestMapping("/logout")
    public String logout() {
        try {
            SecurityUtils.getSubject().logout();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/main/login";
    }
}
