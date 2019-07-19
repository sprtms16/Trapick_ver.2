package trapick.schedule.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class ScheduleMapperTests {

   @Setter(onMethod_ = @Autowired)
   private ScheduleMapper mapper;
   
 @Test
   public void testGetCountryName(){
      
      log.info("getCountryName");
      log.info(mapper.country_name());
   }
     /*
   @Test
   public void testGetCityName(){
      
      log.info("getCityName");
      log.info(scheduleMapper.city_name());
   }
   
   @Test
   public void testGetCountryIso(){
      log.info("getCountryIso");
      log.info(scheduleMapper.country_iso("미국"));
   }
   
   @Test
   public void testGetCityEname(){
      log.info("getCityEname");
      log.info(scheduleMapper.city_ename("홍콩"));
   }*/
}