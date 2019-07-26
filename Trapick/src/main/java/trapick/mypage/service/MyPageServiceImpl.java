package trapick.mypage.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.UserVO;
import trapick.mypage.mapper.MyPageMapper;
import trapick.schedule.domain.ScheduleVO;

@Log4j
@Service
@AllArgsConstructor
public class MyPageServiceImpl implements MyPageService {

	private MyPageMapper mapper;

	@Override
	public boolean remove(int schd_idx) {
		
		return mapper.delete(schd_idx) == 1;
	}

	@Override
	public UserVO userInfo(int user_idx) {
		return mapper.userInfo(user_idx);
	}

	@Override
	public List<ScheduleVO> scheduleList(UserVO userVO) {
		return mapper.scheduleList(userVO);
	}


}
