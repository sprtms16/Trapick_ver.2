package trapick.feed.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class FreeChatAdvice {

	@Before("execution(* trapick.*.controller.*Controller.*(..))")
	public void logBefore() {

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		request.setAttribute("user_idx", request.getSession().getAttribute("user_idx"));
	}
}
