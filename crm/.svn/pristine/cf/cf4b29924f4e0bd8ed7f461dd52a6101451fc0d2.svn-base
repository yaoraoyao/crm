package cn.it.crm.web.controller;

import cn.it.crm.domain.Menu;
import cn.it.crm.service.IMenuService;
import cn.it.crm.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private IMenuService menuService;

    @RequestMapping("/list")
    public AjaxResult listAll(){
        try {
            List<Menu> menus = menuService.findAll();
            return AjaxResult.Me().setSuccess(true).setMsg("成功").setResult(menus);
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("加载失败");
        }
    }

}
