package trapick.feed.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.FeedVO;
import trapick.feed.domain.HeartVO;
import trapick.feed.domain.SubscribeVO;
import trapick.feed.domain.UserVO;
import trapick.feed.mapper.FeedMapper;
import trapick.recommend.domain.SelectedItemVO;

@Log4j
@Service
@AllArgsConstructor
public class FeedServiceImpl implements FeedService {

	private FeedMapper mapper;

	@Override
	public boolean modify(FeedVO feed) {
		log.info("modify..." + feed);
		return mapper.updateFeed(feed) == 1;
	}

	@Override
	public boolean remove(int feed_idx) {
		log.info("delete... + feed");
		return mapper.deleteFeed(feed_idx) == 1;
	}

	@Override
	public List<FeedVO> getList(Map<String, Object> map) {
		return mapper.feedList(map);
	}

	@Override
	public FeedVO getFeed(int feed_idx) {
		return mapper.getFeed(feed_idx);
	}

	@Override
	public int switchingHeart(HeartVO vo) {
		if (mapper.selectFeedHeartCheck(vo) >= 1)
			mapper.deleteFeedHeart(vo);
		else
			mapper.insertFeedHeart(vo);
		return mapper.selectFeedHeartCount(vo.getFeed_idx());
	}

	@Override
	public int insertFeed(FeedVO vo, MultipartFile[] uploadFile, String uploadPath) {
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {
			dir.mkdir();
		}
		List<String> url = new ArrayList<>();
		for (MultipartFile multipartFile : uploadFile) {
			log.info("==========================================");
			log.info("Upload FIle Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());

			File saveFile = new File(uploadPath, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
				url.add(multipartFile.getOriginalFilename());
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				vo.setUrl(url);
			}
		}
		return mapper.insertFeed(vo);
	}

	@Override
	public List<String> selectFeedUrl(int feed_idx) {
		return mapper.selectFeedUrl(feed_idx);
	}

	@Override
	public int switchingSubscribe(SubscribeVO sb) {
		if(mapper.selectSubscriberCheck(sb)>=1){
			mapper.deleteSubscribe(sb);
		}else{
		mapper.addSubscriber(sb);
		}
		return mapper.selectSubscriberCount(sb.getFeeder());
	}

	@Override
	public List<SelectedItemVO> getSelectedItem(int schd_idx) {
		return mapper.selectSchdItemList(schd_idx);
	}

	@Override
	public int join(UserVO user) {
		// TODO Auto-generated method stub
		return mapper.joinTrapick(user);
	}

}
