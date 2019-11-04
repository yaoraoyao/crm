package cn.it.crm.service.impl;

import cn.it.crm.core.mapper.IBaseMapper;
import cn.it.crm.core.service.impl.BaseServiceImpl;
import cn.it.crm.domain.Menu;
import cn.it.crm.mapper.MenuMapper;
import cn.it.crm.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements IMenuService{
    @Autowired
    private MenuMapper menuMapper;

    @Override
    public IBaseMapper<Menu> getMapper() {
        return menuMapper;
    }

    /**
     * 查询所有
     * @return
     */
    @Override
    public List<Menu> findAll() {
        //todo 后期根据权限获取菜单
        HashMap<Long, Menu> map = new HashMap<>();
        List<Menu> menus = menuMapper.findAll();
        ArrayList<Menu> result = new ArrayList<>();
        //方便通过父级菜单id查询父级菜单的对象
        for (Menu menu : menus) {
            map.put(menu.getId(), menu);
        }
        //将菜单形成菜单树，封装到result里面
        for (Menu menu : menus) {
            if(menu.getParentId() == null){
                result.add(menu);
            }else {
                map.get(menu.getParentId()).getChildren().add(menu);
            }
        }

        return result;
    }
}
