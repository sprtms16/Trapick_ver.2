package trapick.feed.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.FeedVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FeedMapperTests {
	
	@Setter(onMethod_= @Autowired)
	private FeedMapper mapper;
	
	//@Test
	public void testDelete(){
		log.info("delete count:" + mapper.deleteFeed(61));
	}
	
	@Test
	public void testUpdate(){
		FeedVO feed = new FeedVO();
	
	
		feed.setTitle("수정제목");
		feed.setContents("수정쓰"); 
		feed.setFeed_idx(62);
		
		log.info("update count:" + mapper.updateFeed(feed));
		
		
		
		
	
	}

}
