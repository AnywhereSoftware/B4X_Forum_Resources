package anywheresoftware.b4a.objects;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.objects.collections.Map;

import com.baeldung.algorithms.kmeans.Centroid;



/**
 * KMeansCentroid
 */
@ShortName("KMeansCentroid")
public class CentroidWrapper extends AbsObjectWrapper<Centroid> {

	public void Initialize() {

	}
	
	public Map getCoordinates(){
		Map map1 = new Map();
		map1.Initialize();
		for (java.util.Map.Entry<String, Double> entry : getObject().getCoordinates().entrySet()){
			map1.Put(entry.getKey(), entry.getValue());
		}
		return map1;
	}
}
