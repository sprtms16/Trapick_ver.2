package trapick.recommend.service;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import trapick.recommend.domain.CourseItemVO;
import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.RestaurantVO;
import trapick.recommend.domain.Selected;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;

public interface RecommendService {

	// public List<LandmarkVO> landMarkList(String city_name);

	// public List<String> cityList(String country_name);

	 public void saveSchedule(String title, List<Selected> landList,
	 List<Selected> itemList, String start_time,
	 String end_time,int user_idx);

	// public double distance(double lat1, double lon1, double lat2, double
	// lon2);

	// public double deg2rad(double deg);

	// public double rad2deg(double rad);

	public Map<String, List<Selected>> getSelectedList(List<Integer> land_idx, List<String> position,
			List<String> item_name, List<String> item_price, List<String> item_detail, List<String> item_image,
			String title, String start_time, String end_time) throws UnsupportedEncodingException;

	public List<CourseItemVO> getCourse(List<String> land_idx, List<String> item_price, List<String> item_name,
			List<String> item_detail, List<String> latitude, List<String> longitude, List<String> position,
			List<String> item_image) throws NumberFormatException, UnsupportedEncodingException;

//	public List<LandmarkVO> recommendLand(String city_name, String base_point);
//
//	public List<ItemVO> recommendItem(String city_name, String base_point);
//
//	public List<HotelVO> recommendHotel(String city_name, String base_point);
//
//	public List<RestaurantVO> recommendRest(String city_name, String base_point);

	// public List<LandmarkVO> userRecommendLand(String city_name, int
	// user_idx);

	public List<LandmarkVO> landMarkList(String city_name);

	public List<String> cityList(String country_name);

	// public void saveSchedule(String title, List<SelectedLandMarkVO> landList,
	// List<SelectedItemVO> itemList,
	// String start_day, String end_day);

	public double distance(double lat1, double lon1, double lat2, double lon2);

	public double deg2rad(double deg);

	public List<LandmarkVO> recommendLand(String city_name, String lat, String lon);

	public List<ItemVO> recommendItem(String city_name, String lat, String lon);

	public List<HotelVO> recommendHotel(String city_name, String lat, String lon);

	// public List<RestaurantVO> recommendRest(String city_name, String lat,
	// String lon);

	public List<LandmarkVO> userRecommendLand(String city_name, int user_idx);

	public double rad2deg(double rad);

}
