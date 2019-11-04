package cn.itsource.ssm.web.controller;


import cn.itsource.ssm.domain.Department;
import cn.itsource.ssm.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private IDepartmentService departmentService;


    @RequestMapping("/index")
    public String index(){

        return "department/index";
    }

    @RequestMapping("/getAll")
    @ResponseBody
    public List<Department> getAll(){

        return departmentService.getAll();
    }
}
