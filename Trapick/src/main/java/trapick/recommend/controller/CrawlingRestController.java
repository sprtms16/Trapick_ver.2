package trapick.recommend.controller;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.RestaurantVO;
import trapick.recommend.mapper.LandMarkMapper;
import trapick.recommend.service.CrawlingHotelServiceImpl;
import trapick.recommend.service.CrawlingItemServiceImpl;
import trapick.recommend.service.CrawlingRestServiceImpl;
import trapick.recommend.service.CrawlingSortingService;
import trapick.recommend.service.RecommendService;

@RestController
@RequestMapping("recommend")
@AllArgsConstructor
public class CrawlingRestController {

   private CrawlingItemServiceImpl serviceItem;
   private CrawlingHotelServiceImpl serviceHotel;
   private CrawlingRestServiceImpl serviceRest;
   private RecommendService recommedService;
   private CrawlingSortingService serviceSort;

   @RequestMapping("itemAjax")
   public List<ItemVO> itemAjax(@RequestParam("city_name") String city_name) {
      return serviceItem.crawling(city_name, ""); //base point 파라미터 필요
   }

   @RequestMapping("hotelAjax")
   public List<HotelVO> hotelAjax(@RequestParam("city_name") String city_name) {

      return serviceHotel.crawling(city_name, "");
   }

   @RequestMapping("restAjax")
   public List<RestaurantVO> restAjax(@RequestParam("city_name") String city_name) {

      return serviceRest.crawling(city_name, "");
   }
 
   @RequestMapping("/itemPriceSort")
   public List<ItemVO> itemPriceSort(@RequestParam("city_name") String city_name){
	   return serviceSort.itemPriceSort(serviceItem.crawling(city_name,"")); //base point 파라미터 필요
   }
   
   @RequestMapping("/itemSalesSort")
   public List<ItemVO> itemSalesSort(@RequestParam("city_name") String city_name){
	   return serviceSort.itemSalesSort(serviceItem.crawling(city_name, ""));  //base point 파라미터 필요
   }

   @RequestMapping("/itemHitsSort")
   public List<ItemVO> itemHitsSort(@RequestParam("city_name") String city_name){
	   return serviceSort.itemHitsSort(serviceItem.crawling(city_name, ""));  //base point 파라미터 필요
   }
   
   @RequestMapping("/itemDistSort")
   public List<ItemVO> itemDistSort(@RequestParam("city_name") String city_name, @RequestParam("name") String name){
	   return serviceSort.itemDistSort(serviceItem.crawling(city_name, name));  
   }
   
   @RequestMapping("/restDistSort")
   public List<RestaurantVO> restDistSort(@RequestParam("city_name") String city_name, @RequestParam("name") String name){
	   System.out.println(name);
	   return serviceSort.restDistSort(serviceRest.crawling(city_name, name));
   }
   
   @RequestMapping("restHitsSort")
   public List<RestaurantVO> restHitsSort(@RequestParam("city_name") String city_name){
	   return serviceRest.crawling(city_name, "");
   }
   
   @RequestMapping("/hotelPriceSort")
   public List<HotelVO> hotelPriceSort(@RequestParam("city_name") String city_name){
	   return serviceSort.hotelPriceSort(serviceHotel.crawling(city_name, "")); //base point 파라미터 필요
   }
   
   @RequestMapping("/hotelStarSort")
   public List<HotelVO> hotelStarSort(@RequestParam("city_name") String city_name){
	   return serviceSort.hotelStarSort(serviceHotel.crawling(city_name, "")); //base point 파라미터 필요
   }
   
   @RequestMapping("/hotelDistSort")
   public List<HotelVO> hotelDistSort(@RequestParam("city_name") String city_name, @RequestParam("name") String name){
	   System.out.println(name);
	   return serviceSort.hotelDistSort(serviceHotel.crawling(city_name, name)); //base point 파라미터 필요
   }

   @RequestMapping("/landmarkDistSort")
   public List<LandmarkVO> landmarkDistSort(@RequestParam("city_name") String city_name, @RequestParam("name") String name){
	   return serviceSort.landmarkDistSort(recommedService.landMarkList(city_name), city_name, name);
   }
   
   @RequestMapping("/landmarkHitsSort")
   public List<LandmarkVO> landmarkHitsSort(@RequestParam("city_name") String city_name){
	   return recommedService.landMarkList(city_name);
   }
   
   
}