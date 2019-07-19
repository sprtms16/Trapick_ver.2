package trapick.feed.service;

import java.util.List;
import java.util.Map;

import trapick.feed.domain.ReplyDislikeVO;
import trapick.feed.domain.ReplyLikeVO;
import trapick.feed.domain.ReplyVO;

public interface ReplyService {
	public int insertReplyService(ReplyVO vo);

	public List<ReplyVO> replyListService(Map<String, Object> map);

	public int switchingLike(ReplyLikeVO vo);

	public int switchingDislike(ReplyDislikeVO vo);
}
