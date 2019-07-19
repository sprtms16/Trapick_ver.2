package trapick.recommend.controller;

import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.service.RecommendService;

@RestController
@RequestMapping("/Ajax/*")
@AllArgsConstructor
public class RecommendAjaxController {

	private RecommendService recommedService;
	
	@PostMapping("landMarkAjax")
	public List<LandmarkVO> landMarkAjax(@RequestParam("city_name") String city_name){
		return recommedService.landMarkList(city_name);
	}
	
/*	@PostMapping("saveLandMark")
	public List<LandMark> saveLandMark(LandMark landMark,@RequestParam("position") String position,@RequestParam("schd_idx") String schd_idx) throws InterruptedException{
		Thread.sleep(3000);
		recommedService.saveLandMark(landMark, position, schd_idx);
		
		return null;
	}*/
	
	@PostMapping("/saveLandMark")
	public String saveSchedule(@RequestParam("land_idx") List<String> land_idx, @RequestParam("position") List<String> position, @RequestParam("schd_idx") String schd_idx) throws InterruptedException{
		Thread.sleep(3000);
		for(int i = 0 ; i<land_idx.size()-1; i++){
			recommedService.saveLandMark(land_idx.get(i),position.get(i),schd_idx);
		}
		return null;
	}
}
