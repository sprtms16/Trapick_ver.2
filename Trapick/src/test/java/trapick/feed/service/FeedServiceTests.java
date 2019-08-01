package trapick.feed.service;

import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.Map;

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
public class FeedServiceTests {

	@Setter(onMethod_ = { @Autowired })
	private FeedService service;

	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}

	@Test
	public void testgetList() {
		Map<String, Object> map = new HashMap<>();
		map.put("user_idx", 1);
		service.getList(map).forEach(feed -> log.info(feed));
	}

	@Test
	public void testGet() {
		Map<String, Object> map = new HashMap<>();
		map.put("feed_idx", 62);
		map.put("user_idx", 47);
		log.info(service.getFeed(map));

	}

	@Test
	public void testModify() {
		Map<String, Object> map = new HashMap<>();
		map.put("feed_idx", 62);
		map.put("user_idx", 47);
		FeedVO feed = service.getFeed(map);
		if (feed == null) {
			return;
		}
		feed.setTitle("���� �مf����");
		log.info("Modify result :" + service.modify(feed));
	}

}
