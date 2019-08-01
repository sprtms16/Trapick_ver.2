package trapick.recommend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import trapick.recommend.mapper.RecommendMapper;

@Service
public class CrawlingCommonServiceImpl implements CrawlingCommonService {
	
	@Setter(onMethod_ = @Autowired)
	private RecommendMapper mapper;
/*
   @Override
      public String getLatitude(String cityName, String placeName) {

         String url_location = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + placeName + "&key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s";

         String latitude = "";

         try {

            Document doc_location = Jsoup.connect(url_location).ignoreHttpErrors(true).get();

            latitude = doc_location.select("location").select("lat").text();
          
            if (latitude.length() < 10 || latitude == null) {
               String url_temp = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + cityName + "&key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s";
               Document doc_temp = Jsoup.connect(url_temp).ignoreHttpErrors(true).get();
               latitude = doc_temp.select("location").select("lat").text();
            }
            if (latitude.length() > 15) {
               latitude = latitude.substring(latitude.lastIndexOf(" ") + 1);
            }
         } catch (Exception e) {
            e.printStackTrace();
         }

         return latitude;
      }

      // 경도 Method
      @Override
      public String getLongitude(String cityName, String placeName) {

         String url_location = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + placeName
               + "&key=AIzaSyDb_AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s";

         String longitude = "";

         try {
            Document doc_location = Jsoup.connect(url_location).ignoreHttpErrors(true).get();
            longitude = doc_location.select("location").select("lng").text();

            if (longitude.length() < 10) {
               String url_temp = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + cityName
                     + "&key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s";
               Document doc_temp = Jsoup.connect(url_temp).ignoreHttpErrors(true).get();
               longitude = doc_temp.select("location").select("lng").text();
            }

            if (longitude.length() > 15) {
               longitude = longitude.substring(longitude.lastIndexOf(" ") + 1);
            }
         } catch (Exception e) {
            e.printStackTrace();
         }

         return longitude;
      }
      */
      
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