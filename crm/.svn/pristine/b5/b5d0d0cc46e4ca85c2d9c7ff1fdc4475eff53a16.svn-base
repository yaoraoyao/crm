package cn.it.crm.service.impl;

import cn.it.crm.domain.ContractItem;
import cn.it.crm.mapper.ContractItemMapper;
import cn.it.crm.service.IContractItemService;
import cn.it.crm.util.Execute;
import cn.it.crm.util.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContractItemServiceImpl  implements IContractItemService {
    @Autowired
    private ContractItemMapper mapper;


    @Override
    public List<ContractItem> findListByCId(String id) {

        return mapper.findListByCId(id);
    }

    @Override
    @Operation(execute= Execute.SAVE)
    public void save(ContractItem item) {
        mapper.save(item);
    }

    @Override
    @Operation(execute=Execute.UPDATE)
    public void updat(ContractItem item) {
        mapper.update(item);
    }
}
