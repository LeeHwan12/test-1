package com.springmvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc.domain.Member;
import com.springmvc.service.MemberService;

@Controller
@RequestMapping("/mypage")
public class MyPageController  {
	@Autowired
	MemberService memberService;
	
	@GetMapping
    public String myPage(HttpSession session, Model model) {
		Member sessionMember = (Member) session.getAttribute("loggedInUser");
        if (sessionMember == null) {
            return "redirect:/login";
        }

        String loginId = sessionMember.getMember_id();
        Member member = memberService.findById(loginId);
        model.addAttribute("member", member);
        return "mypage";
    }
	
	
}
