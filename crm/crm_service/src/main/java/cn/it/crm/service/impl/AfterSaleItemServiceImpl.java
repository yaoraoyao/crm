package cn.it.crm.service.impl;

import cn.it.crm.domain.AfterSaleItem;
import cn.it.crm.mapper.AfterSaleItemMapper;
import cn.it.crm.service.IAfterSaleItemService;
import cn.it.crm.util.Execute;
import cn.it.crm.util.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AfterSaleItemServiceImpl implements IAfterSaleItemService {

    @Autowired
    private AfterSaleItemMapper mapper;
    @Override
    public List<AfterSaleItem> findAllBySn(String sn) {
        return mapper.findAllBySn(sn);
    }

    @Override
    @Operation(execute= Execute.UPDATE)
    public void updata(AfterSaleItem item) {
        mapper.updata(item);

    }

    @Override
    @Operation(execute=Execute.SAVE)
    public void save(AfterSaleItem item) {
        mapper.save(item);
    }
}
