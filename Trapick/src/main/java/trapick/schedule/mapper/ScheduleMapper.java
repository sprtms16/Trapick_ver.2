package trapick.schedule.mapper;

import java.util.List;

import trapick.schedule.domain.CityVO;
import trapick.schedule.domain.CountryVO;

public interface ScheduleMapper {

	public List<CountryVO> country_name();
	public List<CityVO> city_name(String country_name);
	public String country_iso(String country_name);
	public String city_ename(String city_name);
}
