package com.myspring.test.UserDriver;
import org.springframework.ui.Model;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/Driver")
@Controller
public class UserDriverController {
	@Autowired(required=true)
	UserDriverDAO dao;
	
	@GetMapping(value="/registerDriver.do")
	public String registerDriver() {
		return "Driver/registerDriver";
	}
	//회원가입
	@PostMapping(value="/registerDriverPro.do")
    public String registerDriverPro(UserDriver userdriver, Model model) {
        // 비밀번호 암호화

        int check = dao.checkUserDriverID(userdriver.getDriverID());
        System.out.println("check:"+check);
        if (check == 1) {
            dao.DriverJoin(userdriver);
        }
        System.out.println("여기는 왔나");
        model.addAttribute("check", check);
        return "index";
    }
	
	@GetMapping(value="/loginDriver.do")
	public String loginDriver() {
		return "Driver/loginDriver";
	}
	@PostMapping(value="/loginDriverPro.do")
	public String loginDriverPro(UserDriver userdriver, Model model, HttpSession session){
		int check=dao.loginDriverIDPW(userdriver);
		//-1: 정보 없음 1:있음
		if (check==1) {
			session.setAttribute("log", userdriver.getDriverName());
		}
		System.out.println("log:"+userdriver.getDriverName());
		return "index";
	}
	@GetMapping(value="/findDriverId.do")
	public String findDriverId() {
		return "Driver/findDriverId";
	}
	@PostMapping(value="/findDriverIdPro.do")
	public String findDriverIdPro(UserDriver userdriver, Model model, HttpSession session) {
		int check= dao.findDriverID(userdriver);
		//1: 정보 있음 -1: 없음 
		if (check==1) {
			session.setAttribute("findId", userdriver.getDriverID());
			System.out.println("userdriver.id:"+userdriver.getDriverID());
		}
		model.addAttribute("check",check);
		return "Driver/findDriverIDresult";
	}
	@GetMapping(value="/findDriverPw.do")
	public String findDriverPw() {
		return "Driver/findDriverPw";
	}
	@PostMapping("/findDriverPwPro.do")
	public String findDriverPwPro(UserDriver userdriver, Model model, HttpSession session) {
		int check=dao.findDriverPw(userdriver);
		//1: 정보 있음 -1: 없음 
		if (check==1) {
			session.setAttribute("findPw", userdriver.getDriverPW());
			System.out.println("userdriver.pw:"+userdriver.getDriverPW());
		}
		model.addAttribute("check",check);
		return "Driver/findDriverPwresult";
	}
}

