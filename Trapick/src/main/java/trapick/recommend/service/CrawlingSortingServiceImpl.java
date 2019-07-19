package trapick.recommend.service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Service;

import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.RestaurantVO;

@Service
public class CrawlingSortingServiceImpl implements CrawlingSortingService {
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
            if (o1.getDist() > o2.getDist()) {
               return -1;
            } else if (o1.getDist() < o2.getDist()) {
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
			   if(o1.getDist() > o2.getDist()){
				   return -1;
			   }else if(o1.getDist() < o2.getDist()){
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
   
   //star
   @Override
   public List<HotelVO> hotelStarSort(List<HotelVO> list){
	   
	   Collections.sort(list, new Comparator<HotelVO>() {
		   @Override
		   public int compare(HotelVO o1, HotelVO o2){
			   
			   int obj1 = Integer.parseInt(o1.getStars().replace("성급", ""));
			   int obj2 = Integer.parseInt(o2.getStars().replace("성급", ""));
			   
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
			   if(o1.getDist() > o2.getDist()){
				   return -1;
			   }else if(o1.getDist() < o2.getDist()){
				   return 1;
			   }
			   return 0;
		   }
	});
	   return list;
   }
   
   
}