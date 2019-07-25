package trapick.recommend.mapper;


import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;


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
//   @Test
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
   }
   
   @Test
   public void testt(){
	   List<SelectedLandMarkVO> landList = new ArrayList<>();
	   List<SelectedItemVO> itemList = new ArrayList<>();
	   landList.add(new SelectedLandMarkVO(0,1,"2-1"));
	   landList.add(new SelectedLandMarkVO(0,2,"2-2"));
	   itemList.add(new SelectedItemVO(1,"이름","디테일","가격","1-1","이미지",0));
	   itemList.add(new SelectedItemVO(2,"이름2","디테일2","가격2","1-2","이미지2",0));
   }
}
