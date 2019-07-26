package trapick.mypage.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.UserVO;
import trapick.recommend.service.CrawlingServiceTest;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MyPageServiceTests {

	@Setter(onMethod_ = @Autowired)
	private MyPageService service;

	@Test
	public void testGetSchedule() {
		UserVO userVO = new UserVO();
		userVO.setUser_idx(1);
		service.scheduleList(userVO).forEach(schedule -> log.info(schedule));
	}

	@Test
	public void testGetUserInfo() {
		int user_idx = 1;
		log.info(service.userInfo(user_idx));
	}
}
