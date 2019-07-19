package trapick.schedule.domain;

import lombok.Data;

@Data
public class SelectedLandMarkVO {
	private int land_idx;
	private int schd_idx;
	private String name;
	private double latitude;
	private double longitude;
	private String detail;
	private String city_name;
	private int time_defference;
	private String country_name;
	private String start_time;
	private String endItem;
	private int rating;
	private String memo;
}
