package cn.it.crm.web.controller;

import cn.it.crm.domain.CustomerTraceHistory;
import cn.it.crm.domain.Employee;
import cn.it.crm.query.CustomerTraceHistoryQuery;
import cn.it.crm.service.ICustomerTraceHistoryService;
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
@RequestMapping("/customerTraceHistory")
public class CustomerTraceHistoryController {
    @Autowired
    private ICustomerTraceHistoryService customerTraceHistoryService;

    @Autowired
    private ITenantService iTenantService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("customerTraceHistory");
        return modelAndView;
    }

    @RequestMapping("/findAll")
    public List<CustomerTraceHistory> findAll(){
        return customerTraceHistoryService.findAll();
    }

    @RequestMapping("/findOne")
    public CustomerTraceHistory findOne(Long id){
        return customerTraceHistoryService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<CustomerTraceHistory> findByPage(@RequestBody CustomerTraceHistoryQuery CustomerQuery){
        Employee employee = ShiroUtil.getEmployee();
        CustomerQuery.setTenantId(employee.getTenant_id());
        return customerTraceHistoryService.findByPage(CustomerQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            customerTraceHistoryService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败:"+e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody CustomerTraceHistory customerTraceHistory){
        Employee employee = ShiroUtil.getEmployee();
        customerTraceHistory.setTenant(iTenantService.findOne(employee.getTenant_id()));
        try {
            if(customerTraceHistory.getId()!=null){
                customerTraceHistoryService.update(customerTraceHistory);
            }else{
                customerTraceHistoryService.save(customerTraceHistory);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败："+e.getMessage());
        }
    }
}
