package cn.it.crm.web.controller;

import cn.it.crm.domain.AfterSale;
import cn.it.crm.query.AfterSaleQuery;
import cn.it.crm.service.IAfterSalaService;
import cn.it.crm.service.shiro.ShiroUtil;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/aftersale")
public class AfterSaleController {
    @Autowired
    private IAfterSalaService service;
    @RequestMapping("/index")
    public  String index(){
        return "aftersale/index";
    }
    @RequestMapping("/page")
    @ResponseBody
    public PageList<AfterSale> page(AfterSaleQuery query){
        /*设置租户信息*/
        query.setTenantId(ShiroUtil.getEmployee().getTenant_id());
        System.out.println(query);
        return service.findByPage(query);
    }
}
