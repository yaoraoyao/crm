package cn.it.crm.web.controller;

import cn.it.crm.domain.Product;
import cn.it.crm.query.ProductQuery;
import cn.it.crm.service.IProductService;
import cn.it.crm.util.AjaxResult;
import cn.it.crm.util.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private IProductService productService;

    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("product");
        return modelAndView;
    }

    @RequestMapping("/findAll")
    public List<Product> findAll(){
        return productService.findAll();
    }

    @RequestMapping("/findOne")
    public Product findOne(Long id){
        return productService.findOne(id);
    }

    @RequestMapping("/findByPage")
    public PageList<Product> findByPage(@RequestBody ProductQuery productQuery){
        return productService.findByPage(productQuery);
    }

    @RequestMapping("/delete")
    public AjaxResult delete(Long id){
        try {
            productService.delete(id);
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败:"+e.getMessage());
        }
    }

    @RequestMapping("/save")
    public AjaxResult save(@RequestBody Product product){
        try {
            if(product.getId()!=null){
                productService.update(product);
            }else{
                productService.save(product);
            }
            return AjaxResult.Me();
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.Me().setSuccess(false).setMsg("操作失败："+e.getMessage());
        }
    }
}
