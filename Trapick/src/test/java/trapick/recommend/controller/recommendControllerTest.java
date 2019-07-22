package trapick.recommend.controller;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.mapper.LandMarkMapper;
import trapick.recommend.service.CrawlingSortingService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class recommendControllerTest {

	@Setter(onMethod_ = @Autowired)
	private LandMarkMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private CrawlingSortingService sort;
	
	@Test
	public void test() {
		List<LandmarkVO> list = mapper.landMarkList("런던");
		for(int i=0; i<list.size();i++){
			log.info(list.get(i));
		}
		
		log.info("=============================================================");
		
		List<LandmarkVO> listsort = sort.landmarkDistSort(list, "런던", "런던아이");
		
		for(int i=0; i<listsort.size();i++){
			log.info(listsort.get(i));
		}
	}

}
