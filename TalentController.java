package com.springmvc.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.domain.TalentDTO;
import com.springmvc.service.TalentService;

@Controller
public class TalentController {

    @Autowired
    private TalentService talentService;

    // 홈 화면
    @GetMapping
    public String home() {
        return "home";
    }

    // 재능 목록 전체 조회 + 페이징
    @GetMapping("/talent")
    public String talentList(
        @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(value = "size", defaultValue = "5") int size,
        Model model) {

        List<TalentDTO> list = talentService.readPagedList(page, size);
        int totalCount = talentService.getCountAll();
        int totalPages = (int) Math.ceil((double) totalCount / size);

        model.addAttribute("talentList", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "talent";
    }

    // 카테고리별 재능 조회 + 페이징
    @GetMapping("/talent/{category}")
    public String TalentCateroy(@PathVariable("category") String category,
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(defaultValue = "5") int size,
        Model model) {

        List<TalentDTO> list;
        int totalCount;

        if ("전체".equals(category)) {
            list = talentService.readPagedList(page, size);
            totalCount = talentService.getCountAll();
        } else {
            list = talentService.readPagedCategory(category, page, size);
            totalCount = talentService.getCountByCategory(category);
        }

        int totalPages = (int) Math.ceil((double) totalCount / size);
        model.addAttribute("talentList", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("category", category); // 현재 카테고리 유지
        return "talent";
    }

    // 검색 기능 + 페이징
    @GetMapping("/talent/search")
    public String search(@RequestParam("keyword") String keyword,
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(defaultValue = "5") int size,
        Model model) {

        List<TalentDTO> searchList = talentService.searchPagedTalent(keyword, page, size);
        int totalCount = talentService.countSearchResult(keyword);
        int totalPages = (int) Math.ceil((double) totalCount / size);

        model.addAttribute("searchList", searchList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        return "talent";
    }

    // 재능 상세 보기
    @GetMapping("/talent/view")
    public String ViewTalent(@RequestParam("id") int id, Model model) {
        TalentDTO talent = talentService.readone(id);
        LocalDateTime ldt = talent.getCreated_at();
        Date createdDate = java.sql.Timestamp.valueOf(ldt);
        model.addAttribute("talent", talent);
        model.addAttribute("createdDate", createdDate);
        return "viewTalent";
    }

    // 재능 등록 폼 요청
    @GetMapping("/addtalent")
    public String requestAddTalentForm(@ModelAttribute("newTalent") TalentDTO dto) {
        return "addTalent";
    }

    // 재능 등록 처리
    @PostMapping("/addtalent")
    public String submitTalentForm(@ModelAttribute("newTalent") TalentDTO dto, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        dto.setMember_id(loginId);
        dto.setCreated_at(LocalDateTime.now());
        talentService.create(dto);
        return "redirect:/talent";
    }

    // 재능 삭제
    @GetMapping("/delete")
    public String deleteTalent(@RequestParam("id") int id) {
        talentService.delete(id);
        return "redirect:/talent";
    }

    // 재능 수정 폼 요청
    @GetMapping("/update")
    public String getUpdateTalentForm(@RequestParam("id") int id, Model model) {
        TalentDTO talent = talentService.readone(id);
        model.addAttribute("updateTalent", talent);
        return "updateForm";
    }

    // 재능 수정 처리
    @PostMapping("/update")
    public String submitUpdate(@ModelAttribute("updateTalent") TalentDTO dto) {
        talentService.update(dto);
        return "redirect:/talent";
    }
}
