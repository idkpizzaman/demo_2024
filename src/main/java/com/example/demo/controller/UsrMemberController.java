package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Util;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsrMemberController {
	private MemberService memberService;
	private Rq rq;
	
	public UsrMemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}
	
	@GetMapping("/usr/member/dojoin")
	@ResponseBody
	public ResultData<Member> doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		if (Util.isEmpty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요");
		}
		if (Util.isEmpty(loginPw)) {
			return ResultData.from("F-2", "비밀번호를 입력해주세요");
		}
		if (Util.isEmpty(name)) {
			return ResultData.from("F-3", "이름을 입력해주세요");
		}
		if (Util.isEmpty(nickname)) {
			return ResultData.from("F-4", "닉네임을 입력해주세요");
		}
		if (Util.isEmpty(cellphoneNum)) {
			return ResultData.from("F-5", "전화번호를 입력해주세요");
		}
		if (Util.isEmpty(email)) {
			return ResultData.from("F-6", "이메일을 입력해주세요");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member != null) {
			return ResultData.from("F-7", String.format("%s은(는) 이미 사용중인 아이디입니다", loginId));
		}

		memberService.joinMember(loginId, loginPw, name, nickname, cellphoneNum, email);

		int id = memberService.getLastInsertId();

		return ResultData.from("S-1", String.format("%s님이 가입되었습니다", nickname), memberService.getMemberById(id));		
	}

	@GetMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}
	
	@PostMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Util.jsHistoryBack(String.format("[%s]는 존재하지 않는 아이디입니다.", loginId));
		}
		
		if (member.getLoginPw().equals(loginPw) == false) {
			return Util.jsHistoryBack("비밀번호가 잘못되었습니다.");
		}
		
		rq.login(member);
		
		return Util.jsReplace(String.format("[%s]님 환영합니다!", member.getNickname()), "/");
	}
	
	@GetMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		rq.logout();

		return Util.jsReplace("정상적으로 로그아웃 되었습니다.", "/");
	}
}