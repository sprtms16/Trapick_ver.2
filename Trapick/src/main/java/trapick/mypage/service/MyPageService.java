package trapick.mypage.service;

import java.util.List;

import trapick.schedule.domain.ScheduleVO;

public interface MyPageService {

	public List<ScheduleVO> scheduleList();
	
	public boolean remove(int schd_idx);
}
