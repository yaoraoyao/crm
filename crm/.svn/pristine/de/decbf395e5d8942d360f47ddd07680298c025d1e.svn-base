package cn.it.crm.web.controller;

import cn.it.crm.domain.ContractItem;
import cn.it.crm.service.IContractItemService;
import cn.it.crm.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/contractitem")
public class ContractItemController {
    @Autowired
    private IContractItemService service;
    @RequestMapping("/findbycid")
    @ResponseBody
    public List<ContractItem> findByCId(String id){
        return service.findListByCId(id);
    }
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody ContractItem item){
        item.setScale(item.getScale()/100);
        try {
            service.save(item);
            return AjaxResult.Me().setSuccess(true).setMsg("明细添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("明细添加失败");
        }

    }
    @RequestMapping("/update")
    @ResponseBody
    public AjaxResult update(Long id){
        System.out.println(id);
        ContractItem contractItem = new ContractItem();
        contractItem.setId(id);
        try {
            service.updat(contractItem);
            return AjaxResult.Me().setSuccess(true).setMsg("收款成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("系统繁忙");
        }
    }
}
