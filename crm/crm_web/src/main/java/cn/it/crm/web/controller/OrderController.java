package cn.it.crm.web.controller;

import cn.it.crm.domain.Customer;
import cn.it.crm.domain.Order;
import cn.it.crm.domain.Tenant;
import cn.it.crm.query.OrderQuery;
import cn.it.crm.service.IOrderService;
import cn.it.crm.service.shiro.ShiroUtil;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.ContractSn;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private IOrderService orderService;

    @RequestMapping("/index")
    public String index(){
        return "order/index";
    }

    @RequestMapping("/list")
    @ResponseBody
    public List<Order> findAll(){
     return   orderService.findAll();
    }

    @RequestMapping("/page")
    @ResponseBody
    public PageList<Order> page(OrderQuery query){
        query.setTenantId(ShiroUtil.getEmployee().getTenant_id());//从seession中获取租户
        return   orderService.findByPage(query);
    }
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody Order order){
            //设置定金单号
            order.setSn(ContractSn.getSn());
            order.setTenantId(ShiroUtil.getEmployee().getTenant_id());//从seession中获取租户
            order.setSellerId(ShiroUtil.getEmployee().getId());//从session中获取
            String msg="";
            String start="成功";
            try {
                start="成功";
                if(order.getId()==null) {
                    msg="添加";
                    orderService.save(order);
                }else {
                    msg="修改";
                    orderService.update(order);
                }
                AjaxResult result = AjaxResult.Me().setSuccess(true).setMsg(msg+start);
                return result;
            } catch (Exception e) {
                start="失败";
                e.printStackTrace();
            }
            AjaxResult result = AjaxResult.Me().setSuccess(false).setMsg(msg+start);
            return result;

    }
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxResult delete(Long id) {
        try {
            orderService.delete(id);
            AjaxResult result = AjaxResult.Me().setSuccess(true).setMsg("删除成功");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        AjaxResult result = AjaxResult.Me().setSuccess(false).setMsg("删除失败");
        return result;
    }
    @RequestMapping("/findOne")
    @ResponseBody
    public Order findOne(Long id){
      return   orderService.findOne(id);
    }

    /*根据客户的电话和姓名进行精确查找并返回*/
    @RequestMapping("/findCustomerByTelOrName")
    @ResponseBody
    public List<Customer> findCustomerByTelOrName(Customer customer){
        /*设置客户的租户id，*/
        Tenant tenant = new Tenant();
        tenant.setId(ShiroUtil.getEmployee().getTenant_id());
        customer.setTenant(tenant);
        return orderService.findCustomerByTelOrName(customer);
    }

}
