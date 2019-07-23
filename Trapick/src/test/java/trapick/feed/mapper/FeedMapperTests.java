package trapick.feed.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.FeedVO;
import trapick.recommend.domain.SelectedItemVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FeedMapperTests {

	@Setter(onMethod_ = @Autowired)
	private FeedMapper mapper;

	// @Test
	public void testDelete() {
		log.info("delete count:" + mapper.deleteFeed(61));
	}

	// @Test
	public void testUpdate() {
		FeedVO feed = new FeedVO();

		feed.setTitle("��������");
		feed.setContents("������");
		feed.setFeed_idx(62);

		log.info("update count:" + mapper.updateFeed(feed));

	}

	@Test
	public void scheduleMapperTests() {
		int schd_idx = 29;
		List<SelectedItemVO> itemVOs = mapper.selectSchdItemList(schd_idx);
		itemVOs.forEach(item -> log.info(item));
	}

}
