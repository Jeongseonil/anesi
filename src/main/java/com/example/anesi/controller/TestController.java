package com.example.anesi.controller;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.anesi.model.User;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class TestController {
	@RequestMapping("footer.do") 
	public String footer(Model model) throws Exception{
        return "/footer";
    }
	@RequestMapping("modal.do") 
	public String modal(Model model) throws Exception{
		return "/modaltest";
	}
	
	@RequestMapping("main.do") 
	public String main(Model model) throws Exception{
		return "/main";
	}
	@RequestMapping("test.do") 
	public String test1(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/test";
	}
	@RequestMapping("testnavi.do") 
	public String testnavi(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/testNavi";
	}
	
	
	


}
