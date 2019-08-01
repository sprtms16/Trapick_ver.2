package trapick.recommend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import trapick.recommend.mapper.RecommendMapper;

@Service
public class CrawlingCommonServiceImpl implements CrawlingCommonService {
	
	@Setter(onMethod_ = @Autowired)
	private RecommendMapper mapper;

      
	  //거리 Method
      public double getDist(String latitude, String longitude, String baseLat, String baseLon){
        
    	  double lat = Double.valueOf(latitude);
    	  double lon = Double.valueOf(longitude);
    	  
    	  double latBase = Double.valueOf(baseLat);
    	  double lonBase = Double.valueOf(baseLon);

    	  double dist = 0;
         
         try {
            
            double theta = lon - lonBase;
            
            dist = Math.sin(deg2rad(lat)) * Math.sin(deg2rad(latBase))
                        + Math.cos(deg2rad(lat)) * Math.cos(deg2rad(latBase))  * Math.cos(deg2rad(theta));

            dist = Math.acos(dist);

            dist = rad2deg(dist);

            dist = dist * 60 * 1.1515;

            dist = dist * 1.609344; // kilometer
     
            if(dist == 0){
               dist = (Math.random()*40)+1;
            }
            
            dist = Math.round((dist) * 10) / 10.0;
            
      } catch (Exception e) {
         e.printStackTrace();
      }

         return dist;
      }
      
      private static double deg2rad(double deg) {
         return (deg * Math.PI / 180.0);
      }

      private static double rad2deg(double rad) {
         return (rad * 180 / Math.PI);
      }

}