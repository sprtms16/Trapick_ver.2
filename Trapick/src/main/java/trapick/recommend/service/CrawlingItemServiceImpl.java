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
import trapick.recommend.mapper.RecommendMapper;

@Service
public class CrawlingItemServiceImpl implements CrawlingService {

   @Setter(onMethod_ = @Autowired)
   private CrawlingCommonService com;
   
   @Setter(onMethod_ = @Autowired)
   private RecommendMapper mapper;

   // 상품Crawling Method
   @Override
   public List<ItemVO> crawling(String city_name, String latBase, String lonBase) {

      List<ItemVO> list = new ArrayList<ItemVO>();
      String name, detail, img, price;
      int sales, hits = 0;
      List<String> latList = mapper.itemLatituede(city_name);
      List<String> lonList = mapper.itemLongitude(city_name);
      int locNo = 0;

      try {

         Document doc_ticket = Jsoup
               .connect(
                     "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=" + city_name + "입장권")
               .ignoreHttpErrors(true).get();

         Elements ul_ticket = doc_ticket.select("._page_group ul");
         Elements li_ticket = ul_ticket.select("li");

         for (Element el : li_ticket) {

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

            ItemVO item = new ItemVO(name, latList.get(locNo), lonList.get(locNo), detail, city_name, price, img, sales,
                  hits, 0);
            
            locNo ++;
            
            if(locNo > latList.size()){
            	break;
            }
            
            list.add(item);

         }
         
         Document doc_pack = Jsoup.connect(
                 "https://search.naver.com/search.naver?sm=top_hty&fbm=1&ie=utf8&query=" + city_name + "여행 패키지")
                 .ignoreHttpErrors(true).get();
         
         Elements ul_pack = doc_pack.select("._page_group ul");
         Elements li_pack = ul_pack.select("li");

         for (Element el : li_pack) {

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

            ItemVO item = new ItemVO(name, latList.get(locNo), lonList.get(locNo), detail, city_name, price, img, sales,
                  hits, 0);
            
            locNo++;
            
            if(locNo > latList.size()){
            	break;
            }
            
            list.add(item);

         }
         
         locNo = 0;

      } catch (Exception e) {
         e.printStackTrace();
      }

      return list;
   }
}