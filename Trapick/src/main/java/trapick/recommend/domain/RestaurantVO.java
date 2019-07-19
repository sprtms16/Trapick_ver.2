package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RestaurantVO {

	   private String name;
	   private String detail;
	   private String image;
	   private String latitude;
	   private String longitude;
	   private double dist;
	   private String category;

}
