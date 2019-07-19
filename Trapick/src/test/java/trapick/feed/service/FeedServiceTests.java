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
		log.info(service.getFeed(62));

	}

	@Test
	public void testModify() {
		FeedVO feed = service.getFeed(62);
		if (feed == null) {
			return;
		}
		feed.setTitle("제목 바꿧따리");
		log.info("Modify result :" + service.modify(feed));
	}

}
