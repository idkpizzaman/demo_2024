package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.LikePointDao;
import com.example.demo.vo.LikePoint;
import com.example.demo.vo.ResultData;

@Service
public class LikePointService {

	private LikePointDao likePointDao;
	public LikePointService(LikePointDao likePointDao) {
		this.likePointDao = likePointDao;
	}
	
	public ResultData<Integer> getLikePoint(int loginedMemberId, String relTypeCode, int relId) {
		LikePoint likePoint = this.likePointDao.getLikePoint(loginedMemberId, relTypeCode, relId);
		
		int totalCnt = this.likePointDao.getTotalCnt(relTypeCode, relId);
		
		if (likePoint == null) {
			return ResultData.from("F-1", "좋아요 기록 없음", totalCnt);
		}
		
		return ResultData.from("S-1", "좋아요 기록 있음", totalCnt);
	}
	
	public void deleteLikePoint(int loginedMemberId, String relTypeCode, int relId) {
		this.likePointDao.deleteLikePoint(loginedMemberId, relTypeCode, relId);
	}

	public void insertLikePoint(int loginedMemberId, String relTypeCode, int relId) {
		this.likePointDao.insertLikePoint(loginedMemberId, relTypeCode, relId);
	}

}
