package cn.it.crm.web.controller;

import cn.it.crm.domain.Customer;
import cn.it.crm.domain.CustomerTransfer;
import cn.it.crm.domain.Employee;
import cn.it.crm.query.CustomerQuery;
import cn.it.crm.query.CustomerTransferQuery;
import cn.it.crm.service.ICustomerService;
import cn.it.crm.service.ICustomerTransferService;
import cn.it.crm.service.ITenantService;
import cn.it.crm.service.shiro.ShiroUtil;
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
@RequestMapping("/customerTransfer")
public class CustomerTransferController {
    @Autowired
    private ICustomerTransferService customerTransferService;
    @Autowired
    private ITenantService iTenantService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("customerTransfer");
        return modelAndView;
    }

    @RequestMapping("/page")
    public PageList<CustomerTransfer> findByPage(@RequestBody CustomerTransferQuery customerTransferQuery){
        Employee employee = ShiroUtil.getEmployee();
        customerTransferQuery.setTenantId(employee.getTenant_id());
        return customerTransferService.findByPage(customerTransferQuery);
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody CustomerTransfer customerTransfer){
        Employee employee = ShiroUtil.getEmployee();
        customerTransfer.setTenant(iTenantService.findOne(employee.getTenant_id()));
        try {
            if(customerTransfer.getId()!=null){
                customerTransferService.update(customerTransfer);
            }else{
                customerTransfer.setTransUser(employee);
                customerTransferService.save(customerTransfer);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败："+e.getMessage());
        }
    }
}
