package trapick.mypage.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.UserVO;
import trapick.recommend.service.CrawlingServiceTest;
import trapick.schedule.domain.ScheduleVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MyPageServiceTests {

	@Setter(onMethod_ = @Autowired)
	private MyPageService service;
/*
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
	
*/
	
	@Test
	public void test(){
		List<ScheduleVO> list = service.sharedSchd(2);
		List<UserVO> listSh = service.sharer(2);
		
		for(int i=0; i<list.size();i++){
			log.info(list.get(i)+"공유자" + listSh.get(i).getId());
		}
		
		
		
	}
}
