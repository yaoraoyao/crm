package cn.it.crm.web.controller;

import cn.it.crm.domain.Repair;
import cn.it.crm.query.RepairQuery;
import cn.it.crm.service.IRepairService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.NumberUtil;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/repair")
public class RepairController {

    @Autowired
    private IRepairService repairService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("repair");
        return modelAndView;
    }

    @RequestMapping("/findAll")
    public List<Repair> findAll(){
        return repairService.findAll();
    }

    @RequestMapping("/findOne")
    public Repair findOne(Long id){
        return repairService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<Repair> findByPage(@RequestBody RepairQuery repairQuery){
        return repairService.findByPage(repairQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            repairService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败" + e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody Repair repair){
        try {
            if (repair.getId() != null){
                repairService.update(repair);
            }else{
                String num = NumberUtil.getRepair();
                repair.setSn(num);
                repairService.save(repair);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败" + e.getMessage());
        }
    }
}
