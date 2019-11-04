package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Repair;
import cn.it.crm.mapper.RepairMapper;
import cn.it.crm.service.IRepairService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RepairServiceImpl extends BaseServiceImpl<Repair> implements IRepairService {

    @Autowired
    private RepairMapper repairMapper;

    @Override
    protected IBaseMapper<Repair> getMapper() {
        return repairMapper;
    }
}
