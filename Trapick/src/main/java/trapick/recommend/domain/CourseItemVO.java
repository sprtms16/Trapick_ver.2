package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseItemVO {
   private String name;
   private double latitude;
   private double longitude;

}