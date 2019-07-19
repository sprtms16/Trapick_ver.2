package trapick.recommend.mapper;


import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.recommend.mapper.LandMarkMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class fsf {
   
   @Setter(onMethod_ = @Autowired)
   private LandMarkMapper mapper;
   
//   @Test
   public void test() {
      log.info(mapper);
      assertNotNull(mapper);
   }
   @Test
   public void test244() {
      mapper.landMarkList("베이징").forEach(list -> log.info(list));
   }
   
//   @Test
   public void test2(){
      mapper.cityList("미국");
   }
//   @Test
   public void test3(){
   }
   
//   @Test

//   @Test
   public void test5(){
      log.info(mapper.schd_idx());
   }
}
