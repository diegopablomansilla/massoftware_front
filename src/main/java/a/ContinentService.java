package a;

import com.massoftware.backend.BackendContextPG;

import a.dao.DataBase;

public class ContinentService {

	public Continent insert(Continent obj) throws Exception {

		DataBase db = BackendContextPG.get().getDataBase();

		try {

			db.begint();

			db.insert(obj);

			db.insertList(obj.getCountries());

			db.commit();

		} catch (Exception e) {
			db.rollBack();
			throw e;
		} finally {
			db.close();
		}

		return obj;

	}

}
