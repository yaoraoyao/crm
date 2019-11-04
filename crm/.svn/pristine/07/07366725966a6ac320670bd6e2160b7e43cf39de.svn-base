package cn.it.crm.web.controller;

import cn.afterturn.easypoi.entity.vo.NormalExcelConstants;
import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import cn.afterturn.easypoi.excel.entity.result.ExcelImportResult;
import cn.it.crm.domain.Customer;
import cn.it.crm.domain.Employee;
import cn.it.crm.domain.Tenant;
import cn.it.crm.query.CustomerQuery;
import cn.it.crm.service.ICustomerService;
import cn.it.crm.service.ITenantService;
import cn.it.crm.service.shiro.ShiroUtil;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private ITenantService iTenantService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("customer");
        return modelAndView;
    }

    @RequestMapping("/list")
    public List<Customer> list(@RequestBody CustomerQuery customerQuery){
        Employee employee = ShiroUtil.getEmployee();
        customerQuery.setTenantId(employee.getTenant_id());
        return customerService.findAllQuery(customerQuery);
    }

    @RequestMapping("/findAll")
    public List<Customer> findAll(){
        return customerService.findAll();
    }

    @RequestMapping("/findOne")
    public Customer findOne(Long id){
        return customerService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<Customer> findByPage(@RequestBody CustomerQuery customerQuery){
        Employee employee = ShiroUtil.getEmployee();
        customerQuery.setTenantId(employee.getTenant_id());
        return customerService.findByPage(customerQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            customerService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败:"+e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody Customer customer){
        Employee employee = ShiroUtil.getEmployee();
        customer.setTenant(iTenantService.findOne(employee.getTenant_id()));
        try {
            if(customer.getId()!=null){
                customerService.update(customer);
            }else{
                customer.setInputUser(employee);
                customerService.save(customer);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败: "+e.getMessage());
        }
    }

    @RequestMapping("/updateSeller")
    public AjaxResult updateSeller(@RequestBody CustomerQuery customerQuery){
        try {
            System.out.println(customerQuery.toString());
            customerService.updateSeller(customerQuery);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败: "+e.getMessage());
        }
    }

    /**
     * 导出数据
     */
    @RequestMapping("/export")
    public String export(ModelMap map, CustomerQuery query){
        Employee employee = ShiroUtil.getEmployee();
        query.setTenantId(employee.getTenant_id());
        List<Customer> list = customerService.findAllQuery(query);
        //设置一些属性
        ExportParams params = new ExportParams("客户信息管理", "客户数据", ExcelType.XSSF);
        params.setFreezeCol(0);
        map.put(NormalExcelConstants.DATA_LIST, list); // 数据集合
        map.put(NormalExcelConstants.CLASS, Customer.class);//导出实体
        map.put(NormalExcelConstants.PARAMS, params);//参数
        map.put(NormalExcelConstants.FILE_NAME, "客户信息");//文件名称
        return NormalExcelConstants.EASYPOI_EXCEL_VIEW;//View名称
    }

    @RequestMapping("/customerImport")
    public void customerImport(MultipartFile file, HttpServletResponse resp, Model model) throws Exception {
        if (!file.isEmpty()) {
            //准备导入的参数
            ImportParams params = new ImportParams();
            params.setTitleRows(1);
            params.setNeedVerfiy(true); //需要验证
            //加入自定义验证
            ExcelImportResult<Customer> result = ExcelImportUtil.importExcelMore(file.getInputStream(), Customer.class, params);
            //获取验证成功的数据
            List<Customer> list = result.getList();
            for (Customer customer : list) {
                Employee employee = ShiroUtil.getEmployee();
                customer.setInputUser(employee);
                Tenant tenant = new Tenant();
                tenant.setId(employee.getTenant_id());
                customer.setTenant(tenant);
                customer.setInputTime(new Date());
            }
            for (Customer customer : list) {
                customerService.save(customer);
            }
            //如果验证失败，代码到这里面来
            if (result.isVerfiyFail()) {
                //失败的文件
                Workbook failWorkbook = result.getFailWorkbook();
                //把这个文件导出
                String filename = new String("上传失败的数据信息".getBytes("UTF-8"), "ISO-8859-1");
                resp.setCharacterEncoding("ISO-8859-1");
                resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"); //mime类型
                resp.setHeader("Content-disposition", "attachment;filename=" + filename + ".xlsx");
                resp.setHeader("Pragma", "No-cache");//设置不要缓存
                failWorkbook.write(resp.getOutputStream());
            }
        } else {
            model.addAttribute("err", "请选择一个Excel文件！");
        }
    }
}
