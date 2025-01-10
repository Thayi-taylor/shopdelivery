package com.project.shopdelivery.order;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/order")
@Controller
public class OrderController {
	
	@Autowired(required=true)
	OrderDAO dao;
	
	@GetMapping(value="/orderInsertForm.do")
	public String orderInsertForm() {
		return "order/orderInsertForm";
	}
	
	@PostMapping(value="/orderInsert.do")
	public String orderInsert(Order order) {
		dao.orderInsert(order);
		return "redirect:/order/orderList.do";
	}
	
	@GetMapping(value="/orderDetailInfo.do")
	public String orderDetailInfo(@RequestParam("orderIndex") int orderIndex, Model model) {
		
		// System.out.println("Received orderIndex: " + orderIndex);
		
		Order order = dao.getOrderDetailInfo(orderIndex);
		model.addAttribute("order", order);
		return "order/orderDetailInfo";
	}
	
	// 품명 검색 기능 (AJAX 처리)
	@GetMapping(value="/searchProducts.do")
	@ResponseBody
	public List<Order> searchProducts(@RequestParam("productName") String productName) {
		if(productName != null && productName.trim().length() >= 2) {
			return dao.searchProducts(productName);	// 품목명 검색 후 결과 반환
		}
		return new ArrayList<>();	// 검색어가 짧으면 빈 배열 반환
	}
	
	@GetMapping(value = "/orderList.do")
	public String orderList(Model model) {
		
		int count = dao.getAllCount();
		
		ArrayList<Order> orderList = dao.getOrderList();
		model.addAttribute("orderList", orderList);
		model.addAttribute("count", count);
		
		return "order/orderList";
	}
	
}
