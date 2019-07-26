package trapick.mypage.service;

import java.util.ArrayList;
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
	public boolean updateUserInfo(UserVO userVO) {
		
		return mapper.updateUserInfo(userVO) == 1;
	}

	@Override
	public List<ScheduleVO> scheduleList(UserVO userVO) {

		List<ScheduleVO> listTemp = mapper.scheduleList(userVO);
		List<ScheduleVO> list = new ArrayList<ScheduleVO>();

		String tempStart = null;
		String tempEnd = null;

		for (int i = 0; i < listTemp.size(); i++) {

			tempStart = listTemp.get(i).getSchd_start().substring(0, 10);
			tempEnd = listTemp.get(i).getSchd_end().substring(0, 10);

			ScheduleVO vo = new ScheduleVO(listTemp.get(i).getSchd_idx(), listTemp.get(i).getTitle(), tempStart,
					tempEnd, listTemp.get(i).getUser_idx(), listTemp.get(i).getSelectedLandmarkds(),
					listTemp.get(i).getSelectedItems());

			list.add(vo);
		}

		return list;

	}


}
