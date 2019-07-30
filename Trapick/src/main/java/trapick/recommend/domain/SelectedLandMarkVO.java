package trapick.recommend.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SelectedLandMarkVO {
	private int schd_idx;
	private int land_idx;
	private String position;
}
