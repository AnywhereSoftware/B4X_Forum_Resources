package anywheresoftware.b4a.objects;

import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.objects.collections.Map;
import com.baeldung.algorithms.kmeans.KMeans;
import com.baeldung.algorithms.kmeans.Record;
import java.util.List;
import java.util.ArrayList;

import com.baeldung.algorithms.kmeans.Centroid;
import com.baeldung.algorithms.kmeans.EuclideanDistance;

/**
 * KMeans
 */
@ShortName("KMeans")
@Version(1.00f)
public class KMeansWrapper {

	public void Initialize()  {
    
	}
	
	public static Map fit(List<Record> records,int k,int maxIterations){
		EuclideanDistance distance = new EuclideanDistance();
		java.util.Map<Centroid, List<Record>> result = KMeans.fit(records, k, distance, maxIterations);
		Map map1 = new Map();
		map1.Initialize();
		for (java.util.Map.Entry<Centroid, List<Record>> entry : result.entrySet()){
			Centroid centroid = entry.getKey();
		    List<Record> recordsOfCluster = entry.getValue();
		    ArrayList<Record> recordsOfClusterList = new ArrayList<Record>();
		    for (Record record: recordsOfCluster){
		    	recordsOfClusterList.add(record);
		    }
		    map1.Put(centroid,recordsOfClusterList);
		}

		return map1;
	}
}
