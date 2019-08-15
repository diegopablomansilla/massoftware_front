package a;

import java.util.ArrayList;
import java.util.List;

import org.cendra.jdbc.ConnectionWrapper;

public class ContinentsDAO {

	public List<Continents> findContinents(ConnectionWrapper connectionWrapper, ContinentsFilter f) throws Exception {

		List<Continents> r = new ArrayList<Continents>();

		ContinentsStm stm = new ContinentsStm(f, false);

		Object[][] table = connectionWrapper.findToTable(stm.getSql(), stm.getArgs());

		if (table != null && table.length > 0) {

			for (Object[] row : table) {

				Continents objRow = new Continents();

				int c = -1;

				objRow.setId((String) row[++c]);
				objRow.setCode((String) row[++c]);
				objRow.setName((String) row[++c]);
				objRow.setCountries((Long) row[++c]);

				r.add(objRow);

			}
		}

		return r;
	}

	public Long countContinents(ConnectionWrapper connectionWrapper, ContinentsFilter f) throws Exception {

		ContinentsStm stm = new ContinentsStm(f, true);

		Object[][] table = connectionWrapper.findToTable(stm.getSql(), stm.getArgs());

		if (table.length == 1) {

			Object[] row = table[0];

			return (Long) row[0];

		} else {

			throw new IllegalStateException(
					"No se esperaba que la consulta a la base de datos devuelva " + table.length + " filas.");

		}

	}

}
