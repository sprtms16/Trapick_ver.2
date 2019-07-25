package trapick.recommend.mapper;

import java.util.List;

import trapick.recommend.domain.LandmarkVO;

public interface RecommendMapper {
	
	public List<Integer> findFeeder(int user_idx);
	
	public List<Integer> findFeed(int feeder);
	
	public List<Integer> findSchedule(int feed_idx);
	
	public List<Integer> findLandmark(int schd_idx);
	
	public List<Integer> checkCity(String city_name);
	
	public List<LandmarkVO> userRecommendLandmark(int land_idx);

}
