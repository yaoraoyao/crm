package cn.it.crm.web.controller;


import cn.it.crm.domain.Tenant;
import cn.it.crm.query.TenantQuery;
import cn.it.crm.service.ITenantService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/tenant")
public class TenantController {
    @Autowired
    private ITenantService tenantService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("tenant");
        return modelAndView;
    }

    @RequestMapping("/baidumap")
    public ModelAndView baiduMap(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("baidumap");
        return modelAndView;
    }


    @RequestMapping("/findAll")
    public List<Tenant> findAll(){
        return tenantService.findAll();
    }

    @RequestMapping("/findOne")
    public Tenant findOne(Long id){
        return tenantService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<Tenant> findByPage(@RequestBody TenantQuery tenantQuery){
        return tenantService.findByPage(tenantQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            tenantService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败:"+e.getMessage());
        }
    }
    @RequestMapping("/query")
    public List<Tenant> query(@RequestBody TenantQuery tenantQuery){
        return tenantService.findAll();
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody Tenant tenant){
        try {
            if(tenant.getId()!=null){
                tenantService.update(tenant);
            }else{
                tenant.setRegisterTime(new Date());
                tenantService.save(tenant);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败："+e.getMessage());
        }
    }
    @RequestMapping("/upload")
    public String  upload(@RequestParam("picture") MultipartFile picture, HttpServletRequest request) {

        //获取文件在服务器的储存位置
        System.out.println(request.getContextPath());
        String path = request.getServletContext().getRealPath("/exclusive/images/");
        File filePath = new File(path);
        System.out.println("文件的保存路径：" + path);
        if (!filePath.exists() && !filePath.isDirectory()) {
            System.out.println("目录不存在，创建目录:" + filePath);
            filePath.mkdir();
        }

        //获取原始文件名称(包含格式)
        String originalFileName = picture.getOriginalFilename();
        System.out.println("原始文件名称：" + originalFileName);

        //获取文件类型，以最后一个`.`为标识
        String type = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
        System.out.println("文件类型：" + type);
        //获取文件名称（不包含格式）
        String name = originalFileName.substring(0, originalFileName.lastIndexOf("."));

        //设置文件新名称: 当前时间+文件名称（不包含格式）
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String date = sdf.format(d);
        String fileName = date + name + "." + type;
        System.out.println("新文件名称：" + fileName);

        //在指定路径下创建一个文件
        File targetFile = new File(path, fileName);
        //将文件保存到服务器指定位置
        try {
            picture.transferTo(targetFile);
            System.out.println("上传成功");
            //将文件在服务器的存储路径返回
            System.out.println("/exclusive/images/" + fileName);
            return "/exclusive/images/" + fileName;
        } catch (IOException e) {
            System.out.println("上传失败");
            e.printStackTrace();
            return "上传失败:"+e.getMessage();
        }
    }

}
