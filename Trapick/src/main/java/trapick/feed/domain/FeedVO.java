package trapick.feed.domain;

import java.util.List;

import lombok.Data;

@Data
public class FeedVO{
	int feed_idx;
	int user_idx;
	int schd_idx;
	String regdate;
	String title;
	String contents;
	List<String> url;
	int heart;
	List<ReplyVO> replys;
	int rating;
	int islike;
	int issubs;
	String html;

}
