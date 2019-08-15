package a;

import java.util.List;

import org.cendra.jdbc.DataSourceWrapper;

import a.convention1.pg.DataBasePG;

public class MyDataBasePG extends DataBasePG {

	private ContinentsDAO continentsDAO;

	public MyDataBasePG(DataSourceWrapper dataSourceWrapper, String schema) {
		super(dataSourceWrapper, schema);
		continentsDAO = new ContinentsDAO();
	}

	public List<Continents> findContinents(ContinentsFilter f) throws Exception {
		return continentsDAO.findContinents(connectionWrapper, f);
	}

	public Long countContinents(ContinentsFilter f) throws Exception {
		return continentsDAO.countContinents(connectionWrapper, f);
	}

}
