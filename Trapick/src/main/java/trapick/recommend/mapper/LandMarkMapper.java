package trapick.recommend.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;

public interface LandMarkMapper {

   public List<LandmarkVO> landMarkList(String city_name);

   public List<String> cityList(String country_name);

   public void saveSchedule(@Param("title") String title, @Param("landList") List<SelectedLandMarkVO> landList,
         @Param("itemList") List<SelectedItemVO> itemList, @Param("start_day") String start_day,
         @Param("end_day") String end_day);

}