package trapick.feed.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import trapick.feed.mapper.FeedMapper;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class EchoHandler extends TextWebSocketHandler {
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private Map<Integer, List<WebSocketSession>> sessionRoom = new HashMap<Integer, List<WebSocketSession>>();
	@Autowired
	private FeedMapper mapper;

	// 클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// sessionList.add(session);
		// 자신의 방에 자신이 들어가는 것
		List<WebSocketSession> sessionMember = sessionRoom.getOrDefault(session.getAttributes().get("user_idx"),
				new ArrayList<WebSocketSession>());
		sessionMember.add(session);
		sessionRoom.put((Integer) session.getAttributes().get("user_idx"), sessionMember);
		// 피더의 방에 자신이 들어가는 것
		List<Integer> feeders = mapper.selectSubscriber((int) session.getAttributes().get("user_idx"));
		feeders.forEach(feeder -> {
			List<WebSocketSession> feederMember = sessionRoom.getOrDefault(feeder, new ArrayList<WebSocketSession>());
			feederMember.add(session);
			sessionRoom.put(feeder, feederMember);
		});

		logger.info("{} 연결됨", session.getId());
	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		for (WebSocketSession sess : sessionRoom.get(session.getAttributes().get("user_idx"))) {
			int idx = mapper.selectAlertList((int) session.getAttributes().get("user_idx")).size();
			sess.sendMessage(new TextMessage(idx + ""));
			// session.getAttributes().get("user_idx") + " : " +
			// message.getPayload()
		}
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		List<WebSocketSession> sessionMember = sessionRoom.get(session.getAttributes().get("user_idx"));
		if (sessionMember.size() > 1) {
			sessionMember.remove(session);
		} else {
			sessionRoom.remove(session.getAttributes().get("user_idx"));
		}
		// sessionList.remove(session);
		logger.info("{} 연결 끊김", session.getId());
	}

}
