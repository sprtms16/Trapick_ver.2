package trapick.login.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.UserVO;
import trapick.feed.service.FeedService;

@Controller
@Log4j
@RequestMapping("/sign/")
@AllArgsConstructor
public class LoginController {

	private FeedService feedService;
	PasswordEncoder passwordEncoder;
	
	@GetMapping("/join")
	public void JoinGet() {
	}

	@PostMapping("/joinPost")
	public String joinPost(UserVO user) throws Exception {
		String encPassword = passwordEncoder.encode(user.getPw());
		user.setPw(encPassword);
		
			
		feedService.join(user);
		return "redirect:login";
	}

	@GetMapping("/login")
	public void login(HttpSession session) {
	}

	@PostMapping("loginPost")
	public String loginPost(HttpSession session, UserVO user) {
		
		String rawPw = user.getPw();//평문
		String encodedPw = feedService.getPw(user);//암호문
		
		if(passwordEncoder.matches(rawPw,encodedPw)){
			user.setPw(encodedPw);
			int user_idx = feedService.loginCheck(user);
			if (user_idx != 0) {
				session.setAttribute("user_idx", user_idx);
				return "redirect:/schedule/MainPage";
			} else
				return "redirect:login";
		}else
			return "redirect:login";
		
		
	}

	@RequestMapping("logout")
	public String logout(HttpSession session) throws Exception {
		session.removeAttribute("user_idx");
		return "redirect:/schedule/MainPage";
	}
}
