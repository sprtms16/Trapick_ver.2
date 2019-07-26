package trapick.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
   
   
   @RequestMapping(value = "share/{user}/{schd_idx}", method={RequestMethod.GET, RequestMethod.POST})
   public String share(@PathVariable("user") int user, @PathVariable("schd_idx")int schd_idx, RedirectAttributes rttr, HttpSession session){
	   int share = (int)session.getAttribute("user_idx");
	   
	   if(service.share(user, schd_idx, share)){
		   rttr.addFlashAttribute("result", "success");
	   };
	   
	   System.out.println("공유받는사람 " + user+", 공유 스케쥴 : "+schd_idx+", 공유하는 사람 : "+share);
	      return "redirect:/mypage/list";
   }
   
   
   @GetMapping("/list")
   public void list(Model model, HttpSession session) {
      int user_idx = (int) session.getAttribute("user_idx");
      UserVO userVO = service.userInfo(user_idx);
      model.addAttribute("user", userVO);
      model.addAttribute("list", service.scheduleList(userVO));
      model.addAttribute("userList", service.findUser());
   }
   
   @PostMapping("/update")
	public String updateUserInfo(UserVO userVO, RedirectAttributes rttr){
		if(service.updateUserInfo(userVO)){
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/mypage/list";
	}
   
   @RequestMapping(value = "remove/{schd_idx}", method={RequestMethod.GET, RequestMethod.POST})
   public String remove(@PathVariable("schd_idx") int schd_idx, RedirectAttributes rttr){
      if(service.remove(schd_idx)){
         rttr.addFlashAttribute("result", "success");
      }
      return "redirect:/mypage/list";
   }

   
}
