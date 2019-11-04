package cn.itsource.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.itsource.domain.User;
import cn.itsource.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private IUserService userService;
	
	@RequestMapping("/index.do")
	public String index(Model model){
		List<User> list = userService.findAll();
		model.addAttribute("users", list);
		return "forward:/users.jsp";
	}
	
	@RequestMapping("/add.do")
	public String add(User user){
		userService.add(user);
		return "redirect:/user/index.do";
	}
	
	@RequestMapping("/update.do")
	public String update(User user){
		userService.update(user);
		return "redirect:/user/index.do";
	}
	
	@RequestMapping("/delete.do")
	public String delete(Long id){
		userService.delete(id);
		return "redirect:/user/index.do";
	}
	
	@RequestMapping("/findById.do")
	public String findById(Long id, Model model){
		User user = userService.findById(id);
		model.addAttribute("user", user);
		return this.index(model);
	}
}
