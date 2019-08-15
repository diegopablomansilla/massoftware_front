package a;

import java.util.ArrayList;
import java.util.List;

import a.convention1.pg.model.Identifiable;
import a.convention1.pg.stm.builder.StmBuilderFill;

public class MainA {

	public static void main(String[] args) throws Exception {

		
		// ------------------------------

		// FillStmBuilder builder = new FillStmBuilder();
		// builder.build(Admin1.class);

		ContinentService continentService = new ContinentService();

		continentService.insert();

		// DataBase db = new DataBasePG(BackendContextPG.get().getDataSourceWrapper());
		//
		// try {
		//
		// db.begint();
		//
		// db.insert(sa);
		//
		// db.insertList(sa.getCountries());
		//
		// // db.insert(cl.getContinent());
		//
		// // db.insert(cl);
		//
		// // db.insert(continents);
		//
		// db.commit();
		//
		// } catch (Exception e) {
		// db.rollBack();
		// throw e;
		// } finally {
		// db.close();
		// }

	}

}
