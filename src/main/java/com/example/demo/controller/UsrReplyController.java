package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.LikePointService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Util;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
public class UsrReplyController {
	private ReplyService replyService;
	private Rq rq;
	
	public UsrReplyController(ReplyService replyService, Rq rq){
		this.replyService = replyService;
		this.rq = rq;
	}
	
	@PostMapping("/usr/reply/doWrtie")
	public String doWrite(String body, String relTypeCode, int relId) {
		replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);
		
		return Util.jsReplace("댓글이 작성되었습니다.", String.format("../article/detail?id=%d", relId));
	}
	
}
