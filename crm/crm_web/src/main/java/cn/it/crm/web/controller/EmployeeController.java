package cn.it.crm.web.controller;

import cn.it.crm.domain.Department;
import cn.it.crm.domain.Employee;
import cn.it.crm.query.EmployeeQuery;
import cn.it.crm.service.IEmployeeService;
import cn.it.crm.service.shiro.EncryptPassword;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
@RestController
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private IEmployeeService employeeService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("employee");
        return modelAndView;
    }

    @RequestMapping("/findAll")
    public List<Employee> findAll(){
        return employeeService.findAll();
    }

    @RequestMapping("/findOne")
    public Employee findOne(Long id){
        return employeeService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<Employee> findByPage(@RequestBody EmployeeQuery employeeQuery){
        return employeeService.findByPage(employeeQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            employeeService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败:"+e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody Employee employee){
        try {
            if(employee.getId()!=null){
                employeeService.update(employee);
            }else{
                Employee byUsernames = employeeService.findByUsernames(employee.getUsername());
                if(byUsernames!=null){
                    return AjaxResult.Me().setSuccess(false).setMsg("用户名已存在！");
                }else{
                    employee.setPassword(EncryptPassword.encrypt(employee.getPassword()));
                    employeeService.save(employee);
                }
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败："+e.getMessage());
        }
    }

}
