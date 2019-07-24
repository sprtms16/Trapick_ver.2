package trapick.mypage.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.mypage.mapper.MyPageMapper;
import trapick.schedule.domain.ScheduleVO;

@Log4j
@Service
@AllArgsConstructor
public class MyPageServiceImpl implements MyPageService {

	private MyPageMapper mapper;
	
	@Override
	public List<ScheduleVO> scheduleList() {
		
		return mapper.scheduleList();
	}

	@Override
	public boolean remove(int schd_idx) {
		
		return mapper.delete(schd_idx) == 1;
	}

}
