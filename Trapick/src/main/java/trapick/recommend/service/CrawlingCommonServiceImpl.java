package trapick.recommend.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

@Service
public class CrawlingCommonServiceImpl implements CrawlingCommonService {

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
	   
	   //거리 Method
	   public double getDist(String city_name, String base_point, String latitude, String longitude){
		   
		   double latList = Double.valueOf(latitude);
		   double lonList = Double.valueOf(longitude);
		   double dist = 0;
		   
		   try {
			   
			   String urlBase = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + city_name+base_point + "&key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s";
			   
			   Document docBase = Jsoup.connect(urlBase).ignoreHttpErrors(true).get();
			   
			   String latBaseTemp = docBase.select("location").select("lat").text();
			   String lonBaseTemp = docBase.select("location").select("lng").text();
			   
		       if (latBaseTemp.length() < 10 || latBaseTemp == null) {
				   urlBase = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + city_name+base_point + "&key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s";
				   
				   docBase = Jsoup.connect(urlBase).ignoreHttpErrors(true).get();
			          latBaseTemp = docBase.select("location").select("lat").text();
			       }
			       if (latBaseTemp.length() > 15) {
			    	   latBaseTemp = latBaseTemp.substring(latBaseTemp.lastIndexOf(" ") + 1);
			       }
			       
			    if (lonBaseTemp.length() < 10) {
					   urlBase = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + city_name+base_point + "&key=AIzaSyCafdAtR2qeRHV-G6art-6-guHlmJBL_1s";
					   
					   docBase = Jsoup.connect(urlBase).ignoreHttpErrors(true).get();
				        lonBaseTemp = docBase.select("location").select("lng").text();
			    }
				       if (lonBaseTemp.length() > 15) {
				    	   lonBaseTemp = lonBaseTemp.substring(lonBaseTemp.lastIndexOf(" ") + 1);
				       }			       
			 
			   
			   double latBase = Double.valueOf(latBaseTemp);
			   double lonBase = Double.valueOf(lonBaseTemp);
			   
			   double theta = lonList - lonBase;
			   
			   dist = Math.sin(deg2rad(latList)) * Math.sin(deg2rad(latBase))
					   		+ Math.cos(deg2rad(latList)) * Math.cos(deg2rad(latBase))  * Math.cos(deg2rad(theta));

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
