package trapick.recommend.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import trapick.recommend.domain.LandmarkVO;
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

	@Transactional
	@Override
	public void saveSchedule(String title,String schd_idx) {
		mapper.saveSchedule(title,schd_idx);

	}

	@Override
	public void saveLandMark(String land_idx, String position, String schd_idx) {
		mapper.saveLandMark(land_idx, position,schd_idx);
		
	}

	@Override
	public String schd_idx() {
		
		return mapper.schd_idx();
	}

}