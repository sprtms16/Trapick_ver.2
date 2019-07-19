package trapick.feed.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.FeedVO;
import trapick.feed.service.FeedService;
import trapick.feed.service.ReplyService;

@Controller
@Log4j
@RequestMapping("/feed/")
@AllArgsConstructor
public class FeedController {

	private FeedService feedService;
	private ReplyService replyService;

	@GetMapping("echo")
	public void echo() {

	}

	@GetMapping("/list")
	public void feedList(Model model, @RequestParam HashMap<String, String> paramMap) {
		log.info("list");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_idx", 1);
		if (paramMap.get("keyword") != null) // hashtag
			map.put("keyword", "#" + paramMap.get("keyword"));
		if (paramMap.get("word") != null) // �˻�â�� �Է��� text��
			map.put("keyword", paramMap.get("word").replace(" ", "|"));
		List<FeedVO> list = feedService.getList(map);

		list.forEach(feed -> {
			Map<String, Object> replyInfo = new HashMap<>();
			replyInfo.put("user_idx", 1);
			replyInfo.put("feed_idx", feed.getFeed_idx());
			feed.setReplys(replyService.replyListService(replyInfo));
			feed.setUrl(feedService.selectFeedUrl(feed.getFeed_idx()));
		});
		model.addAttribute("list", list);
	}

	@GetMapping("insert")
	public void insert(@RequestParam(value = "schd_idx", required = false, defaultValue = "1") int schd_idx,
			Model model) {
		model.addAttribute("schd_idx", schd_idx);
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("feed_idx") int feed_idx, Model model) {
		log.info("/get or modify");
		model.addAttribute("feed", feedService.getFeed(feed_idx));
	}

	@PostMapping("/modify")
	public String modify(FeedVO feed, RedirectAttributes rttr) {
		log.info("modify:" + feed);

		if (feedService.modify(feed)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/feed/list";
	}

	@GetMapping("/remove")
	public String remove(@RequestParam("feed_idx") int feed_idx, RedirectAttributes rttr) {
		log.info("remove..." + feed_idx);
		if (feedService.remove(feed_idx)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/feed/list";
	}

}
