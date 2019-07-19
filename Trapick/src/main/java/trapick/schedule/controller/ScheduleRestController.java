package trapick.schedule.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.schedule.domain.CityVO;
import trapick.schedule.domain.CountryVO;
import trapick.schedule.service.ScheduleService;

@RequestMapping("schedule")
@Log4j
@RestController
public class ScheduleRestController {
	@Setter(onMethod_ = @Autowired)
	private ScheduleService service;

	@GetMapping("country")
	public List<CountryVO> countryList() {
		List<CountryVO> countries = service.listCountryService();
		countries.forEach(country -> log.info(country));
		return countries;
	}

	@GetMapping("city_name")
	public List<CityVO> cityList(@RequestParam("country_name") String country_name) {
		List<CityVO> cities = service.ListCityService(country_name);
		cities.forEach(city -> log.info(city));
		return cities;
	}

	@GetMapping("country_iso")
	public String countryIso(@RequestParam("country_name") String country_name) {

		String iso = service.countryIsoService(country_name);
		return iso;
	}

	@GetMapping("city_ename")
	public String cityEname(@RequestParam("city_name") String city_name) {

		String cityEname = service.cityEnameService(city_name);
		return cityEname;
	}
}
