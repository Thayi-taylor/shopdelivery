package com.myspring.test.User;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/User")
@Controller
public class UserController {
	@Autowired(required=true)
	@GetMapping(value="/registerUser.do")
	public String registerUser () {
		System.out.println("들어옴");
		return "User/registerUser";
	}
	@GetMapping(value="/login.do")
	public String login() {
		return "User/login";
	}
	@GetMapping(value="/loggout.do")
	public String logout(HttpSession session) {
		session.setAttribute("log", null);
		System.out.println("로그아웃성공");
	    return "redirect:/index.do"; 
	
	}
	@GetMapping(value="/findId.do")
	public String findId() {
		return "User/findId";
	}
}
