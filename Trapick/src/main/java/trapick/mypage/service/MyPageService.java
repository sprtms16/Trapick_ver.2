package trapick.mypage.service;

import java.util.List;

import trapick.feed.domain.UserVO;
import trapick.schedule.domain.ScheduleVO;

public interface MyPageService {

<<<<<<< HEAD
   public List<ScheduleVO> scheduleList(UserVO userVO);
   
   public UserVO userInfo(int user_idx);
   
   public boolean remove(int schd_idx);
   
   public boolean share(int user_idx, int schd_idx, int share);
   
   public List<UserVO> findUser();
}
=======
	public List<ScheduleVO> scheduleList(UserVO userVO);

	public UserVO userInfo(int user_idx);

	public boolean remove(int schd_idx);

	public boolean share(int user_idx, int schd_idx, int share);

	public List<UserVO> findUser();
}
>>>>>>> branch 'master' of https://github.com/sprtms16/Trapick_ver.2.git
