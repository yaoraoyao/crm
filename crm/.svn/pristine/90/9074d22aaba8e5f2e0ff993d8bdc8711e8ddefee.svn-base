package cn.it.crm.web.controller;

import cn.it.crm.domain.Menu;
import cn.it.crm.domain.Permission;
import cn.it.crm.query.PermissionQuery;
import cn.it.crm.service.IMenuService;
import cn.it.crm.service.IPermissionService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/permission")
public class PermissionController {
    @Autowired
    private IPermissionService permissionService;

    @Autowired
    private IMenuService menuService;

    @RequestMapping("/index")
    public String index(){
        return "permission";
    }

    @RequestMapping("/list")
    @ResponseBody
    public List<Permission> findAll(){
        return  permissionService.findAll();
    }

    @RequestMapping("/page")
    @ResponseBody
    public PageList<Permission> findByPage(PermissionQuery query){ return permissionService.findByPage(query); }

    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody Permission permission){
        try {
            if(permission.getId()!=null){
                menuService.update(permission.getMenu());
                permissionService.update(permission);
                return AjaxResult.Me().setSuccess(true).setMsg("修改成功");
            }else {
                menuService.save(permission.getMenu());
                permissionService.save(permission);
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
            permissionService.delete(id);
            return AjaxResult.Me().setSuccess(true).setMsg("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("删除失败"+e.getMessage());
        }
    }

    @RequestMapping("/parentMenu")
    @ResponseBody
    public List<Menu> selectParentMenu(){
        return  permissionService.selectParentMenu();
    }

}
