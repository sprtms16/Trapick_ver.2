package trapick.recommend.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import trapick.recommend.domain.LandmarkVO;

public interface LandMarkMapper {

   public List<LandmarkVO> landMarkList(String city_name);
   
   public List<String> cityList(String country_name);
   
   public void saveSchedule(@Param("title") String title, @Param("schd_idx") String schd_idx);
   
   public void saveLandMark(@Param("land_idx") String land_idx, @Param("position") String position, @Param("schd_idx") String schd_idx);
   
   public String schd_idx();
   
}