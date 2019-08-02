package trapick.recommend.domain;

public class CourseAlgo {
	private int num;
	private double cost[][];
	private boolean visited[];
	private int city[];
	private int result[];
	private double min;
	
	
	
	public CourseAlgo(int num, double[][] cost) {
		super();
		this.num = num;
		this.cost = cost;
	}



	public CourseAlgo(int num, double[][] cost, boolean[] visited, int[] city, int[] result, double min) {
		super();
		this.num = num;
		this.cost = cost;
		this.visited = visited;
		this.city = city;
		this.result = result;
		this.min = min;
	}



	public int getNum() {
		return num;
	}



	public void setNum(int num) {
		this.num = num;
	}



	public double[][] getCost() {
		return cost;
	}



	public void setCost(double[][] cost) {
		this.cost = cost;
	}



	public boolean[] getVisited() {
		return visited;
	}



	public void setVisited(boolean[] visited) {
		this.visited = visited;
	}



	public int[] getCity() {
		return city;
	}



	public void setCity(int[] city) {
		this.city = city;
	}



	public int[] getResult() {
		return result;
	}



	public void setResult(int[] result) {
		this.result = result;
	}



	public double getMin() {
		return min;
	}



	public void setMin(double min) {
		this.min = min;
	}



	public void tsp(int node, double costSum, int count, int last) {
	    visited[node] = true;
	    city[count - 1] = node;
	    if (count == num) {
//	        for (int i = 0; i < num; i++) {
//	        	System.out.print(city[i]+" ");
//	        }
	        if(costSum<min && city[num-1]==last){
	        	min = costSum;
	        	for(int i = 0 ; i< num; i++){
//	        		System.out.print(city[i]+" ");
	        		result[i] = city[i];
	        	}
//	        	System.out.println(" : " + costSum);
	        }
	        visited[node] = false;
	        city[count - 1] = -1;
	        
	    }
	 
	    for(int i=0;i<num;i++){
	        if(!visited[i] && cost[node][i] != 0){
	        	if(min>cost[node][i]+costSum){
	        		tsp(i, costSum+cost[node][i], count+1,last);
	        	}
	        }
	    }
	    visited[node] = false;
	    city[count - 1] = -1;
	}
}
