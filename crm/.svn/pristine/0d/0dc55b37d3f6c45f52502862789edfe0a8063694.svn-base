package cn.it.crm.web.controller;

import cn.it.crm.domain.ContractItem;
import cn.it.crm.domain.RepairItem;
import cn.it.crm.query.RepairItemQuery;
import cn.it.crm.service.IRepairItemService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/repairItem")
public class RepairItemController {

    @Autowired
    private IRepairItemService repairItemService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("repairItem");
        return modelAndView;
    }

    @RequestMapping("/findAll")
    public List<RepairItem> findAll(){
        return repairItemService.findAll();
    }

    @RequestMapping("/findOne")
    public RepairItem findOne(Long id){
        return repairItemService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<RepairItem> findByPage(@RequestBody RepairItemQuery repairItemQuery){
        return repairItemService.findByPage(repairItemQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            repairItemService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败"+ e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(RepairItem repairItem){
        try {
            if (repairItem.getId() != null){
                repairItemService.update(repairItem);
            }else{
                repairItemService.save(repairItem);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败"+ e.getMessage());
        }
    }

    @RequestMapping("/saves")
    public AjaxResult saves(@RequestBody RepairItem[] params){
        try {
            repairItemService.saves(params);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败" + e.getMessage());
        }
    }
}
