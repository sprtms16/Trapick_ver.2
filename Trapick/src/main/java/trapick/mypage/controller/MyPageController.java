package trapick.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import trapick.feed.domain.UserVO;
import trapick.mypage.service.MyPageService;

@Controller
@RequestMapping("/mypage/*")
@AllArgsConstructor
public class MyPageController {
   
   private MyPageService service;
   
   @GetMapping("/mypage")
   public void list(Model model, HttpSession session) {
      int user_idx = (int) session.getAttribute("user_idx");
      UserVO userVO = service.userInfo(user_idx);
      model.addAttribute("user", userVO);
      model.addAttribute("list", service.scheduleList(userVO));
      if(userVO.getImg_path()==null){
          userVO.setImg_path("/resources/image/2017-04-21 13.19.59.jpg");
       }else{
          userVO.setImg_path("/resources/upload/"+userVO.getImg_path());
       }
      List<UserVO> userList = service.findUser();
      userList.remove(user_idx-1);
      model.addAttribute("userList", userList);
      model.addAttribute("shareList", service.sharedSchd(user_idx));
      model.addAttribute("sharer", service.sharer(user_idx));
   }
   
   @RequestMapping(value = "remove/{schd_idx}", method={RequestMethod.GET, RequestMethod.POST})
   public String remove(@PathVariable("schd_idx") int schd_idx, RedirectAttributes rttr){
      if(service.remove(schd_idx)){
         rttr.addFlashAttribute("result", "success");
      }
      return "redirect:/mypage/mypage";
   }
   
   @RequestMapping(value = "share/{user}/{schd_idx}", method={RequestMethod.GET, RequestMethod.POST})
   public String share(@PathVariable("user") int user, @PathVariable("schd_idx")int schd_idx, RedirectAttributes rttr, HttpSession session){
	   int share = (int)session.getAttribute("user_idx");
	   
	   if(service.share(user, schd_idx, share)){
		   rttr.addFlashAttribute("result", "success");
	   };
	      return "redirect:/mypage/mypage";
   }
   
   @PostMapping("imgUpload")
   public String uploadImg(MultipartFile[] uploadFile, HttpSession session) {
      UserVO userVO = new UserVO();
      userVO.setUser_idx((int) session.getAttribute("user_idx"));
      String uploadPath = session.getServletContext().getRealPath("resources/upload");
      service.updateUserImg(userVO, uploadFile, uploadPath);
      return "redirect:mypage";
   }
}