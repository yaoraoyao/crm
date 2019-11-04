package cn.it.crm.mapper;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.domain.RepairItem;

public interface RepairItemMapper extends IBaseMapper<RepairItem> {

    void saves(RepairItem[] params);
}
