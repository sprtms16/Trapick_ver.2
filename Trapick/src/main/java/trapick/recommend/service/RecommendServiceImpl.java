package trapick.recommend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import trapick.recommend.domain.CourseAlgo;
import trapick.recommend.domain.CourseItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.Selected;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;
import trapick.recommend.mapper.LandMarkMapper;

@Service
public class RecommendServiceImpl implements RecommendService {

	@Setter(onMethod_ = @Autowired)
	private LandMarkMapper mapper;

	@Override
	public List<LandmarkVO> landMarkList(String city_name) {
		return mapper.landMarkList(city_name);
	}

	@Override
	public List<String> cityList(String country_name) {
		return mapper.cityList(country_name);
	}


	@Override
	public void saveSchedule(String title, List<Selected> landList, List<Selected> itemList,String start_time,String end_time) {
		mapper.saveSchedule(title, landList, itemList,start_time, end_time);
		
	}

	@Override
	public double distance(double lat1, double lon1, double lat2, double lon2) {
		double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
         
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
        dist = dist * 1.609344;
        return dist;
	}

	@Override
	public double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	@Override
	public double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}

	@Override
	public Map<String, List<Selected>> getSelectedList(List<Integer> land_idx, List<String> position,
			List<String> item_name, List<String> item_price, List<String> item_detail, List<String> item_image,
			String title, String start_time, String end_time) {
		System.out.println("일정저장시작");
		for(int a = 0 ;a<item_name.size();a++){
			System.out.println(item_name.get(a));
		}
		List<Selected> landList = new ArrayList<>();
		List<Selected> itemList = new ArrayList<>();

		int i = 0;
		int j = 0;
		for (; i + j < item_price.size();) {
			if (item_price.get(i + j).equals("0")) {
				landList.add(new SelectedLandMarkVO(0, land_idx.get(i), position.get(i + j)));
				i++;
			} else {
				itemList.add(new SelectedItemVO(0, item_name.get(i+j), item_detail.get(i+j), item_price.get(i + j),
						position.get(i + j), item_image.get(i+j), 0));
				j++;
			}
		}
		System.out.println(landList);
		System.out.println(itemList);
		
		Map<String, List<Selected>> map = new HashMap<>();
		map.put("landList", landList);
		map.put("itemList", itemList);
		
		return map;
	}

	@Override
	public List<CourseItemVO> getCourse(List<String> land_idx, List<String> item_price, List<String> item_name,
			List<String> item_detail, List<String> latitude, List<String> longitude, List<String> position,
			List<String> item_image) {
		
		List<CourseItemVO> list = new ArrayList<>();
		int i = 0;
		int j = 0;
		for (; i + j < item_price.size();) {
			if (item_price.get(i + j).equals("0")) {
				list.add(new CourseItemVO(land_idx.get(i), item_detail.get(i + j), item_price.get(i + j),
						item_name.get(i + j), Double.parseDouble(latitude.get(i+j)), Double.parseDouble(longitude.get(i+j)), position.get(i + j),
						item_image.get(i + j)));
				i++;
			} else {
				list.add(new CourseItemVO("0", item_detail.get(i+j), item_price.get(i+j), item_name.get(i+j), Double.parseDouble(latitude.get(i+j)), Double.parseDouble(longitude.get(i+j)), position.get(i+j), item_image.get(i+j)));
				j++;
			}
		}
		System.out.println(list);
		
		double dist[][] = new double[item_name.size()][item_name.size()];
		for (int a = 0; a < item_name.size(); a++) {
			for (int b = 0; b < item_name.size(); b++) {
				if (a == b) {
					dist[a][b] = 0;
				} else {
					dist[a][b] = distance(list.get(a).getLatitude(), list.get(a).getLongitude(),
							list.get(b).getLatitude(), list.get(b).getLongitude());
				}
			}
		}

		for (int a = 0; a < item_name.size(); a++) {
			for (int b = 0; b < item_name.size(); b++) {
				System.out.print(dist[a][b] + " ");
			}
			System.out.println();

		}

		CourseAlgo algo = new CourseAlgo(dist.length, dist, new boolean[dist.length], new int[dist.length],
				new int[dist.length], 100000);
		algo.tsp(0, 0, 1, dist.length - 1);

		for (int a = 0; a < dist.length; a++) {
			System.out.print(algo.getResult()[a]);
		}
		List<CourseItemVO> resultList = new ArrayList<>();
		for (int a = 0; a < dist.length; a++) {
			resultList.add(list.get(algo.getResult()[a]));
		}
		System.out.println(list);
		System.out.println(resultList);
		return resultList;
	}

		

}