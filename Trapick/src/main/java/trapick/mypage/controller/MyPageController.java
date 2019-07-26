package trapick.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.UserVO;
import trapick.mypage.service.MyPageService;

@Controller
@Log4j
@RequestMapping("/mypage/*")
@AllArgsConstructor
public class MyPageController {
	
	private MyPageService service;
	
	@GetMapping("/list")
	public void list(Model model, HttpSession session){
		int user_idx = (int) session.getAttribute("user_idx");
		UserVO userVO = service.userInfo(user_idx);
		model.addAttribute("user", userVO);
		model.addAttribute("list", service.scheduleList(userVO));
	}
	

	@PostMapping("/remove")
	public String remove(@RequestParam("schd_idx") int schd_idx, RedirectAttributes rttr){
		
		if(service.remove(schd_idx)){
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/mypage/list";
	}
	
}
