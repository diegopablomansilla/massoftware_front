package com.anthill.model.to_sql.old;

import java.util.ArrayList;
import java.util.List;

import com.anthill.model.Argument;
import com.anthill.model.Clazz;
import com.anthill.model.to_java.UtilJavaPOJO;
import com.anthill.model.to_sql.FunctionFind;
import com.anthill.model.to_sql.UtilSQLView;

class UtilSQL3 {

	public static String toSQLFindx(Clazz clazz, boolean view) {

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

		sql += "\n";
		sql += "\n";

		sql += new FunctionFind().toSQL(clazz);

		// sql += UtilSQL3.buildSQLFind(clazz, view);

		return sql;
	}

	public static String buildSQLFind(Clazz clazz, boolean view) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			sql += buildSQLFind(clazz, i, level, view);
		}

		return sql;
	}

	private static String buildSQLFind(Clazz clazz, int maxLevel, int level, boolean view) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_" + maxLevel + "";
		}

		String sql = "";

		sql += buildSQLFind(clazz, false, maxLevel, level, ml, clazz.getName() + ".id", view);

		return sql;

	}

	private static String buildSQLFind(Clazz clazzX, boolean limit, int maxLevel, int level, String orderByName,
			String orderBy, boolean view) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		String argsSQL = "";

		int countArgs = -1;

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.getOnlyVisual() == true) {
				continue;
			}

			String sc = "\n\t\t, ";

			// if (i == 0) {
			// sc = "\n\t\t";
			// }

			countArgs++;

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					argsSQL += sc + arg.getName() + "Arg" + countArgs + " " + arg.getNameSQL();

				} else {

					argsSQL += sc + arg.getName() + "FromArg" + countArgs + " " + arg.getNameSQL();

					countArgs++;

					sc = "\n\t\t, ";

					argsSQL += sc + arg.getName() + "ToArg" + countArgs + " " + arg.getNameSQL();
				}

			} else if (arg.isString()) {

				if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_TRASLATE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

					argsSQL += sc + arg.getName() + "Word" + 0 + "Arg" + countArgs + " " + arg.getNameSQL() + "(15)";

					for (int j = 0; j < 4; j++) {

						countArgs++;

						argsSQL += sc + arg.getName() + "Word" + (j + 1) + "Arg" + countArgs + " " + arg.getNameSQL()
								+ "(15)";

					}

				} else {
					argsSQL += sc + arg.getName() + "Arg" + countArgs + " " + arg.getNameSQL() + "("
							+ arg.getMaxLength() + ")";
				}

			} else if (arg.isBoolean()) {
				argsSQL += sc + arg.getName() + "Arg" + countArgs + " " + arg.getNameSQL();
			} else if (arg.isSimple() == false) {
				argsSQL += sc + arg.getName() + "Arg" + countArgs + " " + "VARCHAR(36)";
			}
		}

		if (limit) {

			String n = "";

			if (argsSQL.trim().length() != 0) {
				n = "\n";
			}

			sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + clazzX.getName() + orderByName
					+ "(limitArg BIGINT, offsetArg BIGINT" + n + argsSQL + n + ") CASCADE;";

			if (maxLevel > 0) {

				sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() + orderByName
						+ "(limitArg BIGINT, offsetArg BIGINT" + n + argsSQL + n + ") RETURNS SETOF massoftware.type_"
						+ clazzX.getName() + "_level_" + maxLevel + "  AS $$";

			} else {
				sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() + orderByName
						+ "(limitArg BIGINT, offsetArg BIGINT" + n + argsSQL + ") RETURNS SETOF massoftware."
						+ clazzX.getName() + "  AS $$";
			}

		} else {

			String n = "";

			if (argsSQL.trim().length() != 0) {
				n = "\n";
			}

			sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + clazzX.getName() + orderByName + "(" + n
					+ argsSQL.replaceFirst(",", " ") + n + ") CASCADE;";

			if (maxLevel > 0) {

				sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() + orderByName + "(" + n
						+ argsSQL.replaceFirst(",", " ") + n + ") RETURNS SETOF massoftware.type_" + clazzX.getName()
						+ "_level_" + maxLevel + "  AS $$";

			} else {
				sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() + orderByName + "(" + n
						+ argsSQL.replaceFirst(",", " ") + n + ") RETURNS SETOF massoftware." + clazzX.getName()
						+ "  AS $$";
			}

		}

		/*
		 * 
		 * if (limit) { sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" +
		 * clazzX.getName() + orderByName +
		 * "(\n\t\tlimitArg BIGINT\n\t\t, offsetArg BIGINT\n" + argsSQL +
		 * "\n) CASCADE;";
		 * 
		 * sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() +
		 * orderByName + "(\n\t\tlimitArg BIGINT\n\t\t, offsetArg BIGINT\n" + argsSQL +
		 * "\n) RETURNS\n\n\tTABLE("; } else { sql +=
		 * "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + clazzX.getName() + orderByName
		 * + "(\n" + argsSQL.replaceFirst(",", " ") + "\n) CASCADE;";
		 * 
		 * sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() +
		 * orderByName + "(\n" + argsSQL.replaceFirst(",", " ") +
		 * "\n) RETURNS\n\n\tTABLE("; }
		 * 
		 * List<String> fieldsSQL = new ArrayList<String>();
		 * 
		 * buildFunctionReturnSelectAtts(maxLevel, level, clazzX, fieldsSQL);
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
		 */
		// ****************************************************************************************************************

		if (view) {

			sql += "\n\n\tSELECT *";

			if (maxLevel > 0) {
				sql += " FROM massoftware.v_" + clazzX.getName() + "_" + maxLevel + " AS " + clazzX.getName();
			} else {
				sql += " FROM massoftware." + clazzX.getName();
			}

		} else {
			sql += "\n\n\tSELECT";

			List<String> fieldsSQL = new ArrayList<String>();

			UtilSQLView.buildSelectAtts(maxLevel, level, clazzX, fieldsSQL);

			int lengthMaxFieldsSQL = 0;

			for (String fieldSQL : fieldsSQL) {
				if (fieldSQL.length() > lengthMaxFieldsSQL) {
					lengthMaxFieldsSQL = fieldSQL.length();
				}
			}

			for (int i = 0; i < fieldsSQL.size(); i++) {
				String sc = " ";

				if (i != 0) {
					sc = ",";
				}

				sql += "\n\t\t" + sc + fieldsSQL.get(i);

				for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++) {
					sql += " ";
				}

				sql += "\t-- " + i;
			}

			sql += "\n\n\tFROM\tmassoftware." + clazzX.getName();

			fieldsSQL = new ArrayList<String>();

			fieldsSQL.add("");

			UtilSQLView.buildSelectAttsLeftJoin(maxLevel, level, clazzX, fieldsSQL);

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
		}

		// ****************************************************************************************************************
		/////////////////////////////////////////////////////////////////////////////////////

		String x = ".";

		if (view && maxLevel > 0) {
			x = "_";
		}

		argsSQL = "";

		countArgs = -1;

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.getOnlyVisual() == true) {
				continue;
			}

			String sc = " AND ";

			String w = "\n\t";

			if (i == 0) {
				sc = "";
				w = "\n\n\tWHERE";
			}

			countArgs++;

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "Arg" + countArgs + " IS NULL OR "
							+ clazzX.getName() + x + arg.getName() + " = " + arg.getName() + "Arg" + countArgs + ")";

				} else {

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "FromArg" + countArgs + " IS NULL OR "
							+ clazzX.getName() + x + arg.getName() + " >= " + arg.getName() + "FromArg" + countArgs
							+ ")";

					countArgs++;

					sc = " AND ";
					w = "\n\t";

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "ToArg" + countArgs + " IS NULL OR "
							+ clazzX.getName() + x + arg.getName() + " <= " + arg.getName() + "ToArg" + countArgs + ")";
				}

			} else if (arg.isString()) {

				if (arg.getSearchOption().equals(Argument.EQUALS)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR = TRIM(" + argName + ")::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR = TRIM(massoftware.TRANSLATE(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(LOWER(" + attName + "))::VARCHAR = TRIM(LOWER(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(LOWER(massoftware.TRANSLATE(" + attName
							+ ")))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE (TRIM(" + argName + ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE (TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE (TRIM(" + argName + ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE (TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

					// } else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR)) {
					//
					// } else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_TRASLATE))
					// {
					//
					// } else if
					// (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)) {
					//
					// } else if
					// (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE))
					// {

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Word" + 0 + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

					sc = " AND ";
					w = "\n\t";

					for (int j = 0; j < 4; j++) {

						countArgs++;

						argName = arg.getName() + "Word" + (j + 1) + "Arg" + countArgs;

						whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName + ") || '%')::VARCHAR";

						argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
								+ ")) > 0 AND " + whereSQL + "))";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Word" + 0 + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

					sc = " AND ";
					w = "\n\t";

					for (int j = 0; j < 4; j++) {

						countArgs++;

						argName = arg.getName() + "Word" + (j + 1) + "Arg" + countArgs;

						whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
								+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName
								+ ")) || '%')::VARCHAR";

						argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
								+ ")) > 0 AND " + whereSQL + "))";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Word" + 0 + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

					sc = " AND ";
					w = "\n\t";

					for (int j = 0; j < 4; j++) {

						countArgs++;

						argName = arg.getName() + "Word" + (j + 1) + "Arg" + countArgs;

						whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName
								+ ") || '%')::VARCHAR";

						argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
								+ ")) > 0 AND " + whereSQL + "))";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + x + arg.getName();
					String argName = arg.getName() + "Word" + 0 + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

					sc = " AND ";
					w = "\n\t";

					for (int j = 0; j < 4; j++) {

						countArgs++;

						argName = arg.getName() + "Word" + (j + 1) + "Arg" + countArgs;

						whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
								+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName
								+ ")) || '%')::VARCHAR";

						argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
								+ ")) > 0 AND " + whereSQL + "))";
					}

				}

			} else if (arg.isBoolean()) {

				argsSQL += w + "\t" + sc + arg.getName() + " = " + arg.getName() + "Arg" + countArgs + " "
						+ arg.getNameSQL();

			} else if (arg.isSimple() == false) {

				// String attName = clazzX.getName() + x + arg.getName();
				String attName = clazzX.getName() + x + "id";
				String argName = arg.getName() + "Arg" + countArgs;
				String whereSQL = attName + " = TRIM(" + argName + ")::VARCHAR";

				argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName + ")) > 0 AND "
						+ whereSQL + "))";
			}
		}

		sql += argsSQL;

		sql += "\n\n\tORDER BY " + orderBy.replace(".", x);

		if (limit) {
			sql += "\n\n\tLIMIT limitArg OFFSET offsetArg;";
		} else {
			sql += ";";
		}

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\n$$ LANGUAGE SQL;";

		argsSQL = "";

		countArgs = -1;

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			if (arg.getOnlyVisual() == true) {
				continue;
			}

			String sc = "\n\t\t, ";

			// if (i == 0) {
			// sc = "\n\t\t";
			// }

			countArgs++;

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					if (arg.isNumber()) {
						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + clazzX.getName() + "_" + arg.getName()
								+ "Arg" + countArgs;
					} else if (arg.isTimestamp()) {
						argsSQL += sc + "now()::TIMESTAMP" + " -- " + clazzX.getName() + "_" + arg.getName() + "Arg"
								+ countArgs;
					} else if (arg.isDate()) {
						argsSQL += sc + "now()::DATE" + " -- " + clazzX.getName() + "_" + arg.getName() + "Arg"
								+ countArgs;
					}

				} else {

					if (arg.isNumber()) {
						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + clazzX.getName() + "_" + arg.getName()
								+ "FromArg" + countArgs;
					} else if (arg.isTimestamp()) {
						argsSQL += sc + "now()::TIMESTAMP" + " -- " + clazzX.getName() + "_" + arg.getName() + "FromArg"
								+ countArgs;
					} else if (arg.isDate()) {
						argsSQL += sc + "now()::DATE" + " -- " + clazzX.getName() + "_" + arg.getName() + "FromArg"
								+ countArgs;
					}

					countArgs++;

					sc = "\n\t\t, ";

					if (arg.isNumber()) {
						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + clazzX.getName() + "_" + arg.getName()
								+ "ToArg" + countArgs;
					} else if (arg.isTimestamp()) {
						argsSQL += sc + "now()::TIMESTAMP" + " -- " + clazzX.getName() + "_" + arg.getName() + "ToArg"
								+ countArgs;
					} else if (arg.isDate()) {
						argsSQL += sc + "now()::DATE" + " -- " + clazzX.getName() + "_" + arg.getName() + "ToArg"
								+ countArgs;
					}
				}

			} else if (arg.isString()) {

				if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_TRASLATE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)
						|| arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

					argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + clazzX.getName() + "_" + arg.getName()
							+ "Word" + 0 + "Arg" + countArgs;

					for (int j = 0; j < 4; j++) {

						countArgs++;

						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + clazzX.getName() + "_" + arg.getName()
								+ "Word" + (j + 1) + "Arg" + countArgs;

					}

				} else {
					argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + clazzX.getName() + "_" + arg.getName()
							+ "Arg" + countArgs;
				}

			} else if (arg.isBoolean()) {
				argsSQL += sc + "false::" + arg.getNameSQL() + " -- " + clazzX.getName() + "_" + arg.getName() + "Arg"
						+ countArgs;
			} else if (arg.isSimple() == false) {

				argsSQL += sc + "null::VARCHAR" + " -- " + clazzX.getName() + "_" + arg.getName() + "Arg" + countArgs;
			}
		}

		sql += "\n\n/*";

		String n = "";

		if (argsSQL.trim().length() != 0) {
			n = "\n";
		}

		if (limit) {
			sql += "\n\nSELECT * FROM massoftware.f_" + clazzX.getName() + orderByName + "(100, 0" + argsSQL + n + ");";
		} else {
			sql += "\n\nSELECT * FROM massoftware.f_" + clazzX.getName() + orderByName + "("
					+ argsSQL.replaceFirst(",", "") + n + ");";
		}

		sql += "\n\n*/";

		return sql;
	}

}
