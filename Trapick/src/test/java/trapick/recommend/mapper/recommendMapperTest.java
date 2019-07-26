package trapick.recommend.mapper;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import trapick.mypage.mapper.MyPageMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class recommendMapperTest {

	@Setter(onMethod_ = @Autowired)
	RecommendMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private MyPageMapper mapperMy;
	/*
	 * @Test public void test(){ List<Integer> feeder = mapper.findFeeder(2);
	 * 
	 * //okay findfeeder
	 * 
	 * List<Integer> feed = new ArrayList<Integer>(); List<Integer> Temp = new
	 * ArrayList<>();
	 * 
	 * for(int i=0; i<feeder.size(); i++){ Temp =
	 * mapper.findFeed(feeder.get(i)); for(int j=0; j<Temp.size();j++){
	 * feed.add(Temp.get(j)); } Temp.clear(); }
	 * 
	 * //okay findFeed
	 * 
	 * List<Integer> schd_idx = new ArrayList<>();
	 * 
	 * for(int i=0; i<feed.size();i++){ Temp = mapper.findSchedule(feed.get(i));
	 * for(int j=0; j<Temp.size();j++){ schd_idx.add(Temp.get(j)); }
	 * Temp.clear(); }
	 * 
	 * //okay findSchedule
	 * 
	 * List<Integer> wholeLand = new ArrayList<>();
	 * 
	 * for(int i=0; i<schd_idx.size();i++){ Temp =
	 * mapper.findLandmark(schd_idx.get(i)); for(int j=0; j<Temp.size();j++){
	 * wholeLand.add(Temp.get(j)); } Temp.clear(); }
	 * 
	 * //okay landmarkList
	 * 
	 * List<Integer> checkCityList = new ArrayList<>();
	 * 
	 * Temp = mapper.checkCity("시카고"); for(int i=0; i<Temp.size();i++){ for(int
	 * j=0; j<wholeLand.size();j++){ if(Temp.get(i).equals(wholeLand.get(j))){
	 * checkCityList.add(wholeLand.get(j)); } } }
	 * 
	 * //중복 제거 TreeSet<Integer> ts = new TreeSet<Integer>(checkCityList);
	 * checkCityList = new ArrayList<Integer>(ts);
	 * 
	 * 
	 * System.out.println("됨"+checkCityList);
	 * 
	 * //okay 거르기
	 * 
	 * 
	 * }
	 */

	/*
	 * @Test public void test(){ mapperMy.shareSchd(3, 61, 1); }
	 */

}
