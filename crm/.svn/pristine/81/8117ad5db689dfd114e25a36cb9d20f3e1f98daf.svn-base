package cn.it.crm.web.controller;


import cn.it.crm.domain.Department;
import cn.it.crm.query.DepartmentQuery;
import cn.it.crm.service.IDepartmentService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/department")
public class DepartmentController {
    @Autowired
    private IDepartmentService departmentService;


    @RequestMapping("/index")
    public String index(){
        return "department";
    }


    @RequestMapping("/findByPage")
    @ResponseBody
    public PageList<Department> list(DepartmentQuery query){
        return departmentService.findByPage(query);

    }



    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(@RequestBody Department department){
//            employee.setInputTime(new Date());
        try {
            Long id = department.getId();
            if(id != null){
                departmentService.update(department);
            }else{
                departmentService.save(department);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败！"+e.getMessage());
        }
    }

    @RequestMapping("/delete")
    @ResponseBody
    public AjaxResult delete(Long id){
        try {
            departmentService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e){
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败！"+e.getMessage());
        }
    }
}
