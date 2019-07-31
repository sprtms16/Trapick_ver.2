package trapick.recommend.service;

public interface CrawlingCommonService {
/*
	public String getLatitude(String cityName, String placeName);
	
	public String getLongitude(String cityName, String placeName);
*/	
	public double getDist(String latitude, String longitude, String baseLat, String baseLon);
	
}
