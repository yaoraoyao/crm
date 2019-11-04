package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.AfterSale;
import cn.it.crm.domain.Contract;
import cn.it.crm.mapper.AfterSaleMapper;
import cn.it.crm.mapper.ContractMapper;
import cn.it.crm.service.IContractService;
import cn.it.crm.util.ContractSn;
import cn.it.crm.util.Execute;
import cn.it.crm.util.Operation;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractServiceImpl extends BaseServiceImpl<Contract> implements IContractService {
   @Autowired
    private ContractMapper mapper;

   @Autowired
   private AfterSaleMapper saleMapper;
    @Override
    public IBaseMapper<Contract> getMapper() {
        return mapper;
    }

    @Override
    @Operation(execute= Execute.SAVE)
    public void save(Contract contract) {
        AfterSale sale = new AfterSale();
        sale.setSn(ContractSn.getSn());
        sale.setCustomer(contract.getCustomer());
        /*设置*/
       sale.setExpireTime(DateUtils.addYears(contract.getSignTime(), 1));
        /*添加保修单质保到期时间 expire_time为自客户合同项目成功履行后，开始计时1年*/
        sale.setTenantId(contract.getTenantId());
        saleMapper.save(sale);
        mapper.save(contract);
    }
}
