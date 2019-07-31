package trapick.feed.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.AlertSubscribeVO;
import trapick.feed.domain.FeedVO;
import trapick.feed.domain.HeartVO;
import trapick.feed.domain.ReplyDislikeVO;
import trapick.feed.domain.ReplyLikeVO;
import trapick.feed.domain.SubscribeVO;
import trapick.feed.service.FeedService;
import trapick.feed.service.ReplyService;
import trapick.recommend.domain.SelectedItemVO;

@RestController
@RequestMapping("/RestFeed/")
@Log4j
@AllArgsConstructor
public class FeedRestController {

	FeedService feedService;
	ReplyService replyService;

	@RequestMapping("hearAction/{feed_idx}")
	public int heartAction(@PathVariable("feed_idx") int feed_idx, HttpSession session) {
		int user_idx =  (int) session.getAttribute("user_idx");
		HeartVO vo = new HeartVO();
		vo.setFeed_idx(feed_idx);
		vo.setUser_idx(user_idx);
		int count = feedService.switchingHeart(vo);
		return count;
	}

	@RequestMapping("replyLikeAction/{feed_idx}/{reply_idx}")
	public int replyLikeAction(@PathVariable("feed_idx") int feed_idx, @PathVariable("reply_idx") int reply_idx,
			HttpSession session) {
		int user_idx =  (int) session.getAttribute("user_idx");
		ReplyLikeVO vo = new ReplyLikeVO();
		vo.setFeed_idx(feed_idx);
		vo.setReply_idx(reply_idx);
		vo.setLiker(user_idx);
		int count = replyService.switchingLike(vo);
		return count;
	}

	@RequestMapping("replyDislikeAction/{feed_idx}/{reply_idx}")
	public int replyDislikeAction(@PathVariable("feed_idx") int feed_idx, @PathVariable("reply_idx") int reply_idx,
			HttpSession session) {
		int user_idx = (int) session.getAttribute("user_idx");
		ReplyDislikeVO vo = new ReplyDislikeVO();
		vo.setFeed_idx(feed_idx);
		vo.setReply_idx(reply_idx);
		vo.setDisliker(user_idx);
		int count = replyService.switchingDislike(vo);
		return count;
	}

	@PostMapping("insert")
	public ResponseEntity<String> insert(FeedVO vo, MultipartFile[] uploadFile, HttpSession session) {
		int user_idx = (int) session.getAttribute("user_idx");
		vo.setUser_idx(user_idx);
		String uploadPath = session.getServletContext().getRealPath("resources/upload");
		feedService.insertFeed(vo, uploadFile, uploadPath);
		return new ResponseEntity<String>("success!!", HttpStatus.OK);
	}
	
	
	@RequestMapping("followAction/{user_idx}")
	public int followAction(@PathVariable("user_idx") int feeder, HttpSession session){
		int subscriber = 2; //(int) session.getAttribute("user_idx");
		SubscribeVO sb = new SubscribeVO();
		sb.setFeeder(feeder);
		sb.setSubscriber(subscriber);
		int count = feedService.switchingSubscribe(sb);
		return count;
		
	}
	
	@RequestMapping("getSelectedItem/{schd_idx}")
	public List<SelectedItemVO> getSelectedItem(@PathVariable("schd_idx") int schd_idx){
		return feedService.getSelectedItem(schd_idx);
	}
	
	@PostMapping("getAlertList/{user_idx}")
	public List<AlertSubscribeVO> getAlertList(@PathVariable("user_idx") int user_idx){
		return feedService.getAlertList(user_idx);
	}

}
