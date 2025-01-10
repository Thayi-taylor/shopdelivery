package com.myspring.test.Admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/Admin")
@Controller
public class AdminController {
	@Autowired(required=true)
	AdminDAO dao;
	
	@GetMapping(value="/myPage.do")
	public String myPage() {
		return "Admin/myPage";
	}
}
