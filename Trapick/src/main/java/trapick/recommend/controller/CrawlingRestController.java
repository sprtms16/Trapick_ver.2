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
import trapick.recommend.service.CrawlingHotelServiceImpl;
import trapick.recommend.service.CrawlingItemServiceImpl;
import trapick.recommend.service.CrawlingRestServiceImpl;
import trapick.recommend.service.CrawlingSortingService;
import trapick.recommend.service.RecommendService;

@RestController
@RequestMapping("Rest/recommend")
@AllArgsConstructor
public class CrawlingRestController {

	private CrawlingItemServiceImpl serviceItem;
	private CrawlingHotelServiceImpl serviceHotel;
	private CrawlingRestServiceImpl serviceRest;
	private RecommendService recommedService;
	private CrawlingSortingService serviceSort;

	//첫화면
	@RequestMapping("itemAjax")
	public List<ItemVO> itemAjax(@RequestParam("city_name") String city_name) {
		return serviceItem.crawling(city_name, "", "");
	}

	@RequestMapping("hotelAjax")
	public List<HotelVO> hotelAjax(@RequestParam("city_name") String city_name) {

		return serviceHotel.crawling(city_name, "", "");
	}

	@RequestMapping("restAjax")
	public List<RestaurantVO> restAjax(@RequestParam("city_name") String city_name) {

		return serviceRest.crawling(city_name, "", "");
	}

	//item 정렬
	@RequestMapping("/itemPriceSort")
	public List<ItemVO> itemPriceSort(@RequestParam("city_name") String city_name) {
		return serviceSort.itemPriceSort(serviceItem.crawling(city_name, "", ""));
	}

	@RequestMapping("/itemSalesSort")
	public List<ItemVO> itemSalesSort(@RequestParam("city_name") String city_name) {
		return serviceSort.itemSalesSort(serviceItem.crawling(city_name, "", ""));
	}

	@RequestMapping("/itemHitsSort")
	public List<ItemVO> itemHitsSort(@RequestParam("city_name") String city_name) {
		return serviceSort.itemHitsSort(serviceItem.crawling(city_name, "", ""));
	}
	
	//hotel 정렬
	@RequestMapping("/hotelPriceSort")
	public List<HotelVO> hotelPriceSort(@RequestParam("city_name") String city_name) {
		return serviceSort.hotelPriceSort(serviceHotel.crawling(city_name, "",""));
	}

	@RequestMapping("/hotelReviewSort")
	public List<HotelVO> hotelStarSort(@RequestParam("city_name") String city_name) {
		return serviceSort.hotelReviewSort(serviceHotel.crawling(city_name, "",""));
	}
	
	//명소 정렬
	@RequestMapping("/landmarkHitsSort")
	public List<LandmarkVO> landmarkHitsSort(@RequestParam("city_name") String city_name) {
		return recommedService.landMarkList(city_name);
	}

	//거리순 정렬
	@RequestMapping("/hotelDistSort")
	public List<HotelVO> hotelDistSort(@RequestParam("city_name") String city_name,  @RequestParam("lat") String lat, @RequestParam("lon") String lon) {
		return serviceSort.hotelDistSort(serviceHotel.crawling(city_name, lat, lon));
	}
	
	@RequestMapping("/landmarkDistSort")
	public List<LandmarkVO> landmarkDistSort(@RequestParam("city_name") String city_name, @RequestParam("lat") String lat, @RequestParam("lon") String lon) {
		return serviceSort.landmarkDistSort(recommedService.landMarkList(city_name), city_name, lat, lon);
	}

	@RequestMapping("/itemDistSort")
	public List<ItemVO> itemDistSort(@RequestParam("city_name") String city_name, @RequestParam("lat") String lat, @RequestParam("lon") String lon) {
		return serviceSort.itemDistSort(serviceItem.crawling(city_name, lat, lon));
	}

	
	//4개 추천
	@RequestMapping("/landmarkRecommend")
	public List<LandmarkVO> landmarkRecommend(@RequestParam("city_name") String city_name, @RequestParam("lat") String lat, @RequestParam("lon") String lon) {
		return recommedService.recommendLand(city_name, lat, lon);
	}

	@RequestMapping("/itemRecommend")
	public List<ItemVO> itemRecommend(@RequestParam("city_name") String city_name, @RequestParam("lat") String lat, @RequestParam("lon") String lon) {
		return recommedService.recommendItem(city_name, lat, lon);
	}

	@RequestMapping("/hotelRecommend")
	public List<HotelVO> hotelRecommend(@RequestParam("city_name") String city_name, @RequestParam("lat") String lat, @RequestParam("lon") String lon) {
		return recommedService.recommendHotel(city_name, lat, lon);
	}

	//사용자 기반 추천
	@RequestMapping("/landmarkUserRecommend")
	public List<LandmarkVO> landmarkUserRecommend(String city_name, @RequestParam("user_idx") int user_idx) {
		return recommedService.userRecommendLand(city_name, 2); // user idx 대신
																// 2로함
	}

	@RequestMapping("/itemUserRecommend")
	public List<ItemVO> itemUserRecommend(String city_name, int user_idx) {
		List<LandmarkVO> list = recommedService.userRecommendLand(city_name, user_idx);
		return recommedService.recommendItem(city_name, Double.toString(list.get(0).getLatitude()), Double.toString(list.get(0).getLongitude()));
	}

	@RequestMapping("/hotelUserRecommend")
	public List<HotelVO> hotelUserRecommend(String city_name, @RequestParam("user_idx") int user_idx) {
		List<LandmarkVO> list = recommedService.userRecommendLand(city_name, user_idx);
		return recommedService.recommendHotel(city_name, Double.toString(list.get(0).getLatitude()), Double.toString(list.get(0).getLongitude()));
	}
	
	/*
	@RequestMapping("/restDistSort")
	public List<RestaurantVO> restDistSort(@RequestParam("city_name") String city_name, @RequestParam("latitude") String lat, @RequestParam("longitude") String lon) {
		return serviceSort.restDistSort(serviceRest.crawling(city_name, lat, lon));
	}

	@RequestMapping("restHitsSort")
	public List<RestaurantVO> restHitsSort(@RequestParam("city_name") String city_name) {
		return serviceRest.crawling(city_name, "");
	}
	
	@RequestMapping("/restRecommend")
	public List<RestaurantVO> restRecommend(@RequestParam("city_name") String city_name, @RequestParam("latitude") String lat, @RequestParam("longitude") String lon) {
		return recommedService.recommendRest(city_name, lat, lon);
	}
	
	@RequestMapping("/restUserRecommend")
	public List<RestaurantVO> restUserRecommend(String city_name, int user_idx) {
		return recommedService.recommendRest(city_name,
				recommedService.userRecommendLand(city_name, user_idx).get(0).getName());
	}
	 */

}