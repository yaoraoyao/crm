package cn.it.crm.web.controller;

import cn.it.crm.domain.Customer;
import cn.it.crm.domain.CustomerDevPlan;
import cn.it.crm.domain.Employee;
import cn.it.crm.query.CustomerDevPlanQuery;
import cn.it.crm.query.CustomerQuery;
import cn.it.crm.service.ICustomerDevPlanService;
import cn.it.crm.service.ICustomerService;
import cn.it.crm.service.ITenantService;
import cn.it.crm.service.shiro.ShiroUtil;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/customerDevPlan")
public class CustomerDevPlanController {
    @Autowired
    private ICustomerDevPlanService customerDevPlanService;
    @Autowired
    private ITenantService iTenantService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("customerDevPlan");
        return modelAndView;
    }

    @RequestMapping("/findAll")
    public List<CustomerDevPlan> findAll(){
        return customerDevPlanService.findAll();
    }

    @RequestMapping("/findOne")
    public CustomerDevPlan findOne(Long id){
        return customerDevPlanService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<CustomerDevPlan> findByPage(@RequestBody CustomerDevPlanQuery customerDevPlanQuery){
        Employee employee = ShiroUtil.getEmployee();
        customerDevPlanQuery.setTenantId(employee.getTenant_id());
        return customerDevPlanService.findByPage(customerDevPlanQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            customerDevPlanService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败:"+e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody CustomerDevPlan customerDevPlan){
        Employee employee = ShiroUtil.getEmployee();
        customerDevPlan.setTenant(iTenantService.findOne(employee.getTenant_id()));
        try {
            if(customerDevPlan.getId()!=null){
                customerDevPlanService.update(customerDevPlan);
            }else{
                customerDevPlan.setInputUser(employee);
                customerDevPlanService.save(customerDevPlan);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败："+e.getMessage());
        }
    }
}
