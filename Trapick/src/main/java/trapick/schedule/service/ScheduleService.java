package trapick.schedule.service;

import java.util.List;

import trapick.schedule.domain.CityVO;
import trapick.schedule.domain.CountryVO;

public interface ScheduleService {
	public List<CountryVO> listCountryService();
	
	public List<CityVO> ListCityService(String country_name);
	
	public String countryIsoService(String country_name);
	
	public String cityEnameService(String city_name);
}
