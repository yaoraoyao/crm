package cn.it.crm.web.controller;

import cn.it.crm.domain.Contract;
import cn.it.crm.query.ContractQuery;
import cn.it.crm.service.IContractService;
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

@Controller
@RequestMapping("/contract")
public class ContractController {
    @Autowired
    private IContractService service;
    @Autowired
    private IOrderService orderService;

    @RequestMapping("/index")
    public String index(){
        return "contract/index";
    }
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody Contract contract){
        //自动生成合同编号
        contract.setSn(ContractSn.getSn());
        try {
            service.save(contract);
            //合同生成成功删除原有的押金信息
            orderService.delete(contract.getId());
            return AjaxResult.Me().setSuccess(true).setMsg("合同生成成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("添加合同失败");
        }
    }
    @RequestMapping("/page")
    @ResponseBody
    public PageList<Contract> page(ContractQuery query){
        //更具当前登录的用户获取住户id
        query.setTenantId(ShiroUtil.getEmployee().getTenant_id());
       return service.findByPage(query);
    }
}
