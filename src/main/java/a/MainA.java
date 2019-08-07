package a;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.backend.BackendContextPG;

import a.dao.DataBase;
import a.dao.pg.wrapperds.DataBasePG;
import a.model.Identifiable;

public class MainA {

	public static void main(String[] args) throws Exception {

		List<Identifiable> continents = new ArrayList<Identifiable>();

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
		na.setName("North America		");
		continents.add(na);

		Continent oc = new Continent();
		oc.setCode("OC ");
		oc.setName("Oceania			");
		continents.add(oc);

		Continent sa = new Continent();
		sa.setCode("SA");
		sa.setName("South America");
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

		// ------------------------------
		
		ContinentService continentService = new ContinentService();
		continentService.insert(sa);

//		DataBase db = new DataBasePG(BackendContextPG.get().getDataSourceWrapper());
//
//		try {
//
//			db.begint();
//
//			db.insert(sa);
//		
//			db.insertList(sa.getCountries());
//
//			// db.insert(cl.getContinent());
//
//			// db.insert(cl);
//
//			// db.insert(continents);
//
//			db.commit();
//
//		} catch (Exception e) {
//			db.rollBack();
//			throw e;
//		} finally {
//			db.close();
//		}

	}

}
