package trapick.recommend.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import trapick.recommend.domain.CourseItemVO;
import trapick.recommend.domain.LandmarkVO;
import trapick.recommend.domain.SelectedItemVO;
import trapick.recommend.domain.SelectedLandMarkVO;
import trapick.recommend.service.RecommendService;

@RestController
@RequestMapping("/Rest/recommend/*")
@AllArgsConstructor
public class RecommendRestController {

   private RecommendService recommedService;

   @PostMapping("landMarkAjax")
   public List<LandmarkVO> landMarkAjax(@RequestParam("city_name") String city_name) {
      return recommedService.landMarkList(city_name);
   }

   @PostMapping("/saveLandMark")
   public String saveSchedule(@RequestParam List<Integer> land_idx, @RequestParam List<String> position,
         @RequestParam List<String> item_name, @RequestParam List<String> item_price,
         @RequestParam List<String> item_detail, @RequestParam List<String> item_image, @RequestParam String title,
         @RequestParam String start_time, @RequestParam String end_time) {
      System.out.println("일정저장시작");
      List<SelectedLandMarkVO> landList = new ArrayList<>();
      List<SelectedItemVO> itemList = new ArrayList<>();
      int i = 0;
      int j = 0;
      for (; i + j < item_price.size();) {
         if (item_price.get(i + j).equals("0")) {
            landList.add(new SelectedLandMarkVO(0, land_idx.get(i), position.get(i + j)));
            i++;
         } else {
            itemList.add(new SelectedItemVO(0, item_name.get(j), item_detail.get(j), item_price.get(i + j),
                  position.get(i + j), item_image.get(j), 0));
            j++;
         }
      }
      String start_day = start_time;
      String end_day = end_time;
      recommedService.saveSchedule(title, landList, itemList, start_day, end_day);
      System.out.println("일정저장완료");
      return null;
   }

   @PostMapping("/course")
   public void course(@RequestParam List<String> item_name, @RequestParam List<String> latitude,
         @RequestParam List<String> longitude) {
      List<CourseItemVO> list = new ArrayList<>();
      for (int i = 0; i < item_name.size(); i++) {
         list.add(new CourseItemVO(item_name.get(i), Double.parseDouble(latitude.get(i)),
               Double.parseDouble(longitude.get(i))));
      }

      double dist[][] = new double[item_name.size()][item_name.size()];
      for (int i = 0; i < item_name.size(); i++) {
         for (int j = 0; j < item_name.size(); j++) {
            if (i == j) {
               dist[i][j] = 0;
            } else {
               dist[i][j] = recommedService.distance(list.get(i).getLatitude(), list.get(i).getLongitude(),
                     list.get(j).getLatitude(), list.get(j).getLongitude());
            }
         }
      }
      for (int i = 0; i < item_name.size(); i++) {
          for (int j = 0; j < item_name.size(); j++) {
             System.out.print(dist[i][j] + " ");
          }
          System.out.println();

       }

   }
}