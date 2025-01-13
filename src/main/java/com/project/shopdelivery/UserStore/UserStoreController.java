package com.myspring.test.UserStore;



import org.springframework.ui.Model;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/Store")
@Controller
public class UserStoreController {
	@Autowired(required=true)
	UserStoreDAO dao;
	@GetMapping(value="/registerStore.do")
	public String registerStore() {
		return "Store/registerStore";
	}
	//http://localhost:8999/project/Store/registerStore.do
	@PostMapping(value="/registerStorePro.do")
	public String registerStorePro(UserStore userstore, Model model) {
		int check= dao.checkUserStoreId(userstore.getStoreID());
		//1: 회원가입 -1: 중복아이디 존재 
		if(check==1) {
			dao.userJoin(userstore);
		}
		System.out.println("check:"+check);
		model.addAttribute("check",check);
		return "Store/registerStorePro";
	}
	@GetMapping(value="/loginStore.do")
	public String loginStore() {
		return "Store/loginStore";
	}
	@PostMapping(value="/loginStorePro.do")
	public String loginStorePro(UserStore userstore,Model model, HttpSession session) {
		int check= dao.loginStoreIdPw(userstore);
		   if (check == 1) {
		        // 로그인 성공 후 storeName 값 확인
		        if (userstore.getStoreName().equals("관리자")) {
		            // "관리자"일 경우 세션에 'admin' 값 설정
		            session.setAttribute("log", "admin");
		        } else {
		            // 다른 사용자일 경우 storeName을 세션에 설정
		            session.setAttribute("log", userstore.getStoreName());
		        }
		        System.out.println("log:" + userstore.getStoreName());
		    }
		return "index";
	}
	@GetMapping(value="/findStoreId.do")
	public String findStoreId() {
		return "Store/findStoreId";
	}
	@PostMapping(value="/findStoreIdPro.do")
	public String findStoreIdPro(UserStore userstore, Model model, HttpSession session) {
		int check=dao.fineUserStoreId(userstore);
		if (check==1) {
			session.setAttribute("findId", userstore.getStoreID());
			System.out.println("userstore.id:"+userstore.getStoreID());
		}
		model.addAttribute("check",check);
		return "Store/findStoreIdresult";
	}
	@GetMapping(value="/findStorePw.do")
	public String findStorePw() {
		return "Store/findStorePw";
	}
	@PostMapping(value="/findStorePwPro.do")
	public String findStorePwPro(UserStore userstore, Model model, HttpSession session) {
		int check= dao.findStorePw(userstore);
		if (check==1) {
			session.setAttribute("findPw", userstore.getStorePW());
			System.out.println("userstore pw:"+userstore.getStorePW());
		}else if (check!=1) {
			System.out.println("결과없음 check="+check);
		}
		model.addAttribute("check",check);
		return "Store/findStorePwresult";
	}
}
