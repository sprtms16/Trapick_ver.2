package trapick.recommend.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.recommend.domain.HotelVO;
import trapick.recommend.domain.ItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.RestaurantVO;
import trapick.recommend.mapper.LandMarkMapper;
import trapick.schedule.service.ScheduleService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CrawlingServiceTest {

  @Setter(onMethod_ = @Autowired)
   private CrawlingItemServiceImpl serviceItem;
  
  @Setter(onMethod_ = @Autowired)
  private CrawlingRestServiceImpl serviceRest;

  @Setter(onMethod_ = @Autowired)
  private CrawlingHotelServiceImpl serviceHotel;
  
  @Setter(onMethod_ = @Autowired)
  private ScheduleService scser;
  
  @Setter(onMethod_ = @Autowired)
  private LandMarkMapper mapperLandmark;
  
  @Setter(onMethod_ = @Autowired)
  private CrawlingSortingService serviceSort;
  
  @Setter(onMethod_ = @Autowired)
  private RecommendService serviceRecommend;
/*   
   @Setter(onMethod_ = @Autowired)
   private CrawlingRestService serviceRest;
   */
/*   
   @Test
   public void testItemCrwaling(){
      List<ItemVO> list = service.itemCrawling("홍콩");
      log.info("----------------------------------------Item----------------------------------------");
      log.info(list);
   }
   */

//   @Test
   public void testHotelCrwaling(){
      List<ItemVO> list = serviceItem.crawling("런던", "");
/*      for(int i= 0; i<list.size(); i++){
    	  log.info(list.get(i));  
      }*/
   }
   
/*
   @Test
   public void testRestCrwaling(){
      List<RestaurantVO> list = service.restCrawling("홍콩");
      log.info("----------------------------------------Rest----------------------------------------");
      log.info(list);
   }
*/
   /*
   @Test
   public void testItemPrice(){
	   List<HotelVO> list = serviceHotel.crawling("런던", "");
	   for(int i=0; i<list.size(); i++){
		   log.info(list.get(i));
	   }
	   List<HotelVO> listSort = serviceSort.hotelPriceSort(list);

	   log.info("==============================================================================");
	   for(int i=0; i<list.size();i++){
		   log.info(listSort.get(i));
	   }
	   
   }
   */
   /*
   @Test
   public void testLandmark(){
	   List<LandmarkVO> list = mapperLandmark.landMarkList("런던");
	   log.info("==================================기존=====================================");

	   for(int i=0; i<list.size(); i++){
		   log.info(list.get(i));
	   }
	   List<LandmarkVO> listSort = serviceSort.landmarkDistSort(list, "런던", "런던아이");
	   
	   log.info("================================변경=======================================");
	   for(int i=0; i<listSort.size();i++){
		   log.info(listSort.get(i));
		   
	   }
   }
   */
   /*
   @Test
   public void test(){
	   List<LandmarkVO> list = serviceRecommend.recommendLand("런던", "런던아이");
	   
	   log.info(list);
	   
   }
   */
   /*
   @Test
   public void test(){
	   ItemVO vo = serviceRecommend.recommendItem("런던", "런던아이");
	   log.info(vo);
   }
   
   */
   /*
   @Test
   public void test(){
	   HotelVO vo = serviceRecommend.recommendHotel("런던", "런던아이");
	   log.info(vo);
   }
   */
  
   @Test
   public void test(){
	   List<RestaurantVO> vo = serviceRecommend.recommendRest("런던", "런던아이");
	   log.info(vo);
   }

   
   
   
   
   
   
   
   
}