package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Product;
import cn.it.crm.mapper.ProductMapper;
import cn.it.crm.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl extends BaseServiceImpl<Product> implements IProductService {

    @Autowired
    private ProductMapper productMapper;

    @Override
    protected IBaseMapper<Product> getMapper() {
        return productMapper;
    }
}
