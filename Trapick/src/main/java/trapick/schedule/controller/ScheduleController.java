package trapick.schedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.schedule.service.ScheduleService;

@Controller
@RequestMapping("schedule")
@Log4j
public class ScheduleController {

	@Setter(onMethod_ = @Autowired)
	private ScheduleService service;


	@GetMapping("MainPage")
	public void mainPage() {
	}

}
