package trapick.feed.domain;

import lombok.Data;

@Data
public class ReplyLikeVO{
	int feed_idx;
	int reply_idx;
	int liker;
}
