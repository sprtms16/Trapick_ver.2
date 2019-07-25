package trapick.recommend.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import trapick.recommend.domain.CourseAlgo;
import trapick.recommend.domain.CourseItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;
import trapick.recommend.domain.CourseItemVO;
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
	public void saveSchedule(@RequestParam List<Integer> land_idx, @RequestParam List<String> position,
			@RequestParam List<String> item_name, @RequestParam List<String> item_price,
			@RequestParam List<String> item_detail, @RequestParam List<String> item_image, @RequestParam String title,
			@RequestParam String start_time, @RequestParam String end_time) {
		System.out.println("일정저장시작");
		List<SelectedLandMarkVO> landList = new ArrayList<>();
		List<SelectedItemVO> itemList = new ArrayList<>();
		int i = 0;
		int j = 0;
		for (; i + j < item_price.size();) {
			if (item_price.get(i + j).equals("0")) {
				landList.add(new SelectedLandMarkVO(0, land_idx.get(i), position.get(i + j)));
				i++;
			} else {
				itemList.add(new SelectedItemVO(0, item_name.get(j), item_detail.get(j), item_price.get(i + j),
						position.get(i + j), item_image.get(j), 0));
				j++;
			}
		}
		String start_day = start_time;
		String end_day = end_time;
		recommedService.saveSchedule(title, landList, itemList, start_day, end_day);
		System.out.println("일정저장완료");
	}

	// @PostMapping(value = "/course", produces = "application/text;
	// charset=utf8")
	// public String course(@RequestParam List<String> item_name, @RequestParam
	// List<String> latitude,
	// @RequestParam List<String> longitude) {
	// List<CourseItemVO> list = new ArrayList<>();
	// for (int i = 0; i < item_name.size(); i++) {
	// list.add(new CourseItemVO(item_name.get(i),
	// Double.parseDouble(latitude.get(i)),
	// Double.parseDouble(longitude.get(i))));
	// }
	//
	// double dist[][] = new double[item_name.size()][item_name.size()];
	// for (int i = 0; i < item_name.size(); i++) {
	// for (int j = 0; j < item_name.size(); j++) {
	// if (i == j) {
	// dist[i][j] = 0;
	// } else {
	// dist[i][j] = recommedService.distance(list.get(i).getLatitude(),
	// list.get(i).getLongitude(),
	// list.get(j).getLatitude(), list.get(j).getLongitude());
	// }
	// }
	// }
	//
	// for (int i = 0; i < item_name.size(); i++) {
	// for (int j = 0; j < item_name.size(); j++) {
	// System.out.print(dist[i][j] + " ");
	// }
	// System.out.println();
	//
	// }
	//
	// CourseAlgo algo = new CourseAlgo(dist.length, dist, new
	// boolean[dist.length], new int[dist.length], new int[dist.length],
	// 100000);
	// algo.tsp(0, 0, 1, dist.length-1);
	//
	// for(int i = 0; i<dist.length; i++){
	// System.out.print(algo.getResult()[i]);
	// }
	//
	// String course = "";
	// for(int i = 0; i<dist.length; i++){
	// course += item_name.get(algo.getResult()[i])+" ->";
	// }
	// System.out.println(course);
	//
	// return course;
	// }

	@PostMapping("/course")
	public List<CourseItemVO> course(@RequestParam List<String> land_idx, @RequestParam List<String> item_price,
			@RequestParam List<String> item_name, @RequestParam List<String> item_detail,
			@RequestParam List<String> latitude, @RequestParam List<String> longitude,
			@RequestParam List<String> position, @RequestParam List<String> item_image) {
		System.out.println(land_idx.size());
		System.out.println(item_price.size());
		System.out.println(item_detail.size());
		System.out.println(latitude.size());
		System.out.println(longitude.size());
		System.out.println(position.size());
		System.out.println(item_image.size());
		System.out.println(item_name.size());
		List<CourseItemVO> list = new ArrayList<>();
		int i = 0;
		int j = 0;
		for (; i + j < item_price.size();) {
			if (item_price.get(i + j).equals("0")) {
				list.add(new CourseItemVO(land_idx.get(i), item_detail.get(i + j), item_price.get(i + j),
						item_name.get(i + j), Double.parseDouble(latitude.get(i+j)), Double.parseDouble(longitude.get(i+j)), position.get(i + j),
						item_image.get(i + j)));
				i++;
			} else {
				list.add(new CourseItemVO("0", item_detail.get(i+j), item_price.get(i+j), item_name.get(i+j), Double.parseDouble(latitude.get(i+j)), Double.parseDouble(longitude.get(i+j)), position.get(i+j), item_image.get(i+j)));
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
