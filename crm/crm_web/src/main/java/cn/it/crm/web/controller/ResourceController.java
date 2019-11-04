package cn.it.crm.web.controller;

import cn.it.crm.domain.Resource;
import cn.it.crm.query.ResourceQuery;
import cn.it.crm.service.IResourceService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/resource")
public class ResourceController {
    @Autowired
    private IResourceService resourceService;

    @RequestMapping("/index")
    public String index(){
        return "resource";
    }
    @RequestMapping("/page")
    @ResponseBody
    public PageList<Resource> findAll(ResourceQuery query){
        System.out.println(query);
        return resourceService.findByPage(query);
    }

    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody Resource resource){
        System.out.println(resource);
        try {
            if(resource.getId()!=null){
                resourceService.update(resource);
                return AjaxResult.Me().setSuccess(true).setMsg("修改成功");
            }else {
                resourceService.save(resource);
                return AjaxResult.Me().setSuccess(true).setMsg("保存成功");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败"+e.getMessage());
        }
    }
    @RequestMapping("/delete")
    @ResponseBody
    public AjaxResult delete(Long id){
        try {
            resourceService.delete(id);
            return AjaxResult.Me().setSuccess(true).setMsg("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("删除失败"+e.getMessage());
        }
    }

}
