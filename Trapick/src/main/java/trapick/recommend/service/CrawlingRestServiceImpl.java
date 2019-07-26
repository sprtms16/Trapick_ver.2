package trapick.recommend.service;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import trapick.recommend.domain.RestaurantVO;

@Service
public class CrawlingRestServiceImpl implements CrawlingService {

	@Setter(onMethod_ = @Autowired)
	private CrawlingCommonService com;

	@Override
	public List<RestaurantVO> crawling(String city_name, String base_point) {

		List<RestaurantVO> list = new ArrayList<RestaurantVO>();
		String name, detail, img;

		try {

			String url = "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=" + city_name
					+ "맛집";

			Document doc = Jsoup.connect(url).ignoreHttpErrors(true).get();

			Elements doc_el = doc.select(".list_top ul");
			Elements doc_rest = doc_el.select("li");

			for (Element el : doc_rest) {

<<<<<<< HEAD
	            // name
	            name = el.select(".list_title").select("strong").text();
	            // detail
	            detail = el.select(".list_title").select(".list_cate").text();
	            // img
	            img = el.select(".list_thumb").select("img").attr("src");
	            
/*	            String latitude = com.getLatitude(city_name, name);
	            String longitude = com.getLongitude(city_name, name);*/
	            String latitude = "52.003928";
	            String longitude = "49.239840";
=======
				// name
				name = el.select(".list_title").select("strong").text();
				// detail
				detail = el.select(".list_title").select(".list_cate").text();
				// img
				img = el.select(".list_thumb").select("img").attr("src");
>>>>>>> branch 'master' of https://github.com/sprtms16/Trapick_ver.2.git

<<<<<<< HEAD
	            RestaurantVO rest = new RestaurantVO(name, detail, img, latitude,longitude, 0,"Rest");
	            list.add(rest);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
=======
//				String latitude = com.getLatitude(city_name, name);
//				String longitude = com.getLongitude(city_name, name);
				
				String latitude = "36.7211348";
				String longitude = "-4.4158666";
>>>>>>> branch 'master' of https://github.com/sprtms16/Trapick_ver.2.git

				RestaurantVO rest = new RestaurantVO(name, detail, img, latitude, longitude,
						com.getDist(city_name, base_point, latitude, longitude), "Rest");
				list.add(rest);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}