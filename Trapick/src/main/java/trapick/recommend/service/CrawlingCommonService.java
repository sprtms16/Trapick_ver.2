package trapick.recommend.service;

public interface CrawlingCommonService {

	public String getLatitude(String cityName, String placeName);
	
	public String getLongitude(String cityName, String placeName);
	
	public double getDist(String city_name, String base_point, String latitude, String longitude);
	
}
