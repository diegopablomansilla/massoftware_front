package com.massoftware.anthill;

public class UtilSQLDelete {
	
	public static String toSQLDeleteById(Clazz clazz) {

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

		sql += buildSQLDeleteById(clazz);

		return sql;
	}
	
	public static String buildSQLDeleteById(Clazz clazz) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.d_" + clazz.getName() + "ById" + "(idArg VARCHAR(36)) CASCADE;";

		sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.d_" + clazz.getName() + "ById"
				+ "(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$\n\nBEGIN";

		sql += "\n\n\tIF ((SELECT COUNT(*) FROM massoftware." + clazz.getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
				+ ".id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN";

		sql += "\n\n\t\tRETURN false;";

		sql += "\n\n\tEND IF;";

		sql += "\n\n\tDELETE FROM massoftware." + clazz.getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
				+ ".id = TRIM(idArg)::VARCHAR;";

		sql += "\n\n\tRETURN ((SELECT COUNT(*) FROM massoftware." + clazz.getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
				+ ".id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;";

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\nEND;\n$$ LANGUAGE plpgsql;";

		sql += "\n\n-- SELECT * FROM massoftware.d_" + clazz.getName() + "ById" + "('xxx');";
		sql += "\n\n-- SELECT * FROM massoftware.d_" + clazz.getName() + "ById" + "((SELECT " + clazz.getName()
				+ ".id FROM massoftware." + clazz.getName() + " LIMIT 1)::VARCHAR);";

		return sql;
	}
}
