package cn.it.crm.web.controller;

import cn.it.crm.domain.SystemLog;
import cn.it.crm.query.SystemLogQuery;
import cn.it.crm.service.ISystemLogService;
import cn.it.crm.service.shiro.ShiroUtil;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/systemLog")
public class SystemLogController {
    @Autowired
    private ISystemLogService systemLogService;

    @RequestMapping(value = "/list")
    @ResponseBody
    public AjaxResult listAll(@RequestBody SystemLogQuery query){
        query.setTenantId(ShiroUtil.getEmployee().getTenant_id());
        try {
            PageList<SystemLog> page = systemLogService.findBySystemLogQuery(query);
            return AjaxResult.Me().setResult(page);
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("加载失败");
        }
    }

    @RequestMapping(value = "/index")
    public String toPage(){
        return "systemLog";
    }
}
