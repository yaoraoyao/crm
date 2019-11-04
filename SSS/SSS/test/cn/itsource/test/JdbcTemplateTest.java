package cn.itsource.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.itsource.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class JdbcTemplateTest {
	
	
	@Autowired
	private JdbcTemplate jt;
	
	@Test
	public void testAdd() throws Exception {
		String sql = "insert into user(name,pwd,gender,age) values(?,?,?,?)";
		jt.update(sql, "张三丰","qwer1234",1,19);
	}
	
	@Test
	public void testDelete() throws Exception {
		String sql = "delete from user where id = ?";
		jt.update(sql, 16);
	}
	
	@Test
	public void testUpdate() throws Exception {
		String sql = "update user set name=?,pwd=?,gender=?,age=? where id=?";
		jt.update(sql, "张无忌", "123aaa", 0, 22, 19);
	}
	
	@Test
	public void testFindAll() throws Exception {
		String sql = "select * from user";
		/**
		 * RowMapper 行的映射器
		 * 	作用就是将查询到的结果集的每一行通过一个工具处理，封装成一个domain实体类对象，最后放入List集合中进行返回
		 * BeanPropertyRowMapper
		 * 	BeanPropertyRowMapper是RowMapper接口的实现类，要求domain实体类的属性名称与查询的结果集的列名称保持一致，类型要匹配
		 */
		List<User> list = jt.query(sql, new BeanPropertyRowMapper<User>(User.class));
		list.forEach(u -> System.out.println(u));
		/**
		 * new RowMapper<User>(){
			@Override
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				User user = new User();
				user.setId(rs.getLong(1));
				user.setName(rs.getString(2));
				user.setPwd(rs.getString(3));
				user.setGender(rs.getInt(4));
				user.setAge(rs.getInt(5));
				return user;
			}
		}
		 */
	}
	
	

}
