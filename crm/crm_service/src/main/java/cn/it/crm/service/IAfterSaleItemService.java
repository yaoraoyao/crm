package cn.it.crm.service;


import cn.it.crm.domain.AfterSaleItem;

import java.util.List;

public interface IAfterSaleItemService {

    List<AfterSaleItem> findAllBySn(String sn);

    void updata(AfterSaleItem item);

    void save(AfterSaleItem item);

}
