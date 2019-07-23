package trapick.recommend.service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.RestaurantVO;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;
import trapick.recommend.mapper.LandMarkMapper;

@Service
public class RecommendServiceImpl implements RecommendService {

	@Setter(onMethod_ = @Autowired)
	private LandMarkMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private CrawlingItemServiceImpl serviceItem;

	@Setter(onMethod_ = @Autowired)
	private CrawlingHotelServiceImpl serviceHotel;

	@Setter(onMethod_ = @Autowired)
	private CrawlingRestServiceImpl serviceRest;

	@Setter(onMethod_ = @Autowired)
	private CrawlingSortingService serviceSort;

	@Override
	public List<LandmarkVO> landMarkList(String city_name) {
		return mapper.landMarkList(city_name);
	}

	@Override
	public List<String> cityList(String country_name) {
		return mapper.cityList(country_name);
	}

	@Override
	public void saveSchedule(String title, List<SelectedLandMarkVO> landList, List<SelectedItemVO> itemList,
			String start_day, String end_day) {
		mapper.saveSchedule(title, landList, itemList, start_day, end_day);

	}

	@Override
	public double distance(double lat1, double lon1, double lat2, double lon2) {
		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2))
				+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));

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

	// 4개 추천하기
	// Landmark
	@Override
	public List<LandmarkVO> recommendLand(String city_name, String base_point) {

		List<LandmarkVO> list = serviceSort.landmarkDistSort(mapper.landMarkList(city_name), city_name, base_point);

		for (int i = list.size() - 1; i > 2; i--) {
			list.remove(i);
		}

		Collections.sort(list, new Comparator<LandmarkVO>() {
			@Override
			public int compare(LandmarkVO o1, LandmarkVO o2) {
				if (o1.getLand_idx() < o2.getLand_idx()) {
					return -1;
				} else if (o1.getLand_idx() > o2.getLand_idx()) {
					return 1;
				}
				return 0;
			}
		});

		for (int i = list.size() - 1; i > 0; i--) {
			list.remove(i);
		}

		return list;
	}

	// item
	@Override
	public List<ItemVO> recommendItem(String city_name, String base_point) {

		List<ItemVO> list = serviceSort.itemDistSort(serviceItem.crawling(city_name, base_point));

		for (int i = list.size() - 1; i > 4; i--) {
			list.remove(i);
		}

		serviceSort.itemHitsSort(list);

		for (int i = list.size() - 1; i > 2; i--) {
			list.remove(i);
		}

		serviceSort.itemSalesSort(list);

		for (int i = list.size() - 1; i > 0; i--) {
			list.remove(i);
		}

		return list;

	}

	// hotel
	@Override
	public List<HotelVO> recommendHotel(String city_name, String base_point) {

		List<HotelVO> list = serviceSort.hotelDistSort(serviceHotel.crawling(city_name, base_point));

		for (int i = list.size() - 1; i > 4; i--) {
			list.remove(i);
		}

		serviceSort.hotelReviewSort(list);

		for (int i = list.size() - 1; i > 2; i--) {
			list.remove(i);
		}

		serviceSort.hotelPriceSort(list);

		for (int i = list.size() - 1; i > 0; i--) {
			list.remove(i);
		}

		return list;

	}

	// restaurant
	@Override
	public List<RestaurantVO> recommendRest(String city_name, String base_point) {

		List<RestaurantVO> list = serviceSort.restDistSort(serviceRest.crawling(city_name, base_point));

		for (int i = list.size() - 1; i > 0; i--) {
			list.remove(i);
		}

		return list;
	}

}