package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LandmarkVO {

	int land_idx;
	String name;
	double latitude;
	double longitude;
	String detail;
	String city_name;
	int time_defference;
	String country_name;
	String image;
	String category;

}
