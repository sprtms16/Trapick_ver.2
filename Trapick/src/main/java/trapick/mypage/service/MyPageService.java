package trapick.mypage.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import trapick.feed.domain.UserVO;
import trapick.schedule.domain.ScheduleVO;

public interface MyPageService {

	public List<ScheduleVO> scheduleList(UserVO userVO);

	public UserVO userInfo(int user_idx);
	
	public boolean updateUserInfo(UserVO userVO);
	   
	public int updateUserImg(UserVO userVO, MultipartFile[] uploadFile, String uploadPath);

	public boolean remove(int schd_idx);

	public boolean share(int user_idx, int schd_idx, int share);

	public List<UserVO> findUser();
	
	public List<ScheduleVO> sharedSchd(int user_idx);
}