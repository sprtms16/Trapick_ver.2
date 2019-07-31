package trapick.mypage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import trapick.feed.domain.UserVO;
import trapick.schedule.domain.ScheduleVO;

public interface MyPageMapper {

	public List<ScheduleVO> scheduleList(UserVO userVO);

	public List<UserVO> findUser(int user_idx);

	public UserVO userInfo(int user_idx);

	public int updateUserInfo(UserVO userVO);

	public int updateImg(UserVO userVO);

	public int delete(int schd_idx);

	public int shareSchd(@Param("user_idx") int user_idx, @Param("schd_idx") int schd_idx, @Param("sharer") int sharer);

	public List<ScheduleVO> sharedSchd(int user_idx);

}