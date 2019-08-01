package trapick.recommend.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import trapick.recommend.domain.CourseAlgo;
import trapick.recommend.domain.CourseItemVO;
import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.Selected;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;
import trapick.recommend.mapper.LandMarkMapper;
import trapick.recommend.mapper.RecommendMapper;

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

   @Setter(onMethod_ = @Autowired)
   private RecommendMapper mapperRecommend;

   @Override
	public List<LandmarkVO> landMarkList(String city_name) {
		return mapper.landMarkList(city_name);
	}

	@Override
	public List<String> cityList(String country_name) {
		return mapper.cityList(country_name);
	}

	@Override
	public void saveSchedule(String title, List<Selected> landList, List<Selected> itemList, String start_time,
			String end_time,int user_idx) {
		mapper.saveSchedule(title, landList, itemList, start_time, end_time,user_idx);

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

	@Override
	public Map<String, List<Selected>> getSelectedList(List<Integer> land_idx, List<String> position,
			List<String> item_name, List<String> item_price, List<String> item_detail, List<String> item_image,
			String title, String start_time, String end_time) throws UnsupportedEncodingException {
		System.out.println("일정저장시작");
		for (int a = 0; a < item_name.size(); a++) {
			System.out.println(item_name.get(a));
		}
		List<Selected> landList = new ArrayList<>();
		List<Selected> itemList = new ArrayList<>();
		int i = 0;
		int j = 0;
		for (; i + j < item_price.size();) {
			if (item_price.get(i + j).equals("0")) {
				landList.add(new SelectedLandMarkVO(0, land_idx.get(i), position.get(i + j)));
				i++;
			} else {
				itemList.add(new SelectedItemVO(0, URLDecoder.decode(item_name.get(i + j), "UTF-8"),
						URLDecoder.decode(item_detail.get(i + j), "UTF-8"),
						URLDecoder.decode(item_price.get(i + j), "UTF-8"), position.get(i + j),
						URLDecoder.decode(item_image.get(i + j), "UTF-8"), 0));
				j++;
			}
		}
		System.out.println(landList);
		System.out.println(itemList);

		Map<String, List<Selected>> map = new HashMap<>();
		map.put("landList", landList);
		map.put("itemList", itemList);

		return map;
	}

	@Override
	public List<CourseItemVO> getCourse(List<String> land_idx, List<String> item_price, List<String> item_name,
			List<String> item_detail, List<String> latitude, List<String> longitude, List<String> position,
			List<String> item_image) throws NumberFormatException, UnsupportedEncodingException {
		List<CourseItemVO> list = new ArrayList<>();
		int i = 0;
		int j = 0;
		for (; i + j < item_price.size();) {
			if (item_price.get(i + j).equals("0")) {
				list.add(new CourseItemVO(land_idx.get(i), URLDecoder.decode(item_detail.get(i + j), "UTF-8"),
						URLDecoder.decode(item_price.get(i + j), "UTF-8"),
						URLDecoder.decode(item_name.get(i + j), "UTF-8"), Double.parseDouble(latitude.get(i + j)),
						Double.parseDouble(longitude.get(i + j)), position.get(i + j),
						URLDecoder.decode(item_image.get(i + j), "UTF-8")));
				i++;
			} else {
				list.add(new CourseItemVO("0", URLDecoder.decode(item_detail.get(i + j), "UTF-8"),
						URLDecoder.decode(item_price.get(i + j), "UTF-8"),
						URLDecoder.decode(item_name.get(i + j), "UTF-8"), Double.parseDouble(latitude.get(i + j)),
						Double.parseDouble(longitude.get(i + j)), position.get(i + j),
						URLDecoder.decode(item_image.get(i + j), "UTF-8")));
				j++;
			}
		}
		System.out.println(list);

		double dist[][] = new double[item_name.size()][item_name.size()];
		for (int a = 0; a < item_name.size(); a++) {
			for (int b = 0; b < item_name.size(); b++) {
				if (a == b) {
					dist[a][b] = 0;
				} else {
					dist[a][b] = distance(list.get(a).getLatitude(), list.get(a).getLongitude(),
							list.get(b).getLatitude(), list.get(b).getLongitude());
				}
			}
		}

		for (int a = 0; a < item_name.size(); a++) {
			for (int b = 0; b < item_name.size(); b++) {
				System.out.print(dist[a][b] + " ");
			}
			System.out.println();

		}

		CourseAlgo algo = new CourseAlgo(dist.length, dist, new boolean[dist.length], new int[dist.length],
				new int[dist.length], 1000000000);
		algo.tsp(0, 0, 1, dist.length - 1);

		for (int a = 0; a < dist.length; a++) {
			System.out.print(algo.getResult()[a]);
		}
		List<CourseItemVO> resultList = new ArrayList<>();
		for (int a = 0; a < dist.length; a++) {
			resultList.add(list.get(algo.getResult()[a]));
		}
		System.out.println(list);
		System.out.println(resultList);
		return resultList;
	}

   // 4개 추천하기
   // Landmark
   @Override
   public List<LandmarkVO> recommendLand(String city_name, String lat, String lon) {

      List<LandmarkVO> list = serviceSort.landmarkDistSort(mapper.landMarkList(city_name), city_name, lat, lon);

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

      list.remove(0);
      
      for (int i = list.size() - 1; i > 0; i--) {
         list.remove(i);
      }

      return list;
   }

   // item
   @Override
   public List<ItemVO> recommendItem(String city_name, String lat, String lon) {

      List<ItemVO> list = serviceSort.itemDistSort(serviceItem.crawling(city_name,lat, lon));

      for (int i = list.size() - 1; i > 4; i--) {
         list.remove(i);
      }

      serviceSort.itemHitsSort(list);

      for (int i = list.size() - 1; i > 2; i--) {
         list.remove(i);
      }

      serviceSort.itemSalesSort(list);
      
      list.remove(0);

      for (int i = list.size() - 1; i > 0; i--) {
         list.remove(i);
      }

      return list;

   }

   // hotel
   @Override
   public List<HotelVO> recommendHotel(String city_name, String lat, String lon) {

      List<HotelVO> list = serviceSort.hotelDistSort(serviceHotel.crawling(city_name, lat, lon));

      for (int i = list.size() - 1; i > 4; i--) {
         list.remove(i);
      }

      serviceSort.hotelReviewSort(list);

      for (int i = list.size() - 1; i > 2; i--) {
         list.remove(i);
      }

      serviceSort.hotelPriceSort(list);
      
      list.remove(0);

      for (int i = list.size() - 1; i > 0; i--) {
         list.remove(i);
      }

      return list;

   }
/*
   // restaurant
   @Override
   public List<RestaurantVO> recommendRest(String city_name, String lat, String lon) {

      List<RestaurantVO> list = serviceSort.restDistSort(serviceRest.crawling(city_name, lat, lon));

      for (int i = list.size() - 1; i > 0; i--) {
         list.remove(i);
      }

      return list;
   }
*/
   @Override
   public List<LandmarkVO> userRecommendLand(String city_name, int user_idx) {

      List<Integer> temp = new ArrayList<>();
      List<Integer> feeder = new ArrayList<>();
      List<Integer> feed = new ArrayList<>();
      List<Integer> schd_idx = new ArrayList<>();
      List<Integer> wholeLand = new ArrayList<>();
      List<Integer> checkCityList = new ArrayList<>();
      List<LandmarkVO> list = new ArrayList<>();

      feeder = mapperRecommend.findFeeder(user_idx);

      for (int i = 0; i < feeder.size(); i++) {
         temp = mapperRecommend.findFeed(feeder.get(i));
         for (int j = 0; j < temp.size(); j++) {
            feed.add(temp.get(j));
         }
         temp.clear();
      }

      for (int i = 0; i < feed.size(); i++) {
         temp = mapperRecommend.findSchedule(feed.get(i));
         for (int j = 0; j < temp.size(); j++) {
            schd_idx.add(temp.get(j));
         }
         temp.clear();
      }

      for (int i = 0; i < schd_idx.size(); i++) {
         temp = mapperRecommend.findLandmark(schd_idx.get(i));
         for (int j = 0; j < temp.size(); j++) {
            wholeLand.add(temp.get(j));
         }
         temp.clear();
      }
      temp = mapperRecommend.checkCity(city_name);

      for (int i = 0; i < temp.size(); i++) {
         for (int j = 0; j < wholeLand.size(); j++) {
            if (temp.get(i).equals(wholeLand.get(j))) {
               checkCityList.add(wholeLand.get(j));
            }
         }
      }
      
      if(checkCityList.size() == 0){
         List<LandmarkVO> listTemp = mapper.landMarkList(city_name);
         for(int i=0; i<listTemp.size();i++){
            checkCityList.add(listTemp.get(i).getLand_idx());
         }
      }
      
      TreeSet<Integer> ts = new TreeSet<Integer>(checkCityList);
      checkCityList = new ArrayList<Integer>(ts);
      

      for (int i = checkCityList.size() - 1; i > 1; i--) {
         checkCityList.remove(i);
      }
      
      list = mapperRecommend.userRecommendLandmark(checkCityList.get(1));
      return list;
   }
   
   // item
   @Override
   public List<ItemVO> recommendUserItem(String city_name, String lat, String lon) {

      List<ItemVO> list = serviceSort.itemDistSort(serviceItem.crawling(city_name,lat, lon));

      for (int i = list.size() - 1; i > 4; i--) {
         list.remove(i);
      }

      serviceSort.itemHitsSort(list);

      list.remove(0);

      for (int i = list.size() - 1; i > 0; i--) {
         list.remove(i);
      }

      return list;

   }

   // hotel
   @Override
   public List<HotelVO> recommendUserHotel(String city_name, String lat, String lon) {

      List<HotelVO> list = serviceSort.hotelDistSort(serviceHotel.crawling(city_name, lat, lon));

      for (int i = list.size() - 1; i > 4; i--) {
         list.remove(i);
      }

      serviceSort.hotelReviewSort(list);

      list.remove(0);

      for (int i = list.size() - 1; i > 1; i--) {
         list.remove(i);
      }
      
      list.remove(0);

      return list;

   }

}