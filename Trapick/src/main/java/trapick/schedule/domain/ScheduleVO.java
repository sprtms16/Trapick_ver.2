package trapick.schedule.domain;

import java.util.List;

import lombok.Data;

@Data
public class ScheduleVO {
	private int schd_idx;
	private String title;
	private String schd_start;
	private String schd_end;
	private int user_idx;
	private List<SelectedLandMarkVO> selectedLandmarkds;
	private List<SelectedItemVO> selectedItems;
}
