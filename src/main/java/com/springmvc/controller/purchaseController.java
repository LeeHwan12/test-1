package com.springmvc.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.domain.Member;
import com.springmvc.domain.PurchaseRequestDTO;
import com.springmvc.domain.TalentDTO;
import com.springmvc.service.RankingService;
import com.springmvc.service.TalentService;
import com.springmvc.service.purchaseService;

@Controller
@RequestMapping("/purchase")
public class purchaseController {

    @Autowired
    TalentService talentService;

    @Autowired
    purchaseService purchaseService;
    
    @Autowired
    RankingService rankingService;
    /**
     * 재능 구매 상세 페이지로 이동
     * - 선택한 재능 정보 조회 후 purchase.jsp에 전달
     */
    @GetMapping
    public String talentPurchase(@RequestParam("id") int id, Model model) {
        // 재능 상세 조회
        TalentDTO talent = talentService.readone(id);

        // 시간 슬롯 포맷 적용
        talentService.formatTimeSlot(talent);

        // 모델에 재능 정보 추가
        model.addAttribute("talent", talent);
        return "purchase";  
    }

    /**
     * 구매 요청을 제출하는 POST 요청 처리
     * - 로그인한 사용자 정보를 DTO에 주입 후 저장
     */
    @PostMapping("/request")
    public String PurchaseRequest(@ModelAttribute PurchaseRequestDTO dto, HttpSession session) {
        // 로그인한 구매자 정보 가져오기
        Member buyer = (Member) session.getAttribute("loggedInUser");

        // 구매자 ID, 상태, 요청 시간 설정
        dto.setBuyer_id(buyer.getMember_id());
        dto.setStatus("PENDING");  // 초기 상태는 대기
        dto.setRequested_at(LocalDateTime.now());

        // 요청 저장
        purchaseService.save(dto);

        // 재능 목록 페이지로 리다이렉트
        return "redirect:/talent";
    }
    
    
    /**
     * 판매자가 받은 구매 요청 목록 조회
     * - 로그인한 판매자의 ID 기준으로 요청 리스트 조회
     */
    @GetMapping("/received")
    public String viewReceivedRequests(HttpSession session, Model model) {
        Member seller = (Member) session.getAttribute("loggedInUser");

        // 판매자가 받은 요청들 조회
        List<PurchaseRequestDTO> receivedList = purchaseService.findBySeller(seller.getMember_id());
        model.addAttribute("receivedRequests", receivedList);
        return "purchaseReceivedList";
    }
    
    

    /**
     * 판매자가 특정 요청을 승인하는 요청 처리
     * - 상태를 APPROVED로 변경
     */
    @PostMapping("/approve")
    public String approveRequest(@RequestParam("request_id") Long requestId) {
        // 1. 상태 변경
        purchaseService.updateStatus(requestId, "APPROVED");

        // 2. 요청 상세 조회 (누가 어떤 재능을 구매했는지)
        PurchaseRequestDTO request = purchaseService.findById(requestId);
        long talentId = request.getTalent_id();
        String sellerId = talentService.readone((int)talentId).getMember_id();
        //TODO: time_wallet balance 갱신
        
        // 3. 랭킹 갱신
        rankingService.handleRankingAfterPurchase(talentId, sellerId);
        return "redirect:/purchase/received";
    }

    /**
     * 판매자가 요청을 거절하는 처리
     * - 상태를 REJECTED로 변경
     */
    @PostMapping("/reject")
    public String rejectRequest(@RequestParam("request_id") Long requestId) {
        // 요청 상태를 'REJECTED'로 변경
        purchaseService.updateStatus(requestId, "REJECTED");
        return "redirect:/purchase/received";
    }
}
