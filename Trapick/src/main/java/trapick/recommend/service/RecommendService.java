package trapick.recommend.service;

import java.util.List;

import trapick.recommend.domain.LandmarkVO;

public interface RecommendService {

	   public List<LandmarkVO> landMarkList(String city_name);
	   
	   public List<String> cityList(String country_name);
	   
	   public void saveSchedule(String title,String schd_idx);
	   
	   public void saveLandMark(String land_idx, String position,String schd_idx);
	   
	   public String schd_idx();
	   
}
