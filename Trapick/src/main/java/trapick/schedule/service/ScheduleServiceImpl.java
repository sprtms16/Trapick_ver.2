package trapick.schedule.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.schedule.domain.CityVO;
import trapick.schedule.domain.CountryVO;
import trapick.schedule.mapper.ScheduleMapper;

@Log4j
@Service
@AllArgsConstructor
public class ScheduleServiceImpl implements ScheduleService {

	@Setter(onMethod_ = @Autowired)
	private ScheduleMapper mapper;

	@Override
	public List<CountryVO> listCountryService() {

		return mapper.country_name();
	}

	@Override
	public List<CityVO> ListCityService(String country_name) {
		return mapper.city_name(country_name);
	}
	
	@Override
	public String countryIsoService(String country_name){
		return mapper.country_iso(country_name);
	}
	
	@Override
	public String cityEnameService(String city_name){
		return mapper.city_ename(city_name);
	}

}
