package trapick.schedule.domain;

import lombok.Data;

@Data
public class CityVO {
	private int city_idx;
	private String name;
	private String time_difference;
	private int country_idx;
	private String e_name;
}
