package trapick.feed.mapper;

import java.util.List;
import java.util.Map;

import trapick.feed.domain.ReplyDislikeVO;
import trapick.feed.domain.ReplyLikeVO;
import trapick.feed.domain.ReplyVO;

public interface ReplyMapper {

	int insertReply(ReplyVO reply);

	List<ReplyVO> listReply(Map<String, Object> param);

	int updateReplyLike(ReplyLikeVO replyLike);

	int updateReplyDislike(ReplyDislikeVO replyDislike);

	int selectReplyLikeCheck(ReplyLikeVO replyLike);

	int deleteReplyLike(ReplyLikeVO replyLike);

	int selectReplyLikeCount(int reply_idx);

	int insertReplyLike(ReplyLikeVO replyLike);

	int selectReplyDislikeCheck(ReplyDislikeVO replyDislike);

	int deleteReplyDislike(ReplyDislikeVO replyDislike);

	int selectReplyDislikeCount(int reply_idx);

	int insertReplyDislike(ReplyDislikeVO replyDislike);
}
