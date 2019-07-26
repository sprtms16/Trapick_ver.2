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
import trapick.recommend.domain.ItemVO;

@Service
public class CrawlingItemServiceImpl implements CrawlingService {

	@Setter(onMethod_ = @Autowired)
	private CrawlingCommonService com;

	// 상품Crawling Method
	@Override
	public List<ItemVO> crawling(String city_name, String base_point) {

		List<ItemVO> list = new ArrayList<ItemVO>();
		int item_idx = 0;
		String name, detail, img, price;
		int sales, hits = 0;

		try {

			Document doc_ticket = Jsoup
					.connect(
							"https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=" + city_name + "입장권")
					.ignoreHttpErrors(true).get();
			Document doc_pack = Jsoup.connect(
					"https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=" + city_name + "여행 패키지")
					.ignoreHttpErrors(true).get();

			Elements ul_ticket = doc_ticket.select("._page_group ul");
			Elements li_ticket = ul_ticket.select("li");

			Elements ul_pack = doc_pack.select("._page_group ul");
			Elements li_pack = ul_pack.select("li");
			/*
			 * for (item_idx = 0; item_idx < 3; item_idx++) { // idx item_idx++;
			 * // name name =
			 * li_ticket.select(".detail_area").select(".tit").select("a").attr(
			 * "title"); // detail detail =
			 * li_ticket.select(".detail_area").select(".mall_area").select("a")
			 * .text(); // price price =
			 * li_ticket.select(".detail_area").select(".price_num").text(); //
			 * img img =
			 * li_ticket.select(".thumb_area").select("img").attr("src"); //
			 * sales String sales_temp =
			 * li_ticket.select(".detail").select(".txt_review").select("em").
			 * text(). replace(" ", ""); if (sales_temp.length() < 1) { sales =
			 * 0; } else { sales = Integer.parseInt(sales_temp); } if (sales ==
			 * 0) { sales = (int) (Math.random() * 76) + 1; }
			 * 
			 * ItemVO item = new ItemVO(item_idx,
			 * name,com.getLatitude(city_name, name),
			 * com.getLongitude(city_name, name), detail, city_name, price, img,
			 * sales, hits, com.getDist(city_name, base_point,
			 * com.getLatitude(city_name, name), com.getLongitude(city_name,
			 * name)), "Item"); list.add(item); }
			 */

			for (Element el : li_ticket) {

				// idx
				item_idx++;
				// name
				name = el.select(".detail_area").select(".tit").select("a").attr("title");
				// detail
				detail = el.select(".detail_area").select(".mall_area").select("a").text();
				// price
				price = el.select(".detail_area").select(".price_num").text();
				// img
				img = el.select(".thumb_area").select("img").attr("src");
				// sales
				String sales_temp = el.select(".detail").select(".txt_review").select("em").text().replace(" ", "");
				if (sales_temp.length() < 1) {
					sales = 0;
				} else {
					sales = Integer.parseInt(sales_temp);
				}
				if (sales == 0) {
					sales = (int) (Math.random() * 76) + 1;
				}

				String latitude = com.getLatitude(city_name, name);
				String longitude = com.getLongitude(city_name, name);

				ItemVO item = new ItemVO(item_idx, name, latitude, longitude, detail, city_name, price, img, sales,
						hits, com.getDist(city_name, base_point, latitude, longitude), "Item");
				list.add(item);

			}

			for (Element el : li_pack) {

				// idx
				item_idx++;
				// name
				name = el.select(".detail_area").select(".tit").select("a").attr("title");
				// detail
				detail = el.select(".detail_area").select(".mall_area").select("a").text();
				// price
				price = el.select(".detail_area").select(".price_num").text();
				// img
				img = el.select(".thumb_area").select("img").attr("src");
				// sales
				String sales_temp = el.select(".detail").select(".txt_review").select("em").text().replace(" ", "");
				if (sales_temp.length() < 1) {
					sales = 0;
				} else {
					sales = Integer.parseInt(sales_temp);
				}
				if (sales == 0) {
					sales = (int) (Math.random() * 76) + 1;
				}

				String latitude = com.getLatitude(city_name, name);
				String longitude = com.getLongitude(city_name, name);

				ItemVO item = new ItemVO(item_idx, name, latitude, longitude, detail, city_name, price, img, sales,
						hits, com.getDist(city_name, base_point, latitude, longitude), "Item");
				list.add(item);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}