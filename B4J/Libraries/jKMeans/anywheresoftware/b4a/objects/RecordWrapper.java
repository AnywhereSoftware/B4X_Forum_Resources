package anywheresoftware.b4a.objects;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.objects.collections.Map;
import java.util.LinkedHashMap;

import com.baeldung.algorithms.kmeans.Record;


/**
 * KMeansRecord
 */
@ShortName("KMeansRecord")
public class RecordWrapper extends AbsObjectWrapper<Record> {

	public void Initialize(Map features) {
		java.util.Map<String,Double> featuresMap = new LinkedHashMap<>();
		for (java.util.Map.Entry<Object, Object> entry : features.getObject().entrySet())
			featuresMap.put((String) entry.getKey(), (Double)entry.getValue());
		setObject(new Record(featuresMap));
	}
	
	public Map getFeatures(){
		Map map1 = new Map();
		map1.Initialize();
		for (java.util.Map.Entry<String, Double> entry : getObject().getFeatures().entrySet()){
			map1.Put(entry.getKey(), entry.getValue());
		}
		return map1;
	}
}
