package trapick.recommend.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;
import trapick.recommend.mapper.LandMarkMapper;

@Service
public class RecommendServiceImpl implements RecommendService {

	@Setter(onMethod_ = @Autowired)
	private LandMarkMapper mapper;

	@Override
	public List<LandmarkVO> landMarkList(String city_name) {
		return mapper.landMarkList(city_name);
	}

	@Override
	public List<String> cityList(String country_name) {
		return mapper.cityList(country_name);
	}


	@Override
	public void saveSchedule(String title, List<SelectedLandMarkVO> landList, List<SelectedItemVO> itemList,String start_day,String end_day) {
		mapper.saveSchedule(title, landList, itemList,start_day, end_day);
		
	}

	@Override
	public double distance(double lat1, double lon1, double lat2, double lon2) {
		double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
         
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
        dist = dist * 1.609344;
        return dist;
	}

	@Override
	public double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	@Override
	public double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}

		

}