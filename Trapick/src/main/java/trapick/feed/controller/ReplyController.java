package trapick.feed.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.FeedVO;
import trapick.feed.domain.ReplyVO;
import trapick.feed.service.ReplyService;

@RestController
@RequestMapping("reply")
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;

	@PostMapping("new")
	public ResponseEntity<String> create(ReplyVO vo, HttpSession session) {
		log.info("ReplyVO:" + vo);
		log.info("fdsfsdaf");
		vo.setUser_idx((int) session.getAttribute("user_idx"));
		int insertCount = service.insertReplyService(vo);
		log.info("Reply INSERT COUNT :" + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>("faile", HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping("replyList")
	public List<ReplyVO> replyList(@RequestParam Map<String, Object> map, HttpSession session) {
		map.put("user_idx", (int) session.getAttribute("user_idx"));
		return service.replyListService(map);
	}

}
