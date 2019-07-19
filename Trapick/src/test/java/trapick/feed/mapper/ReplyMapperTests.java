package trapick.feed.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.ReplyVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Test
	public void testMapper() {
		log.info(mapper);
	}

	@Test
	public void testInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setFeed_idx(64);
		vo.setContents("������");
		vo.setUser_idx(1);

		mapper.insertReply(vo);
	}

	@Test
	public void testList() {
		Map<String, Object> map = new HashMap<>();
		map.put("feed_idx", 64);
		map.put("user_idx", 1);
		List<ReplyVO> replies = mapper.listReply(map);
		replies.forEach(reply -> log.info(reply));
	}
}
