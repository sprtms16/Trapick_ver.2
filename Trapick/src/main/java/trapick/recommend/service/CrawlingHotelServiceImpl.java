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

@Service
public class CrawlingHotelServiceImpl implements CrawlingService {
	
	@Setter(onMethod_ = @Autowired)
	private CrawlingCommonService com;

	@Override
	   public List<HotelVO> crawling(String city_name, String base_point) {

	      List<HotelVO> list = new ArrayList<HotelVO>();
	      String name, detail, img, location, review, stars, price;

	      try {

	         String url_hotel = "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=" + city_name + "호텔";	         

	         Document doc_hotel = Jsoup.connect(url_hotel).ignoreHttpErrors(true).get();

	         Elements hotelDoc = doc_hotel.select(".section_hotel_list ul");
	         Elements hotelList = hotelDoc.select("li");

	         for (Element el : hotelList) {

	            // name
	            name = el.select(".info").select("strong").attr("title");
	            if(name=="")   continue;
	            // detail
	            detail = el.select(".info").select(".review").select(".short_review").text();
	            // img
	            img = el.select(".img").select("img").attr("src");
	            // location
	            location = el.select(".info").select(".area").text();
	            // review
	            review = el.select(".info").select(".star_wrap").select(".num").text();
	            // stars
	            stars = el.select(".info").select(".rating_wrap").select(".grade").text();
	            // price
	            price = el.select(".sub_area").select(".price").text();
/*	            String latitude = com.getLatitude(city_name, name);
	            String longitude = com.getLongitude(city_name, name);*/
	            String latitude = "52.003928";
	            String longitude = "49.239840";

	            HotelVO hotel = new HotelVO(name, detail, img, location, review, latitude, longitude, stars, price, com.getDist(city_name, base_point, latitude, longitude), "Hotel");
	    
	            list.add(hotel);
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	      return list;
	   }
}