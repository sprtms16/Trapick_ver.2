package trapick.mypage.mapper;

import java.util.List;

import trapick.feed.domain.UserVO;
import trapick.schedule.domain.ScheduleVO;

public interface MyPageMapper {

	public List<ScheduleVO> scheduleList(UserVO userVO);
	
	public UserVO userInfo(int user_idx);
	
	public int updateUserInfo(UserVO userVO);
	
	public int delete(int schd_idx);
	
}
