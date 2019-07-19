package trapick.feed.domain;

import lombok.Data;

@Data
public class ReplyDislikeVO {
	int feed_idx;
	int reply_idx;
	int disliker;
}
