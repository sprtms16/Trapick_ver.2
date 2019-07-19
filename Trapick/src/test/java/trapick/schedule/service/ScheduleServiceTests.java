package trapick.schedule.service;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ScheduleServiceTests {

   @Setter(onMethod_= {@Autowired})
   private ScheduleService service;
   
/*   @Test
   public void testExist(){
      
      log.info(service);
      assertNotNull(service);
   }
   
   @Test
   public void testGetList(){
      service.listCountryService();
   }
   
   @Test
   public void testGetIsoList(){
      service.countryIsoService("미국");
   }

   @Test
   public void testGetEname(){
      service.cityEnameService("홍콩");
   }*/
}