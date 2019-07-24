package trapick.recommend.service;

import java.util.List;

import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;

public interface RecommendService {

	   public List<LandmarkVO> landMarkList(String city_name);
	   
	   public List<String> cityList(String country_name);
	   
	   public void saveSchedule(String title, List<SelectedLandMarkVO> landList, List<SelectedItemVO> itemList,String start_day, String end_day);
	   
	   public double distance(double lat1, double lon1, double lat2, double lon2);
	   
	   public double deg2rad(double deg);
	   
	   public  double rad2deg(double rad);
	   
}
