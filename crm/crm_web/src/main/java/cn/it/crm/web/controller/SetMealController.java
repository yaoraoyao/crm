package cn.it.crm.web.controller;

import cn.it.crm.domain.SetMeal;
import cn.it.crm.query.SetMealQuery;
import cn.it.crm.service.ISetMealService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/setMeal")
public class SetMealController {
    @Autowired
    private ISetMealService setMealService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("setMeal");
        return modelAndView;
    }

    @RequestMapping("/findAll")
    public List<SetMeal> findAll(){
        return setMealService.findAll();
    }

    @RequestMapping("/findOne")
    public SetMeal findOne(Long id){
        return setMealService.findOne(id);
    }


    @RequestMapping("/findStatus")
    public List<SetMeal> findStatus(Integer id){
        System.out.println(id);
        return setMealService.findStatus(id);
    }

    @RequestMapping("/findByPage")
    public PageList<SetMeal> findByPage(@RequestBody SetMealQuery setMealQuery){
        return setMealService.findByPage(setMealQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            setMealService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败:"+e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody SetMeal setMeal){
        try {
            if(setMeal.getId()!=null){
                setMealService.update(setMeal);
            }else{
                setMealService.save(setMeal);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败："+e.getMessage());
        }
    }
}
