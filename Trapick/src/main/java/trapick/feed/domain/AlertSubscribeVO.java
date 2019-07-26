package trapick.feed.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AlertSubscribeVO {
	UserVO feeder;
	UserVO subscriber;
	FeedVO feed;
	String alert_type;
}
