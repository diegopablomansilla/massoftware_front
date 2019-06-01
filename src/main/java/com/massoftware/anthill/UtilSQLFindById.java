package com.massoftware.anthill;

import java.util.ArrayList;
import java.util.List;

public class UtilSQLFindById {

	public static String toSQLFindById(Clazz clazz, boolean view) {

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

		sql += buildSQLFindById(clazz, view);

		return sql;
	}

	public static String buildSQLFindById(Clazz clazz, boolean view) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			sql += buildSQLFindById(clazz, i, level, view);
		}

		return sql;
	}

	private static String buildSQLFindById(Clazz clazz, int maxLevel, int level, boolean view) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_" + maxLevel;
		}

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + clazz.getName() + "ById" + ml
				+ "(idArg VARCHAR(36)) CASCADE;";

		if (maxLevel > 0) {
			sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazz.getName() + "ById" + ml
					+ "(idArg VARCHAR(36)) RETURNS massoftware.type_" + clazz.getName() + "_level_" + maxLevel
					+ " AS $$";
		} else {
			sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazz.getName() + "ById" + ml
					+ "(idArg VARCHAR(36)) RETURNS massoftware." + clazz.getName() + " AS $$";
		}

		/*
		 * sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazz.getName() +
		 * "ById" + ml + "(idArg VARCHAR(36)) RETURNS\n\tTABLE(";
		 * 
		 * List<String> fieldsSQL = new ArrayList<String>();
		 * 
		 * buildFunctionReturnSelectAtts(maxLevel, level, clazz, fieldsSQL);
		 * 
		 * int lengthMaxFieldsSQL = 0;
		 * 
		 * for (String fieldSQL : fieldsSQL) { if (fieldSQL.length() >
		 * lengthMaxFieldsSQL) { lengthMaxFieldsSQL = fieldSQL.length(); } }
		 * 
		 * for (int i = 0; i < fieldsSQL.size(); i++) { String sc = " ";
		 * 
		 * if (i != 0) { sc = ","; }
		 * 
		 * sql += "\n\t\t" + sc + fieldsSQL.get(i);
		 * 
		 * for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++)
		 * { sql += " "; }
		 * 
		 * sql += "\t-- " + i; }
		 * 
		 * sql += "\n\t) AS $$";
		 * 
		 * 
		 */

		// ****************************************************************************************************************

		if (view) {

			sql += "\n\n\tSELECT\t*";

			if (maxLevel == 0) {
				sql += " FROM massoftware.v_" + clazz.getName() + " AS " + clazz.getName();
			} else {
				sql += " FROM massoftware.v_" + clazz.getName() + "_" + maxLevel + " AS " + clazz.getName();
			}

			sql += "\n\tWHERE \tidArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
					+ "_id = TRIM(idArg)::VARCHAR;";

		} else {
			sql += "\n\n\tSELECT";

			List<String> fieldsSQL = new ArrayList<String>();

			UtilSQLView.buildSelectAtts(maxLevel, level, clazz, fieldsSQL);

			int lengthMaxFieldsSQL = 0;

			for (String fieldSQL : fieldsSQL) {
				if (fieldSQL.length() > lengthMaxFieldsSQL) {
					lengthMaxFieldsSQL = fieldSQL.length();
				}
			}

			for (int i = 0; i < fieldsSQL.size(); i++) {
				String sc = "  ";

				if (i != 0) {
					sc = ", ";
				}

				sql += "\n\t\t\t" + sc + fieldsSQL.get(i);

				for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++) {
					sql += " ";
				}

				sql += "\t\t\t-- " + i;
			}

			sql += "\n\tFROM\tmassoftware." + clazz.getName();

			fieldsSQL = new ArrayList<String>();

			fieldsSQL.add("");

			UtilSQLView.buildSelectAttsLeftJoin(maxLevel, level, clazz, fieldsSQL);

			lengthMaxFieldsSQL = 0;

			for (String fieldSQL : fieldsSQL) {
				if (fieldSQL.length() > lengthMaxFieldsSQL) {
					lengthMaxFieldsSQL = fieldSQL.length();
				}
			}

			for (int i = 0; i < fieldsSQL.size(); i++) {

				if (fieldsSQL.get(i).length() > 0) {

					sql += "\n\t\t" + fieldsSQL.get(i);

					for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++) {
						sql += " ";
					}

					sql += "\t-- " + i;

				}
			}

			sql += "\n\tWHERE \tidArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
					+ ".id = TRIM(idArg)::VARCHAR;";

		}

		// ****************************************************************************************************************

		sql += "\n\n$$ LANGUAGE SQL;";

		sql += "\n\n-- SELECT * FROM massoftware.f_" + clazz.getName() + "ById" + ml + "('xxx');";
		sql += "\n-- SELECT * FROM massoftware.f_" + clazz.getName() + "ById" + ml + "((SELECT " + clazz.getName()
				+ ".id FROM massoftware." + clazz.getName() + " LIMIT 1)::VARCHAR);";

		return sql;
	}

}
