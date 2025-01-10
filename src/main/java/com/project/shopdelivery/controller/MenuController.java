package com.project.shopdelivery.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/menu")
@Controller
public class MenuController {

	
	@GetMapping(value="/page1.do")
	public String page1() {
		return "menu/page1";
	}
	
	@GetMapping(value="/page2.do")
	public String page2() {
		return "menu/page2";
	}
	
	@GetMapping(value="/page3.do")
	public String page3() {
		return "menu/page3";
	}
	
	@GetMapping(value="/page4.do")
	public String page4() {
		return "menu/page4";
	}
	
	@GetMapping(value="/page5.do")
	public String page5() {
		return "menu/page5";
	}
	
	@GetMapping(value="/page6.do")
	public String page6() {
		return "menu/page6";
	}
	
	@GetMapping(value="/page7.do")
	public String page7() {
		return "menu/page7";
	}
	
	@GetMapping(value="/page8.do")
	public String page8() {
		return "menu/page8";
	}
	
	
	
	
	
	
	
	@PostMapping(value="/20_srarch.do")
	public String search(Model model) {
		
		String search = "뭘까";
		
		model.addAttribute("search" , search);
		
		return "menu/20_search";
	}
	
	
}
