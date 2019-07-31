package trapick.feed.domain;

import lombok.Data;

@Data
public class UserVO {
	
	private int user_idx;
	private String id;
	private String pw;
	private String email;
	private String img_path;

}
