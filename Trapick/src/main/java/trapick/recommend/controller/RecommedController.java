package trapick.recommend.controller;

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
	public String scheduleDetail(@RequestParam("city_name") String city_name, @RequestParam("country_name") String country_name, @RequestParam("day") int day, Model model){
		model.addAttribute("city_name",city_name);
		model.addAttribute("schd_idx",recommedService.schd_idx());
//		model.addAttribute("itemList", serviceItem.crawling(city_name, ""));
//		model.addAttribute("landMarkList", recommedService.landMarkList(city_name));
		model.addAttribute("cityList", recommedService.cityList(country_name));
		model.addAttribute("day",day);
		return "recommend/item_sort";
		
	}
	@PostMapping("/saveSchedule")
	public String saveSchedule(@RequestParam("title") String title,@RequestParam("schd_idx") String schd_idx){
		recommedService.saveSchedule(title,schd_idx);
		return null;
	}
	
	
	
	
	

}
