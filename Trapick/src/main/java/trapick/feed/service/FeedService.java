package trapick.feed.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import trapick.feed.domain.FeedVO;
import trapick.feed.domain.HeartVO;
import trapick.feed.domain.SubscribeVO;
import trapick.feed.domain.UserVO;
import trapick.recommend.domain.SelectedItemVO;

public interface FeedService {

	public boolean modify(FeedVO feed);

	public boolean remove(int feed_idx);

	public List<FeedVO> getList(Map<String, Object> map);

	public FeedVO getFeed(int feed_idx);

	public int switchingHeart(HeartVO vo);

	public int insertFeed(FeedVO vo, MultipartFile[] uploadFile, String uploadPath);

	public List<String> selectFeedUrl(int feed_idx);
	
	public int switchingSubscribe(SubscribeVO sb);

	public List<SelectedItemVO> getSelectedItem(int schd_idx);
	
	public int join(UserVO user);

}
