package cn.it.crm.web.controller;

import cn.it.crm.domain.SystemDictionary;
import cn.it.crm.query.SystemDictionaryQuery;
import cn.it.crm.service.ISystemDictionaryService;
import cn.it.crm.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/systemDictionary")
public class SystemDictionaryController {
    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequestMapping("/index")
    public String toPage(){
        return "systemdictionary";
    }
    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public AjaxResult list(@RequestBody SystemDictionaryQuery query){
        AjaxResult result = AjaxResult.Me();
        try {
            return result.setResult(systemDictionaryService.findByPage(query));
        } catch (Exception e) {
            e.printStackTrace();
            return result.setSuccess(false).setMsg("查询失败" + e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/findAll",method = RequestMethod.POST)
    public AjaxResult findAll(){
        AjaxResult result = AjaxResult.Me();
        try {
            //todo 改id
            return result.setResult(systemDictionaryService.findAllByTenantId(4L));
        } catch (Exception e) {
            e.printStackTrace();
            return result.setSuccess(false).setMsg("查询失败" + e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public AjaxResult save(@RequestBody SystemDictionary systemDictionary){
        AjaxResult result = AjaxResult.Me();
        try {
            if(systemDictionary.getId() == null){
                // todo 根据登陆用户获取
                systemDictionary.setTenantId(4L);
                systemDictionaryService.save(systemDictionary);
            }else {
                systemDictionaryService.update(systemDictionary);
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
            systemDictionaryService.delete(id);
            return result;
        } catch (Exception e){
            e.printStackTrace();
            return result.setSuccess(false).setMsg("删除失败" + e.getMessage());
        }
    }
}
