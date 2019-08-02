package trapick.feed.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;
import trapick.feed.service.FeedService;

@Aspect
@Log4j
@Component
@AllArgsConstructor
@NoArgsConstructor
public class FreeChatAdvice {
	
	@Autowired
	FeedService service;

	@Before("execution(* trapick.*.controller.*Controller.*(..))")
	public void logBefore() {

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		if (request.getSession().getAttribute("user_idx") != null) {
			int user_idx = (int)request.getSession().getAttribute("user_idx");
			int alertCount = service.selectAlertListCount(user_idx);
			System.out.println(alertCount);
			request.setAttribute("user_idx", user_idx);
			request.setAttribute("alertCount", alertCount);
		}
	}
}
