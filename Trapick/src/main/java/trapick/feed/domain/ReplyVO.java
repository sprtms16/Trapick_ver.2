package trapick.feed.domain;

import lombok.Data;

@Data
public class ReplyVO {
	int reply_idx;
	int feed_idx;
	int user_idx;
	String contents;
	String regdate;
	int like;
	int dislike;
	int isLike;
	int isDislike;

}
