package cn.itsource.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.itsource.dao.IUserDao;
import cn.itsource.domain.User;
import cn.itsource.service.IUserService;

@Service
@Transactional(readOnly=true)
public class UserServiceImpl implements IUserService{
	
	@Autowired
	private IUserDao userDao;

	@Override
	@Transactional
	public void add(User user) {
		userDao.add(user);
	}

	@Override
	@Transactional
	public void delete(Long id) {
		userDao.delete(id);
	}

	@Override
	@Transactional
	public void update(User user) {
		userDao.update(user);
	}

	@Override
	public User findById(Long id) {
		return userDao.findById(id);
	}

	@Override
	public List<User> findAll() {
		return userDao.findAll();
	}

}
