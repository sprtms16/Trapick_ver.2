package trapick.recommend.service;

import java.util.List;

import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.RestaurantVO;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;

public interface RecommendService {

      public List<LandmarkVO> landMarkList(String city_name);
      
      public List<String> cityList(String country_name);
      
      public void saveSchedule(String title, List<SelectedLandMarkVO> landList, List<SelectedItemVO> itemList,String start_day, String end_day);
            
      public double distance(double lat1, double lon1, double lat2, double lon2);
      
       public double deg2rad(double deg);
      
      public List<LandmarkVO> recommendLand(String city_name, String lat, String lon);
      
      public List<ItemVO> recommendItem(String city_name, String lat, String lon);
      
      public List<HotelVO> recommendHotel(String city_name, String lat, String lon);
      
//      public List<RestaurantVO> recommendRest(String city_name, String lat, String lon);
      
      public List<LandmarkVO> userRecommendLand(String city_name, int user_idx);
      
      public List<ItemVO> recommendUserItem(String city_name, String lat, String lon);
      
      public List<HotelVO> recommendUserHotel(String city_name, String lat, String lon);
      
      public  double rad2deg(double rad);
      
}