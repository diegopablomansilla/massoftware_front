package a;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.backend.BackendContextPG;

import a.convention1.pg.model.Identifiable;

public class ContinentService {

	public void insert() throws Exception {

		MyDataBasePG db = BackendContextPG.get().getDataBase();

		try {

			db.begint();

			db.deleteAllObjects(Admin1.class);
			db.deleteAllObjects(Country.class);
			db.deleteAllObjects(Continent.class);

			// -------------------------------

			List<Continent> continents = new ArrayList<Continent>();

			Continent af = new Continent();
			af.setCode("AF");
			af.setName("Africa");
			continents.add(af);

			Continent as = new Continent();
			as.setCode("AS ");
			as.setName("Asia			");
			continents.add(as);

			Continent eu = new Continent();
			eu.setCode("EU ");
			eu.setName("Europe			");
			continents.add(eu);

			Continent na = new Continent();
			na.setCode("NA ");
			na.setName("North América		");
			continents.add(na);

			Continent oc = new Continent();
			oc.setCode("OC ");
			oc.setName("Oceania			");
			continents.add(oc);

			Continent sa = new Continent();
			sa.setCode("SA");
			sa.setName("South América");
			continents.add(sa);

			Continent an = new Continent();
			an.setCode("AN ");
			an.setName("Antarctica			");
			continents.add(an);

			// ------------------------------

			List<Identifiable> countries = new ArrayList<Identifiable>();

			Country ar = new Country();
			ar.setCode("AR");
			ar.setName("Argentina");
			ar.setContinent(sa);
			countries.add(ar);
			sa.addCountry(ar);

			Country uy = new Country();
			uy.setCode("UY");
			uy.setName("Uruguay");
			uy.setContinent(sa);
			countries.add(uy);
			sa.addCountry(uy);

			Country cl = new Country();
			cl.setCode("CL");
			cl.setName("Chile");
			cl.setContinent(sa);
			countries.add(cl);
			sa.addCountry(cl);

			Admin1 cba = new Admin1();
			cba.setCode("CB");
			cba.setName("Córdoba");
			cba.setPais(ar);
			ar.addAdmin(cba);

			Admin1 caba = new Admin1();
			caba.setCode("CA");
			caba.setName("Ciudad Autónoma de Buenos Aires");
			caba.setPais(ar);
			ar.addAdmin(caba);

			Admin1 chubut = new Admin1();
			chubut.setCode("CH");
			chubut.setName("Chubut");
			chubut.setPais(ar);
			ar.addAdmin(chubut);

			// ---------------------------------
			
			db.insertObjects(continents);
			
			for(Continent continent : continents) {
			
				if (continent.getCountries().size() > 0) {
					
					db.insertObjects(continent.getCountries());
					
					for (Country country : continent.getCountries()) {
						
						if (country.getAdmins().size() > 0) {
							db.insertObjects(country.getAdmins());
						}
						
					}	
				}
			}												

			System.out.println("continentes " + db.countAllObjects(Continent.class));
			System.out.println("paises " + db.countAllObjects(Country.class));
			System.out.println("provincias " + db.countAllObjects(Admin1.class));

			@SuppressWarnings("unchecked")
			List<Admin1> r = db.fillAllObjects(Admin1.class);

			for (Admin1 obj : r) {
				System.out.println(obj);
			}

			System.out.println();

			System.out.println(
					db.fillObjectById(sa.getCountries().get(0).getAdmins().get(0).getId(), Admin1.class, 2));

			System.out.println();
			System.out.println();

			ContinentsFilter f = new ContinentsFilter();
			f.setLimit(4L);
			f.setOffset(0L);
			f.setName("America");			
			
			System.out.println(db.countContinents(f));
			System.out.println(db.findContinents(f));
			

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

		

	}

}
