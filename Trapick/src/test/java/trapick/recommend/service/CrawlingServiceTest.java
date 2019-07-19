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
import trapick.schedule.service.ScheduleService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CrawlingServiceTest {

  @Setter(onMethod_ = @Autowired)
   private CrawlingItemServiceImpl serviceItem;
  
  @Setter(onMethod_ = @Autowired)
  private ScheduleService scser;
  
  @Setter(onMethod_ = @Autowired)
  private CrawlingSortingService serviceSort;
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
   
   @Test
   public void dd(){
	  System.out.println( scser.listCountryService());
   }
}