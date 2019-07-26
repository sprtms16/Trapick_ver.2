package trapick.feed.domain;

import lombok.Data;

@Data
public class UserVO {
	int user_idx;
	String id;
	String pw;
	String session_id;
	String email;
}
