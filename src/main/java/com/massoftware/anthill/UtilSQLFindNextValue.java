package com.massoftware.anthill;

public class UtilSQLFindNextValue {

	public static String toSQLFindNextValue(Clazz clazz) {

		String sql = "";

		sql += "\n-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////";
		sql += "\n-- //                                                                                                                        //";
		sql += "\n-- //          TABLA: ";
		sql += clazz.getName();
		int c = 25 + clazz.getName().length();
		int l = 128 - c;
		for (int i = 0; i < l; i++) {
			sql += " ";
		}
		sql += "//";
		sql += "\n-- //                                                                                                                        //";
		sql += "\n-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////";

		sql += "\n\n\n-- Table: massoftware." + clazz.getName();

		sql += buildSQLFindNextValue(clazz);

		return sql;
	}

	public static String buildSQLFindNextValue(Clazz clazz) {
		String sql = "";

		for (Att att : clazz.getAtts()) {
			if (att.isNumber()) {
				sql += buildSQLFindNextValue(clazz, att);
			}
		}

		return sql;
	}

	private static String buildSQLFindNextValue(Clazz clazz, Att att) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_next_" + clazz.getName() + "_" + att.getName()
				+ "() CASCADE;";

		sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_next_" + clazz.getName() + "_" + att.getName()
				+ "() RETURNS " + att.getNameSQL();
		sql += " AS $$";

		sql += "\n\n\tSELECT (COALESCE(MAX(" + att.getName() + "),0) + 1)::" + att.getNameSQL() + " FROM massoftware."
				+ clazz.getName() + ";";

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\n$$ LANGUAGE SQL;";

		sql += "\n\n-- SELECT * FROM massoftware.f_next_" + clazz.getName() + "_" + att.getName() + "();";

		return sql;
	}

}
