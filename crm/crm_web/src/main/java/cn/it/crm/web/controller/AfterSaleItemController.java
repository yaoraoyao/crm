package cn.it.crm.web.controller;

import cn.it.crm.domain.AfterSaleItem;
import cn.it.crm.service.IAfterSaleItemService;
import cn.it.crm.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/aftersaleitem")
public class AfterSaleItemController {
    @Autowired
    private IAfterSaleItemService service;
    @RequestMapping("/findAllBySn")
    @ResponseBody
    public List<AfterSaleItem> findAllBySn(String sn){
        return service.findAllBySn(sn);
    }

    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody AfterSaleItem item){
        if(item.getId()==null) {
            try {
                service.save(item);
                return AjaxResult.Me().setMsg("操作成功").setSuccess(true);
            } catch (Exception e) {
                e.printStackTrace();
                return AjaxResult.Me().setMsg("操作失败").setSuccess(false).setResult(e);
            }
        }else {
            service.updata(item);
            return  AjaxResult.Me().setMsg("解决成功");
        }
    }


}
