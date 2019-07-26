package trapick.recommend.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import trapick.recommend.service.RecommendService;

@Controller
@RequestMapping("/recommend/*")
@AllArgsConstructor
public class RecommedController {
	
//	@Setter(onMethod_ = @Autowired)
	private RecommendService recommedService;
	
	@GetMapping("/index")
	public String index(){
		return "NewFile";
	}
	
	@GetMapping("/test")
	public String index2(){
		return "NewFile2";
	}
	
	@PostMapping("/scheduleDetail")
	public String scheduleDetail(@RequestParam String city_name, @RequestParam String country_name, @RequestParam int day,@RequestParam String start_time, @RequestParam String end_time, Model model){
		model.addAttribute("start_time",start_time);
		model.addAttribute("end_time",end_time);
		model.addAttribute("city_name",city_name);
		model.addAttribute("cityList", recommedService.cityList(country_name));
		model.addAttribute("day",day);
		System.out.println("test1");
		return "recommend/item_sort";
		
	}

	

}
