package trapick.recommend.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.RestaurantVO;
import trapick.recommend.mapper.RecommendMapper;

@Service
public class CrawlingSortingServiceImpl implements CrawlingSortingService {
	
	@Setter(onMethod_ = @Autowired)
	private CrawlingCommonService com;
	
	@Setter(onMethod_ = @Autowired)
	private RecommendMapper mapper;
	
	//ITEM
   // 가격순 정렬
   @Override
   public List<ItemVO> itemPriceSort(List<ItemVO> list) {

      Collections.sort(list, new Comparator<ItemVO>() {
         @Override
         public int compare(ItemVO o1, ItemVO o2) {
        	 
        	 String object1 = o1.getPrice().replaceAll(",", "");
        	 object1 = object1.replace("원", "");
        	 int obj1 = Integer.parseInt(object1);
        	 
        	 String object2 = o2.getPrice().replaceAll(",", "");
        	 object2 = object2.replace("원", "");
        	 int obj2 = Integer.parseInt(object2);      
   	 
            if (obj1 < obj2) {
               return -1;
            } else if (obj1 > obj2) {
               return 1;
            }
            return 0;
         }
      });
      return list;
   }

   // 판매량순 정렬
   @Override
   public List<ItemVO> itemSalesSort(List<ItemVO> list) {

      Collections.sort(list, new Comparator<ItemVO>() {
         @Override
         public int compare(ItemVO o1, ItemVO o2) {
            if (o1.getSales() > o2.getSales()) {
               return -1;
            } else if (o1.getSales() < o2.getSales()) {
               return 1;
            }
            return 0;
         }
      });
      return list;
   }

   // 인기순 정렬
   @Override
   public List<ItemVO> itemHitsSort(List<ItemVO> list) {

      Collections.sort(list, new Comparator<ItemVO>() {
         @Override
         public int compare(ItemVO o1, ItemVO o2) {
            if (o1.getHits() > o2.getHits()) {
               return -1;
            } else if (o1.getHits() < o2.getHits()) {
               return 1;
            }
            return 0;
         }
      });
      return list;
   }
   
   //거리순 정렬
   @Override
   public List<ItemVO> itemDistSort(List<ItemVO> list) {

      Collections.sort(list, new Comparator<ItemVO>() {
         @Override
         public int compare(ItemVO o1, ItemVO o2) {
            if (o1.getDist() < o2.getDist()) {
               return -1;
            } else if (o1.getDist() > o2.getDist()) {
               return 1;
            }
            return 0;
         }
      });
      return list;
   }
   
   //Restaurant
   //거리순 정렬
   @Override
   public List<RestaurantVO> restDistSort(List<RestaurantVO> list){
	   
	   Collections.sort(list, new Comparator<RestaurantVO>() {
		   @Override
		   public int compare(RestaurantVO o1, RestaurantVO o2){
			   if(o1.getDist() < o2.getDist()){
				   return -1;
			   }else if(o1.getDist() > o2.getDist()){
				   return 1;
			   }
			   return 0;
		   }
	});
	   return list;
   }
   
   //Hotel
   // 가격순 정렬
   @Override
   public List<HotelVO> hotelPriceSort(List<HotelVO> list) {

      Collections.sort(list, new Comparator<HotelVO>() {
         @Override
         public int compare(HotelVO o1, HotelVO o2) {
        	 
        	 String object1 = o1.getPrice().replaceAll(",", "");
        	 object1 = object1.replace("원", "");
        	 object1 = object1.replace("~", "");
        	 int obj1 = Integer.parseInt(object1);
        	 
        	 String object2 = o2.getPrice().replaceAll(",", "");
        	 object2 = object2.replace("원", "");
        	 object2 = object2.replace("~", "");
        	 int obj2 = Integer.parseInt(object2);      
 
            if (obj1 < obj2) {
               return -1;
            } else if (obj1 > obj2) {
               return 1;
            }
            return 0;
         }
      });
      return list;
   }
   
   //review
   @Override
   public List<HotelVO> hotelReviewSort(List<HotelVO> list){
	   
	   Collections.sort(list, new Comparator<HotelVO>() {
		   @Override
		   public int compare(HotelVO o1, HotelVO o2){
			   
			   double obj1 = Double.valueOf(o1.getReview());
			   double obj2 = Double.valueOf(o2.getReview());
			   
			   if(obj1 > obj2){
				   return -1;
			   }else if(obj1 < obj2){
				   return 1;
			   }
			   return 0;
		   }
	});
	   return list;  
   }

   //거리순 정렬
   @Override
   public List<HotelVO> hotelDistSort(List<HotelVO> list){
	   
	   Collections.sort(list, new Comparator<HotelVO>() {
		   @Override
		   public int compare(HotelVO o1, HotelVO o2){
			   if(o1.getDist() < o2.getDist()){
				   return -1;
			   }else if(o1.getDist() > o2.getDist()){
				   return 1;
			   }
			   return 0;
		   }
	});
	   return list;
   }
   
   //명소
   //거리순
   @Override
	public List<LandmarkVO> landmarkDistSort(List<LandmarkVO> list, String city_name, String lat, String lon) {

		List<Double> listDist = new ArrayList<>();
		List<LandmarkVO> listSort = new ArrayList<>();
		HashMap<Double, Integer> map = new HashMap<>();

		for (int i = 0; i < list.size(); i++) {
			
			listDist.add(com.getDist(Double.toString(list.get(i).getLatitude()), Double.toString(list.get(i).getLongitude()), lat, lon));

		}

		for (int i = 0; i < listDist.size(); i++) {
			map.put(listDist.get(i), list.get(i).getLand_idx());
		}

		TreeMap<Double, Integer> tm = new TreeMap<Double, Integer>(map);
		Iterator<Double> iteratorKey = tm.keySet().iterator();
		
		while (iteratorKey.hasNext()) {
			Double key = iteratorKey.next();

			for (int i = 0; i < list.size(); i++) {
				if (tm.get(key) == list.get(i).getLand_idx()) {
					listSort.add(list.get(i));
				}
			}
		}

		return listSort;

	}

}