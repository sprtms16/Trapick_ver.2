package trapick.recommend.service;

import java.util.List;

import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.RestaurantVO;

public interface CrawlingSortingService {

   public List<ItemVO> itemPriceSort(List<ItemVO> list);

   public List<ItemVO> itemSalesSort(List<ItemVO> list);

   public List<ItemVO> itemHitsSort(List<ItemVO> list);
   
   public List<ItemVO> itemDistSort(List<ItemVO> list);
   
   public List<RestaurantVO> restDistSort(List<RestaurantVO> list);
   
   public List<HotelVO> hotelPriceSort(List<HotelVO> list);
   
   public List<HotelVO> hotelReviewSort(List<HotelVO> list);
   
// public List<HotelVO> hotelStarSort(List<HotelVO> list);
   
   public List<HotelVO> hotelDistSort(List<HotelVO> list);
   
   public List<LandmarkVO> landmarkDistSort(List<LandmarkVO> list, String city_name, String lat, String lon);
}