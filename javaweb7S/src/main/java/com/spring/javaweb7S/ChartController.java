package com.spring.javaweb7S;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb7S.etc.PageProcess;
import com.spring.javaweb7S.etc.PageVO;
import com.spring.javaweb7S.service.ChartService;
import com.spring.javaweb7S.vo.ChartVO;
import com.spring.javaweb7S.vo.SurveyContentVO;

@Controller
@RequestMapping("/chart")
public class ChartController {
	
	@Autowired
	ChartService chartService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public String practice(Model model,ChartVO vo, ChartVO vo2, ChartVO vo3, ChartVO vo4, ChartVO vo5, ChartVO vo6,
			ChartVO vo7, ChartVO vo8, ChartVO vo9, ChartVO vo10,
			@RequestParam(name="part", defaultValue="", required=false) String part,
			@RequestParam(name="year", defaultValue="", required=false) String year
			) {
		vo = chartService.getTotalRevenue();
		vo2 = chartService.getTotalExpense();
		
		vo3 = chartService.getYearRevenue(year);
		vo4 = chartService.getYearExpense(year);
		
		vo5 = chartService.getMemberExpense();
		vo6 = chartService.getMedicineExpense();
		vo7 = chartService.getFeedExpense();
		vo8 = chartService.getSemenExpense();
		vo9 = chartService.getFacilityExpense();
		vo10 = chartService.getregistrationExpense();
		
		model.addAttribute("vo5", vo5);
		model.addAttribute("vo6", vo6);
		model.addAttribute("vo7", vo7);
		model.addAttribute("vo8", vo8);
		model.addAttribute("vo9", vo9);
		model.addAttribute("vo10", vo10);
		
		model.addAttribute("vo", vo);
		model.addAttribute("vo2", vo2);
		model.addAttribute("vo3", vo3);
		model.addAttribute("vo4", vo4);
		model.addAttribute("part", part);
		model.addAttribute("year", year);
		return "chart/chart";
	}
	
	@RequestMapping(value = "/opt1", method = RequestMethod.GET)
	public String opt1(Model model, ChartVO vo, ChartVO vo2) {
		vo = chartService.getTotalRevenue();
		vo2 = chartService.getTotalExpense();
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("vo2", vo2);
		return "chart/opt1";
	}
	
	@RequestMapping(value = "/opt2", method = RequestMethod.GET)
	public String opt2(Model model, ChartVO vo3, ChartVO vo4,
			@RequestParam(name="part", defaultValue="", required=false) String part,
			@RequestParam(name="year", defaultValue="", required=false) String year
			) {
		vo3 = chartService.getYearRevenue(year);
		vo4 = chartService.getYearExpense(year);
		
		model.addAttribute("vo3", vo3);
		model.addAttribute("vo4", vo4);
		model.addAttribute("year", year);
		model.addAttribute("part", part);
		return "chart/opt2";
	}
	
	@RequestMapping(value = "/opt3", method = RequestMethod.GET)
	public String opt3(ChartVO vo5, ChartVO vo6, ChartVO vo7, ChartVO vo8, ChartVO vo9, ChartVO vo10, Model model) {
		
		vo5 = chartService.getMemberExpense();
		vo6 = chartService.getMedicineExpense();
		vo7 = chartService.getFeedExpense();
		vo8 = chartService.getSemenExpense();
		vo9 = chartService.getFacilityExpense();
		vo10 = chartService.getregistrationExpense();
		
		model.addAttribute("vo5", vo5);
		model.addAttribute("vo6", vo6);
		model.addAttribute("vo7", vo7);
		model.addAttribute("vo8", vo8);
		model.addAttribute("vo9", vo9);
		model.addAttribute("vo10", vo10);
		
		return "chart/opt3";
	}
	
	// 설문관리
	@RequestMapping(value = "/surveyM", method = RequestMethod.GET)
	public String surveyM(Model model,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize
			) {
		
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "survey", "", "");
		
		List<SurveyContentVO> vos= chartService.getSurveyContent(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "chart/surveyM";
	}
	
	// 설문등록
	@RequestMapping(value = "/surveyInput", method = RequestMethod.GET)
	public String survetInput() {
		return "chart/surveyInput";
	}
	
	// 설문조사 : 기본 폼
	@RequestMapping(value = "/survey", method = RequestMethod.GET)
	public String survey(Model model,
			@RequestParam(name="page", defaultValue = "1", required=false) int page,
			@RequestParam(name="pageSize", defaultValue = "20", required=false) int pageSize
			) {
		PageVO pageVO = pageProcess.totRecCnt(page, pageSize, "survey", "", "");
		
		List<SurveyContentVO> vos = chartService.getSurveyContent(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "chart/survey";
	}
	
	// 설문지 내용
	@RequestMapping(value = "/surveyContent", method = RequestMethod.GET)
	public String chartContent(Model model, HttpSession session,
			@RequestParam(name="idx", defaultValue="", required=false) int idx
			) {
		List<SurveyContentVO> vos = chartService.setSurveyContent(idx);
		
		// 조회수 증가
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			chartService.setSurveyReadNum(idx);	// 조회수 1증가하기
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		model.addAttribute("vos", vos);
		return "chart/surveyContent";
	}
	
	// 설문조사지 등록
	@ResponseBody
	@RequestMapping(value = "/surveyInputOk", method = RequestMethod.POST)
	public String surveyInputOk(SurveyContentVO vo) {

		chartService.setSurveyInput(vo);
		
		return "";
	}
	
	// 설문조사 : 삭제
	@ResponseBody
	@RequestMapping(value = "/surveyDelete", method = RequestMethod.POST)
	public String surveyDelete(int idx) {
		chartService.setSurveyDelete(idx);
		return "";
	}
	
}
