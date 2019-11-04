package cn.itsource.dao;

import java.util.List;

import cn.itsource.domain.User;

public interface IUserDao {
	
	void add(User user);

	void delete(Long id);
	
	void update(User user);
	
	User findById(Long id);
	
	List<User> findAll();
}
