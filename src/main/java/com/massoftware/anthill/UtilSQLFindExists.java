package com.massoftware.anthill;

public class UtilSQLFindExists {

	public static String toSQLFindExists(Clazz clazz) {

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

		sql += buildSQLFindExists(clazz);

		return sql;
	}

	public static String buildSQLFindExists(Clazz clazz) {
		String sql = "";

		for (Att att : clazz.getAtts()) {
			if (att.isUnique()) {
				sql += buildSQLFindExistis(clazz, att);
			}
		}

		return sql;
	}

	private static String buildSQLFindExistis(Clazz clazz, Att att) {

		String prefix = "exists";

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + prefix + "_" + clazz.getName() + "_" + att.getName() + "("
				+ att.getName() + "Arg " + att.getNameSQL() + ") CASCADE;";

		sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + prefix + "_" + clazz.getName() + "_" + att.getName()
				+ "(" + att.getName() + "Arg " + att.getNameSQL() + ") RETURNS BOOLEAN ";
		sql += " AS $$";

		sql += "\n\n\tSELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware." + clazz.getName() + "\n\tWHERE";

		/////////////////////////////////////////////////////////////////////////////////////

		if (att.isNumber() || att.isTimestamp() || att.isDate()) {

			sql += "\t" + "(" + att.getName() + "Arg" + " IS NULL OR " + clazz.getName() + "." + att.getName() + " = "
					+ att.getName() + "Arg" + ")";

		} else if (att.isString()) {

			if (att.getSearchOptionUnique().equals(Argument.EQUALS)) {

				String attName = clazz.getName() + "." + att.getName();
				String argName = att.getName() + "Arg";
				String whereSQL = "TRIM(" + attName + ")::VARCHAR = TRIM(" + argName + ")::VARCHAR";

				sql += "\t" + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName + ")) > 0 AND " + whereSQL
						+ "))";

			} else if (att.getSearchOptionUnique().equals(Argument.EQUALS_TRASLATE)) {

				String attName = clazz.getName() + "." + att.getName();
				String argName = att.getName() + "Arg";
				String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName + "))::VARCHAR = TRIM(massoftware.TRANSLATE("
						+ argName + "))::VARCHAR";

				sql += "\t" + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName + ")) > 0 AND " + whereSQL
						+ "))";

			} else if (att.getSearchOptionUnique().equals(Argument.EQUALS_IGNORE_CASE)) {

				String attName = clazz.getName() + "." + att.getName();
				String argName = att.getName() + "Arg";
				String whereSQL = "TRIM(LOWER(" + attName + "))::VARCHAR = TRIM(LOWER(" + argName + "))::VARCHAR";

				sql += "\t" + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName + ")) > 0 AND " + whereSQL
						+ "))";

			} else if (att.getSearchOptionUnique().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

				String attName = clazz.getName() + "." + att.getName();
				String argName = att.getName() + "Arg";
				String whereSQL = "TRIM(LOWER(massoftware.TRANSLATE(" + attName
						+ ")))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

				sql += "\t" + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName + ")) > 0 AND " + whereSQL
						+ "))";
			}
		} else if (att.isBoolean()) {

			sql += "\t" + att.getName() + " = " + att.getName() + "Arg" + " " + att.getNameSQL();

		} else if (att.isSimple() == false) {

			String attName = clazz.getName() + "." + att.getName();
			String argName = att.getName() + "Arg";
			String whereSQL = attName + " = TRIM(" + argName + ")::VARCHAR";

			sql += "\t" + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName + ")) > 0 AND " + whereSQL + "))";
		}

		sql += ";";

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\n$$ LANGUAGE SQL;";

		sql += "\n\n-- SELECT * FROM massoftware.f_" + prefix + "_" + clazz.getName() + "_" + att.getName() + "("
				+ "null::" + att.getNameSQL() + ");";

		return sql;
	}

}
