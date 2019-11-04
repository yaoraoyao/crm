package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.RepairItem;
import cn.it.crm.mapper.RepairItemMapper;
import cn.it.crm.service.IRepairItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RepairItemServiceImpl extends BaseServiceImpl<RepairItem> implements IRepairItemService {

    @Autowired
    private RepairItemMapper repairItemMapper;

    @Override
    protected IBaseMapper<RepairItem> getMapper() {
        return repairItemMapper;
    }

    @Override
    public void saves(RepairItem[] params) {
        repairItemMapper.saves(params);
    }
}
