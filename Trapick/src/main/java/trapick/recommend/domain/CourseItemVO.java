package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseItemVO {
	String land_idx;
	String item_detail;
	String item_price;
	String item_name;
	double latitude;
	double longitude;
	String position;
	String image;

}
