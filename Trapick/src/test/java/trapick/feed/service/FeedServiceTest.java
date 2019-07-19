package trapick.feed.service;

import java.util.HashMap;
import java.util.Map;

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
public class FeedServiceTest {
	@Setter(onMethod_ = { @Autowired })
	private FeedService service;

	@Test
	public void testExist() {
		Map<String, Object> map = new HashMap<>();
		map.put("user_idx", 1);
		service.getList(map).forEach(feed -> log.info(feed));
	}

}
