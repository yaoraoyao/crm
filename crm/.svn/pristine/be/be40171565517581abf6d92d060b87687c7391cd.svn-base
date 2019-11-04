package cn.it.crm.web.controller;

import cn.it.crm.domain.Permission;
import cn.it.crm.domain.Role;
import cn.it.crm.query.RoleQuery;
import cn.it.crm.service.IRoleService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private IRoleService roleService;

    @RequestMapping("/index")
    public String index(){
        return "role";
    }
    @RequestMapping("/page")
    @ResponseBody
    public PageList<Role> findByPage(RoleQuery query){
        return roleService.findByPage(query);
    }

    @RequestMapping("/list")
    @ResponseBody
    public List<Permission> getPermissionByRoleId(Long id){
        return roleService.getPermissionByRoleId(id);
    }

    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody Role role){
        try {
            if(role.getId()!=null){
                roleService.save(role);
                return AjaxResult.Me().setSuccess(true).setMsg("保存成功");
            }else {
                roleService.save(role);
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
        System.out.println(id);
        try {
            roleService.delete(id);
            return AjaxResult.Me().setSuccess(true).setMsg("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("删除失败"+e.getMessage());
        }
    }



}
