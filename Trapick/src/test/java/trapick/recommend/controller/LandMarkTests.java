package trapick.recommend.controller;


import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.recommend.mapper.LandMarkMapper;
import trapick.schedule.mapper.ScheduleMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LandMarkTests {
   
   @Setter(onMethod_ = @Autowired)
   private ScheduleMapper mapper;
   
//   @Test
   public void test() {
      log.info(mapper);
      assertNotNull(mapper);
   }
   
   @Test
   public void test2() {
	   System.out.println(mapper.country_name());
   }
}