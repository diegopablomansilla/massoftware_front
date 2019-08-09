package a;

import java.util.List;

import com.massoftware.backend.BackendContextPG;

import a.dao.DataBase;

public class ContinentService {

	public Continent insert(Continent continent) throws Exception {

		DataBase db = BackendContextPG.get().getDataBase();

		try {

			db.begint();

			db.deleteAll(Admin1.class);
			db.deleteAll(Country.class);
			db.deleteAll(Continent.class);

			db.insert(continent);
			db.insertAll(continent.getCountries());
			for (Country country : continent.getCountries()) {
				if (country.getAdmins().size() > 0) {
					db.insertAll(country.getAdmins());
				}
			}

			System.out.println("continentes " + db.count(Continent.class));
			System.out.println("paises " + db.count(Country.class));
			System.out.println("provincias " + db.count(Admin1.class));

			
			List<Admin1> r = db.fillAll(Admin1.class);
			
			for(Admin1 obj : r) {
				System.out.println(obj);	
			}

			// boolean b = db.exists(obj);
			// boolean b = db.existsById(obj.getId(), Continent.class);
			// System.out.println("Exists " + b);

			// obj.setName("YYY");

			// db.update(obj, ContinentMappingInsert.class);
			// db.update(obj);

			//

			// obj.getCountries().get(1).setName("XXX");

			// db.updateAll(obj.getCountries());

			// b =db.deleteAll(Country.class);
			// System.out.println("BORRADO " + b);

			// boolean b = db.delete(obj.getCountries().get(0));
			// boolean b = db.deleteById(obj.getCountries().get(0).getId(), Country.class);
			// System.out.println("BORRADO " + b);

			// List<Boolean> b = db.deleteAll(obj.getCountries());
			// System.out.println("BORRADO " + b);

			// List<Boolean> b = db.deleteAllById(UtilConvention1.getIds(obj.getCountries())
			// , Country.class);
			// System.out.println("BORRADO " + b);

			db.commit();

		} catch (Exception e) {
			db.rollBack();
			e.printStackTrace();
			throw e;
		} finally {
			db.close();
		}

		return continent;

	}

}
