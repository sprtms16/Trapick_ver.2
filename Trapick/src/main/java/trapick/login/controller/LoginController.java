package trapick.login.controller;

import javax.servlet.http.HttpSession;

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

	@GetMapping("/join")
	public void JoinGet() {
	}

	@PostMapping("/joinPost")
	public String joinPost(UserVO user) throws Exception {
		feedService.join(user);
		return "redirect:login";
	}

	@GetMapping("/login")
	public void login(HttpSession session) {
	}

	@PostMapping("loginPost")
	public String loginPost(HttpSession session, UserVO user) {
		int user_idx = feedService.loginCheck(user);
		if (user_idx != 0) {
			session.setAttribute("user_idx", user_idx);
			return "redirect:/schedule/MainPage";
		} else
			return "login";
	}

	@RequestMapping("logout")
	public String logout(HttpSession session) throws Exception {
		session.removeAttribute("user_idx");
		return "redirect:/schedule/MainPage";
	}
}
