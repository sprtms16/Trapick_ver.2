package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemVO {

	String name;
	String latitude;
	String longitude;
	String detail;
	String city_name;
	String price;
	String image;
	int sales;
	int hits;
	double dist;

}
