package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HotelVO {

	private String name;
	private String detail;
	private String image;
	private String location;
	private String review;
	private String latitude;
	private String longitude;
	private String stars;
	private String price;
	private double dist;

}
