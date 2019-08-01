package trapick.recommend.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import trapick.recommend.domain.CourseAlgo;
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
	public void saveSchedule(@RequestParam(required = false) List<Integer> land_idx,
			@RequestParam List<String> position, @RequestParam List<String> item_name,
			@RequestParam List<String> item_price, @RequestParam List<String> item_detail,
			@RequestParam List<String> item_image, @RequestParam String title, @RequestParam String start_time,
			@RequestParam String end_time, HttpSession session) throws UnsupportedEncodingException {
		Map<String, List<Selected>> map = recommedService.getSelectedList(land_idx, position, item_name, item_price,
				item_detail, item_image, title, start_time, end_time);
		recommedService.saveSchedule(URLDecoder.decode(title, "UTF-8"), map.get("landList"), map.get("itemList"),
				start_time, end_time, (Integer) session.getAttribute("user_idx"));
		System.out.println("일정저장완료");
	}

	@PostMapping("/course")
	public List<CourseItemVO> course(@RequestParam(required = false) List<String> land_idx,
			@RequestParam List<String> item_price, @RequestParam List<String> item_name,
			@RequestParam List<String> item_detail, @RequestParam List<String> latitude,
			@RequestParam List<String> longitude, @RequestParam List<String> position,
			@RequestParam List<String> item_image) {
		List<CourseItemVO> list = new ArrayList<>();
		int i = 0;
		int j = 0;
		for (; i + j < item_price.size();) {
			if (item_price.get(i + j).equals("0")) {
				list.add(new CourseItemVO(land_idx.get(i), item_detail.get(i + j), item_price.get(i + j),
						item_name.get(i + j), Double.parseDouble(latitude.get(i + j)),
						Double.parseDouble(longitude.get(i + j)), position.get(i + j), item_image.get(i + j)));
				i++;
			} else {
				list.add(new CourseItemVO("0", item_detail.get(i + j), item_price.get(i + j), item_name.get(i + j),
						Double.parseDouble(latitude.get(i + j)), Double.parseDouble(longitude.get(i + j)),
						position.get(i + j), item_image.get(i + j)));
				j++;
			}
		}
		System.out.println(list);

		double dist[][] = new double[item_name.size()][item_name.size()];
		for (int a = 0; a < item_name.size(); a++) {
			for (int b = 0; b < item_name.size(); b++) {
				if (a == b) {
					dist[a][b] = 0;
				} else {
					dist[a][b] = recommedService.distance(list.get(a).getLatitude(), list.get(a).getLongitude(),
							list.get(b).getLatitude(), list.get(b).getLongitude());
				}
			}
		}

		for (int a = 0; a < item_name.size(); a++) {
			for (int b = 0; b < item_name.size(); b++) {
				System.out.print(dist[a][b] + " ");
			}
			System.out.println();

		}

		CourseAlgo algo = new CourseAlgo(dist.length, dist, new boolean[dist.length], new int[dist.length],
				new int[dist.length], 100000);
		algo.tsp(0, 0, 1, dist.length - 1);

		for (int a = 0; a < dist.length; a++) {
			System.out.print(algo.getResult()[a]);
		}
		List<CourseItemVO> resultList = new ArrayList<>();
		for (int a = 0; a < dist.length; a++) {
			resultList.add(list.get(algo.getResult()[a]));
		}
		System.out.println(list);
		System.out.println(resultList);

		return resultList;
	}
}