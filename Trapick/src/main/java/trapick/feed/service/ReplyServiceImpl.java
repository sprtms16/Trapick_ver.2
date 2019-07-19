package trapick.feed.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.feed.domain.ReplyDislikeVO;
import trapick.feed.domain.ReplyLikeVO;
import trapick.feed.domain.ReplyVO;
import trapick.feed.mapper.ReplyMapper;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Override
	public int insertReplyService(ReplyVO vo) {
		log.info("insertReplyService");
		return mapper.insertReply(vo);
	}

	@Override
	public List<ReplyVO> replyListService(Map<String, Object> map) {
		log.info("replyListService");
		return mapper.listReply(map);
	}

	@Override
	public int switchingLike(ReplyLikeVO vo) {
		log.info("switchingLike");
		if (mapper.selectReplyLikeCheck(vo) >= 1)
			mapper.deleteReplyLike(vo);
		else
			mapper.insertReplyLike(vo);
		return mapper.selectReplyLikeCount(vo.getReply_idx());
	}

	@Override
	public int switchingDislike(ReplyDislikeVO vo) {
		log.info("switchingDislike");
		if (mapper.selectReplyDislikeCheck(vo) >= 1)
			mapper.deleteReplyDislike(vo);
		else
			mapper.insertReplyDislike(vo);
		return mapper.selectReplyDislikeCount(vo.getReply_idx());
	}

}
