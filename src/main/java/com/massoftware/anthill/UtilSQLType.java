package com.massoftware.anthill;

import java.util.ArrayList;
import java.util.List;

public class UtilSQLType {

	public static String toSQLType(Clazz clazz) {

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

		String sqlTmp = buildSQLType(clazz);

		if (sqlTmp == null || sqlTmp.trim().length() == 0) {
			return "";
		}

		sql += sqlTmp;

		return sql;
	}

	public static String buildSQLType(Clazz clazz) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			if (i != 0) {
				sql += buildSQLType(clazz, i, level);
			}

		}

		return sql;
	}

	private static String buildSQLType(Clazz clazz, int maxLevel, int level) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_level_" + maxLevel + "";
		}

		String sql = "";

		for (int i = 0; i < clazz.getOrderAtts().size(); i++) {

			String sqlItem = buildSQLType(clazz, true, maxLevel, level, ml);

			if (sql.contains(sqlItem) == false) {
				sql += sqlItem;
			}

		}

		return sql;

	}

	private static String buildSQLType(Clazz clazzX, boolean limit, int maxLevel, int level, String orderByName) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP TYPE IF EXISTS massoftware.type_" + clazzX.getName() + orderByName + " CASCADE;";

		sql += "\n\nCREATE TYPE massoftware.type_" + clazzX.getName() + orderByName + " AS (\n";

		List<String> fieldsSQL = new ArrayList<String>();

		buildFunctionReturnSelectAtts(maxLevel, level, clazzX, fieldsSQL);

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

			sql += "\n\t\t" + sc + fieldsSQL.get(i);

			for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++) {
				sql += " ";
			}

			sql += "\t\t\t\t-- " + i;
		}

		sql += "\n);";

		return sql;
	}

	private static void buildFunctionReturnSelectAtts(int levelMax, int level, Clazz clazz, List<String> fields) {

		String sqlField = "";

		sqlField += clazz.getName() + "_id VARCHAR(36)";
		fields.add(sqlField);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				String ml = "";

				if (att.isString() && att.getMaxLength() != null) {

					ml = "(" + att.getMaxLength() + ")";

				}

				if (att.isBigDecimal()) {

					ml += "(" + ((DataTypeBigDecimal) att.getDataType()).getPrecision() + ", "
							+ ((DataTypeBigDecimal) att.getDataType()).getScale() + ")";

				}

				sqlField = clazz.getName() + "_" + att.getName() + " " + att.getNameSQL() + ml;

				fields.add(sqlField);

			} else {

				if (level < levelMax) {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildFunctionReturnSelectAtts(levelMax, (level + 1), dataTypeClazz.getClazz(), fields);

				} else {

					sqlField = clazz.getName() + "_" + att.getName() + " VARCHAR(36)";

					fields.add(sqlField);

				}

			}

		}

	}

}
