package cn.itsource.dao.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import cn.itsource.dao.IUserDao;
import cn.itsource.domain.User;

@Repository
public class UserDaoImpl implements IUserDao {
	
	@Autowired
	private JdbcTemplate jt;

	@Override
	public void add(User user) {
		String sql = "insert into user(name,pwd,gender,age) values(?,?,?,?)";
		jt.update(sql, user.getName(), user.getPwd(), user.getGender(), user.getAge());
	}

	@Override
	public void delete(Long id) {
		String sql = "delete from user where id=?";
		jt.update(sql, id);
	}

	@Override
	public void update(User user) {
		String sql = "update user set name=?,pwd=?,gender=?,age=? where id=?";
		jt.update(sql, user.getName(), user.getPwd(), user.getGender(), user.getAge(), user.getId());
	}

	@Override
	public User findById(Long id) {
		String sql = "select * from user where id=?";
		List<User> list = jt.query(sql, new BeanPropertyRowMapper<User>(User.class), id);
		if(null != list && list.size() == 1){
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<User> findAll() {
		String sql = "select * from user";
		return jt.query(sql, new BeanPropertyRowMapper<User>(User.class));
	}

}
