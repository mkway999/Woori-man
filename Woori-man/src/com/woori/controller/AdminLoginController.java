package com.woori.controller;


import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;		//-- check~!!!
import org.springframework.web.bind.annotation.RequestParam;

import com.woori.dao.AdminLoginDAO;
import com.woori.dao.AdminMainDAO;
import com.woori.dto.AdminDTO;



@Controller
public class AdminLoginController
{
	
	// 로그인 폼 페이지 보여지기~
	@RequestMapping(value = "/adminloginform.woori")
	public String adminLoginForm()
	{
		return "/WEB-INF/view/AdminLogin.jsp";
	}
	
	// AdminMain 이동
	
	@RequestMapping(value = "/adminmain.woori")
	public String adminMain(HttpSession session, Model model) throws ClassNotFoundException, SQLException
	{
		AdminLoginDAO dao = new AdminLoginDAO();
		int count  = 0; 				// dao 결과값을 담을 변수
		String ad_code = (String) session.getAttribute("ad_code");
		dao.connection();
		
		count = dao.pwdInfo(ad_code);
		
		model.addAttribute("count", count);
		
		dao.close();
		String msg =  (String) session.getAttribute("msg");
		if (msg == "true")
		{	
			model.addAttribute("msg", msg);
			session.removeAttribute("msg");
		}
		
		// 노은하 관리자 메인 페이지 관련 업무 추가
		AdminMainDAO mainDAO = new AdminMainDAO();
		ArrayList<String> userCount = null;
		//ArrayList<String> userWthdr = null;
		ArrayList<String> dateList = new ArrayList<String>();
		
		try
		{
			userCount = mainDAO.userCount();
			//userWthdr = mainDAO.userWthdr();
			Calendar calendar = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			dateList.add(sdf.format(calendar.getTime()));
			for(int i=0; i<5; i++)
			{
				calendar.add(Calendar.DATE, - 1);
				dateList.add(sdf.format(calendar.getTime()));
			}
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally
		{
			try
			{
				mainDAO.close();
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}
		model.addAttribute("userCount", userCount);
		model.addAttribute("dateList", dateList);
		//model.addAttribute("userWthdr", userWthdr);
		
		return "/WEB-INF/view/AdminMain.jsp";
		
	}
	
	// 로그인 액션 처리 메소드
	@RequestMapping(value = "/adminlogin.woori")
	public String adminLogin(HttpSession session, @RequestParam("ad_code") String ad_code
										 	   , @RequestParam("ad_pwd") String ad_pwd) throws ClassNotFoundException, SQLException
	{
		AdminLoginDAO dao = new AdminLoginDAO();
		dao.connection();
		int count = 0;
		
		// 입력받은 아이디와 비밀번호를 통해 관리자 코드를 얻어옴
		count = dao.checkAdmin(ad_code, ad_pwd);	
		// 관리자 코드가 존재하지 않는 다면 다시 로그인폼으로  
		// 알맞은 관리자 코드가 존재한다면 ad_code를 세션에 등록하고
		// 관리자 메인페이지로 로그인 성공 시키기
		if (count == 0)
		{
			return "adminloginform.woori";
		}
		else
		{
			AdminDTO adminDTO = new AdminDTO(); 
			adminDTO = dao.adminInfo(ad_code); //세션에 올릴 adminDTO 객체 담기
			/* 로그 테스트
			System.out.println(adminDTO.getAd_code());
			System.out.println(adminDTO.getAd_pwd());
			System.out.println(adminDTO.getAd_ssn1());
			System.out.println(adminDTO.getAd_name());
			System.out.println(adminDTO.getAd_tel());
			System.out.println(adminDTO.getAd_create());
			*/
			session.setAttribute("adminDTO", adminDTO);
			session.setAttribute("ad_code", ad_code);
		}
		
		return "adminmain.woori";
	}
	
	// 관리자 비밀번호 변경 액션처리 메소드
	@RequestMapping(value = "/updateadpwd.woori")
	public String updateAdPwd(HttpSession session, Model model
			, @RequestParam("ad_pwd1") String ad_pwd) throws ClassNotFoundException, SQLException
	{
		AdminLoginDAO dao = new AdminLoginDAO();
		String ad_code = (String) session.getAttribute("ad_code");	// 세션에 담긴 관리자 코드 가져오기
		dao.connection();
		
		// 얻어온 값들을 매개변수로 하여 업데이트 메소드 수행
		dao.updatePwd(ad_pwd, ad_code);	
		
		String msg = "true";
		
		session.setAttribute("msg", msg);
		
		return "redirect:adminmain.woori";
	}
	
	
	// 로그아웃 클릭 시 세션을 제거하고 로그인 창으로 복귀
	@RequestMapping(value = "/adminlogout.woori")
	public String logout(HttpSession session)
	{
		session.invalidate();	// 담고 있던 모든 세션 정보 삭제
		
		return "adminloginform.woori";
	}
	
}











































