package a.convention1.util;

import java.util.ArrayList;
import java.util.List;

import a.convention1.anotations.Identifiable;

public class UtilConvention1 {

	@SuppressWarnings("rawtypes")
	public static List<String> getIds(List objs) {

		if (objs == null) {
			throw new IllegalArgumentException("Se esperaba una lista de objetos no nulo.");
		}

		if (objs.size() == 0) {
			throw new IllegalArgumentException("Se esperaba una lista objetos no vacia.");
		}

		List<String> ids = new ArrayList<String>();

		for (Object obj : objs) {

			if (obj != null && obj instanceof Identifiable && ((Identifiable) obj).getId() != null
					&& ((Identifiable) obj).getId().isEmpty() == false) {
				ids.add(((Identifiable) obj).getId());
			}
		}

		return ids;
	}

}
