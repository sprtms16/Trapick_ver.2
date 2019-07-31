package trapick.recommend.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import trapick.recommend.domain.CourseItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.Selected;
import trapick.recommend.service.RecommendService;

@RestController
@RequestMapping("/Rest/recommend/*")
@AllArgsConstructor
public class RecommendRestController {

	private RecommendService recommedService;

	@PostMapping("landMarkAjax")
	public List<LandmarkVO> landMarkAjax(@RequestParam("city_name") String city_name) {
		return recommedService.landMarkList(city_name);
	}

	@PostMapping("/saveLandMark")
	public void saveSchedule(@RequestParam(required=false) List<Integer> land_idx, @RequestParam List<String> position,
			@RequestParam List<String> item_name, @RequestParam List<String> item_price,
			@RequestParam List<String> item_detail, @RequestParam List<String> item_image, @RequestParam String title,
			@RequestParam String start_time, @RequestParam String end_time,HttpSession session) throws UnsupportedEncodingException {
		Map<String, List<Selected>> map = recommedService.getSelectedList(land_idx, position, item_name, item_price, item_detail, item_image, title, start_time, end_time);
		recommedService.saveSchedule(URLDecoder.decode(title, "UTF-8"), map.get("landList"), map.get("itemList"), start_time, end_time,(Integer)session.getAttribute("user_idx"));
		System.out.println("일정저장완료");
	}

	@PostMapping("/course")
	public List<CourseItemVO> course(@RequestParam(required=false) List<String> land_idx, @RequestParam List<String> item_price,
			@RequestParam List<String> item_name, @RequestParam List<String> item_detail,
			@RequestParam List<String> latitude, @RequestParam List<String> longitude,
			@RequestParam List<String> position, @RequestParam List<String> item_image) throws NumberFormatException, UnsupportedEncodingException {
		
		return recommedService.getCourse(land_idx, item_price, item_name, item_detail, latitude, longitude, position, item_image);
	}
}