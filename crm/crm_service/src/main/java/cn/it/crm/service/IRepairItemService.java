package cn.it.crm.service;

import cn.it.crm.core.service.IBaseService;
import cn.it.crm.domain.RepairItem;

public interface IRepairItemService extends IBaseService<RepairItem> {

    void saves(RepairItem[] params);
}
