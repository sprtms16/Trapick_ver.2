package trapick.recommend.service;

import java.util.List;
import java.util.Map;

import trapick.recommend.domain.CourseItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.Selected;

public interface RecommendService {

	public List<LandmarkVO> landMarkList(String city_name);

	public List<String> cityList(String country_name);

	public void saveSchedule(String title, List<Selected> landList, List<Selected> itemList, String start_time,
			String end_time);

	public double distance(double lat1, double lon1, double lat2, double lon2);

	public double deg2rad(double deg);

	public double rad2deg(double rad);

	public Map<String, List<Selected>> getSelectedList(List<Integer> land_idx, List<String> position,
			List<String> item_name, List<String> item_price, List<String> item_detail, List<String> item_image,
			String title, String start_time, String end_time);

	public List<CourseItemVO> getCourse(List<String> land_idx, List<String> item_price, List<String> item_name,
			List<String> item_detail, List<String> latitude, List<String> longitude, List<String> position,
			List<String> item_image);

}
