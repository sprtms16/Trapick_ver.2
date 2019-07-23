package trapick.feed.mapper;

import java.util.List;
import java.util.Map;

import trapick.feed.domain.FeedVO;
import trapick.feed.domain.HeartVO;
import trapick.recommend.domain.SelectedItemVO;

public interface FeedMapper {

	int insertFeed(FeedVO feed);

	List<FeedVO> feedList(Map<String, Object> map);

	FeedVO getFeed(int feed_idx);

	int deleteFeed(int feed_idx);

	int updateFeed(FeedVO feed);

	int selectFeedHeartCount(int feed_idx);

	int selectFeedHeartCheck(HeartVO heart);

	int deleteFeedHeart(HeartVO heart);

	int insertFeedHeart(HeartVO heart);

	List<FeedVO> hashtagList(int feed_idx);

	List<FeedVO> selectMyFeedList(int user_idx);

	List<String> selectFeedUrl(int feed_idx);

	List<FeedVO> selectMySchdList(int user_idx);

	List<SelectedItemVO> selectSchdItemList(int schd_idx);

}
