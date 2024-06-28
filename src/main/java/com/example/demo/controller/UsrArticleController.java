package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Util;
import com.example.demo.vo.Article;
import com.example.demo.vo.Rq;

@Controller
public class UsrArticleController {
	
	private ArticleService articleService;
	private Rq rq;
	
	public UsrArticleController(ArticleService articleService, Rq rq) {
		this.articleService = articleService;
		this.rq = rq;
	}
	
	@GetMapping("/usr/article/write")
	public String write() {
		return "usr/article/write";
	}
	
	@PostMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(int boardId, String title, String body) {
		articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);
		
		int id = articleService.getLastInsertId();
		
		return Util.jsReplace(String.format("%d번 게시물을 작성했습니다", id), String.format("detail?id=%d", id));
	}
	
	@PostMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {
		
		articleService.modifyArticle(id, title, body);
		
		return Util.jsReplace(String.format("%d번 게시물을 수정했습니다.", id), String.format("detail?id=%d", id));
	}
	
	@GetMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		articleService.deleteArticle(id);
		
		return Util.jsReplace(String.format("%d번 게시물을 삭제했습니다.", id), "list");
	}
	
	@GetMapping("/usr/article/list")
	public String list(Model model, int boardId, @RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "title") String searchKeywordType,
			@RequestParam(defaultValue = "") String searchKeyword) {
		
		String boardName = articleService.getBoardNameById(boardId);
		int articlesCnt = articleService.getArticlesCnt(boardId, searchKeywordType, searchKeyword);
		
		int itemsInAPage = 10;
		int limitFrom = (cPage - 1) * itemsInAPage;
		
		List<Article> articles = articleService.getArticles(boardId, searchKeywordType, searchKeyword, limitFrom, itemsInAPage);
		
		int from = ((cPage - 1) / 10) * 10 + 1;
		int end =  (((cPage - 1) / 10) + 1) * 10;
		
		int totalPageCnt = (int) Math.ceil((double) articlesCnt / itemsInAPage);
		
		if (end > totalPageCnt) {
			end = totalPageCnt;
		}

		model.addAttribute("cPage", cPage);
		model.addAttribute("from", from);
		model.addAttribute("end", end);
		model.addAttribute("totalPageCnt", totalPageCnt);
		model.addAttribute("boardName", boardName);
		model.addAttribute("articlesCnt", articlesCnt);
		model.addAttribute("articles", articles);
		
		return "usr/article/list";
	}
	
	@GetMapping("/usr/article/modify")
	public String modify(Model model, int id) {
		Article article = articleService.forPrintArticle(id);
		
		model.addAttribute("article", article);
		
		return "usr/article/modify";
	}
	
	@GetMapping("/usr/article/detail")
	public String detail(Model model, int id) {
		
		Article article = articleService.forPrintArticle(id);
		
		model.addAttribute("article", article);
		
		return "usr/article/detail";
	}
}