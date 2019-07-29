package trapick.mypage.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

	@Override
	public UserVO userInfo(int user_idx) {

		return mapper.userInfo(user_idx);
	}

   @Override
   public boolean updateUserInfo(UserVO userVO) {

      return mapper.updateUserInfo(userVO) == 1;
   }
   
   @Override
   public int updateUserImg(UserVO userVO, MultipartFile[] uploadFile, String uploadPath) {
      File dir = new File(uploadPath);
      if (!dir.isDirectory()) {
         dir.mkdir();
      }
      String img_path = null;
      for (MultipartFile multipartFile : uploadFile) {

         File saveFile = new File(uploadPath, multipartFile.getOriginalFilename());
         try {
            multipartFile.transferTo(saveFile);
            img_path = multipartFile.getOriginalFilename();
         } catch (Exception e) {
            e.printStackTrace();
            return -1;
         } finally {
            userVO.setImg_path(img_path);
         
         }
      }
      return mapper.updateImg(userVO);
      
   }
	
	@Override
	public boolean remove(int schd_idx) {

		return mapper.delete(schd_idx) == 1;
	}

	@Override
	public boolean share(int user_idx, int schd_idx, int share) {
		return mapper.shareSchd(user_idx, schd_idx, share) == 1;
	}

	@Override
	public List<UserVO> findUser() {
		return mapper.findUser();
	}

	@Override
	public List<ScheduleVO> sharedSchd(int user_idx){
		
		List<ScheduleVO> listTemp = mapper.sharedSchd(user_idx);
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
		
		List<ScheduleVO> listShare = new ArrayList<ScheduleVO>();
		
		for(int i=0; i<list.size();i++){
			if(!listShare.contains(list.get(i))){
				listShare.add(list.get(i));
			}
		}
		return listShare;
	}
}