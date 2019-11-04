package cn.it.crm.mapper;


import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.AfterSaleItem;

import java.util.List;

public interface AfterSaleItemMapper extends IBaseMapper<AfterSaleItem> {

     List<AfterSaleItem> findAllBySn(String sn);

     void updata(AfterSaleItem item);

     void save(AfterSaleItem item);
}
