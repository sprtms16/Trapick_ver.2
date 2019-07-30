package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SelectedItemVO {
	private int item_idx;
	private String name;
	private String detail;
	private String price;
	private String position;
	private String image;
	private int schd_idx;
}
