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
import trapick.recommend.domain.HotelVO;
import trapick.recommend.mapper.RecommendMapper;

@Service
public class CrawlingHotelServiceImpl implements CrawlingService {

	@Setter(onMethod_ = @Autowired)
	private CrawlingCommonService com;
	
	@Setter(onMethod_ = @Autowired)
	private RecommendMapper mapper;

	@Override
	public List<HotelVO> crawling(String city_name, String latBase, String lonBase) {

		List<HotelVO> list = new ArrayList<HotelVO>();
		String name, detail, img, location, review, stars, price;
		List<String> latList = mapper.hotelLatituede(city_name);
		List<String> lonList = mapper.hotelLongitude(city_name);
		int locNo = 0;

		try {

			String url_hotel = "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=" + city_name + "호텔";

			Document doc_hotel = Jsoup.connect(url_hotel).ignoreHttpErrors(true).get();

			Elements hotelDoc = doc_hotel.select(".section_hotel_list ul");
			Elements hotelList = hotelDoc.select("li");
			
			for(int i=0; i<hotelList.size();i++){
				
			}

			for (Element el : hotelList) {

				// name
				name = el.select(".info").select("strong").attr("title");
				if (name == "")
					continue;
				// detail
				detail = el.select(".info").select(".review").select(".short_review").text();
				// img
				img = el.select(".img").select("img").attr("src");
				// location
				location = el.select(".info").select(".area").text();
				// review
				review = el.select(".info").select(".star_wrap").select(".num").text();
				if(review.length() < 2){
					review = "8.3";
					System.out.println("들어옴");
				}
				// stars
				stars = el.select(".info").select(".rating_wrap").select(".grade").text();
				// price
				price = el.select(".sub_area").select(".price").text();

				HotelVO hotel = new HotelVO(name, detail, img, location, review,latList.get(locNo), lonList.get(locNo), stars, price,0);
				
				locNo ++;
				
				if(locNo >= latList.size()){
					break;
				}

				list.add(hotel);
			}
			locNo = 0;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}