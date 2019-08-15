package a;

import a.convention1.pg.stm.StatementParam;

public class ContinentsStm extends StatementParam {

	public ContinentsStm(ContinentsFilter f, boolean count) {
		super();

		if (f == null) {
			throw new IllegalArgumentException("QUERY: Se esperaba un bojeto para filtrar la consulta. Se esperaba "
					+ ContinentsFilter.class.getCanonicalName());
		}

		// if (f.getName() == null || f.getName().trim().isEmpty()) {
		// throw new IllegalArgumentException("QUERY: Se esperaba un valor para el campo
		// "
		// + ContinentsFilter.class.getCanonicalName() + ".name para filtrar la
		// consulta");
		// }

		String atts = " COUNT(*) ";
		String orderBy = "";
		String page = "";

		if (count == false) {

			atts = "continent.id, " + "continent.code, "
					+ "continent.name, (SELECT COUNT(*) FROM geo.country WHERE continent = continent.id)";

			orderBy = " ORDER BY " + f.getOrderBy() + " " + (f.getOrderByDesc() ? "DESC" : "");

			if (f.getUnlimited() == false) {
				page = " LIMIT " + f.getLimit() + " OFFSET " + f.getOffset();
			}

		}

		String sql = "SELECT  " + atts + " FROM geo.continent " + buildWhere(f) + orderBy + page;

		this.setSql(sql);

	}

	private String buildWhere(ContinentsFilter f) {

		String where = "";

		if (f.getName() != null && f.getName().trim().isEmpty() == false) {
			where += " TRANSLATE(LOWER(TRIM(continent.name))" + translate + ") LIKE ?";
			this.addArg(buildArgTrimLower(f.getName(), String.class));
		}

		if (where.trim().isEmpty() == false) {
			where = " WHERE " + where;
		}

		return where;
	}

	@SuppressWarnings("rawtypes")
	private Object buildArgTrimLower(Object arg, Class c) {
		if (c == String.class) {
			return (arg == null || arg.toString().trim().isEmpty()) ? c
					: "%" + arg.toString().trim().toLowerCase() + "%";
		}
		return (arg == null || arg.toString().trim().isEmpty()) ? c : arg;
	}

}
