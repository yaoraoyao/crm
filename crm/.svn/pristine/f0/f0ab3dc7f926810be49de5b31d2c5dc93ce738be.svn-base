package cn.it.crm.web.controller;

import cn.it.crm.domain.SystemDictionaryItem;
import cn.it.crm.query.SystemDictionaryItemQuery;
import cn.it.crm.service.ISystemDictionaryItemService;
import cn.it.crm.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController {
    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    @RequestMapping("/index")
    public String toPage(){
        return "systemDictionaryItem";
    }
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public AjaxResult list(@RequestBody SystemDictionaryItemQuery query){
        AjaxResult result = AjaxResult.Me();
        try {
            query.setTenantId(4L);
            //todo 后期根据登陆用户获取
            return result.setResult(systemDictionaryItemService.findByPage(query));
        } catch (Exception e) {
            e.printStackTrace();
            return result.setSuccess(false).setMsg("查询失败" + e.getMessage());
        }
    }

    @RequestMapping(value = "/listNoPage",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult listNoPage(@RequestBody SystemDictionaryItemQuery query){
        AjaxResult result = AjaxResult.Me();
        try {
//            query.setTenantId(1L);
//            //todo 后期根据登陆用户获取
//            query.setPageNum(1);
            return result.setResult(systemDictionaryItemService.findByPage(query).getRows());
        } catch (Exception e) {
            e.printStackTrace();
            return result.setSuccess(false).setMsg("查询失败" + e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public AjaxResult save(@RequestBody SystemDictionaryItem systemDictionaryItem){
        AjaxResult result = AjaxResult.Me();
        try {
            if(systemDictionaryItem.getId() == null){
//                // todo 根据登陆对象获取租户id
                systemDictionaryItem.setTenantId(4L);
                systemDictionaryItemService.save(systemDictionaryItem);
            }else {
                systemDictionaryItemService.update(systemDictionaryItem);
            }
            return result;
        } catch (Exception e){
            e.printStackTrace();
            return result.setSuccess(false).setMsg("操作失败" + e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxResult delete(Long id){
        AjaxResult result = AjaxResult.Me();
        try {
            systemDictionaryItemService.delete(id);
            return result;
        } catch (Exception e){
            e.printStackTrace();
            return result.setSuccess(false).setMsg("删除失败" + e.getMessage());
        }
    }
}
