package com.project.shopdelivery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/dashboard")
@Controller
public class DashboardController {
	

	@GetMapping(value="/dashboard.do")
	public String dashboard() {
		return "00_dashboard";
	}
	
	
}
