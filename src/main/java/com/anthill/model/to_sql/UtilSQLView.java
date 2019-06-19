package com.anthill.model.to_sql;

import java.util.ArrayList;
import java.util.List;

import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeClazz;
import com.anthill.model.to_java.UtilJavaPOJO;

public class UtilSQLView {

	public static String toSQLView(Clazz clazz) {

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

		String sqlTmp = buildSQLView(clazz);
		
		if (sqlTmp == null || sqlTmp.trim().length() == 0) {
			return "";
		}

		sql += sqlTmp;

		return sql;
	}

	public static String buildSQLView(Clazz clazz) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			if (i != 0) {
				sql += buildSQLView(clazz, i, level);
			}
			
		}

		return sql;
	}

	private static String buildSQLView(Clazz clazz, int maxLevel, int level) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_" + maxLevel + "";
		}

		String sql = "";

		sql += buildSQLView(clazz, false, maxLevel, level, ml);

		return sql;

	}

	private static String buildSQLView(Clazz clazzX, boolean limit, int maxLevel, int level, String orderByName) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP VIEW IF EXISTS massoftware.v_" + clazzX.getName() + orderByName + " CASCADE;";

		sql += "\n\nCREATE OR REPLACE VIEW massoftware.v_" + clazzX.getName() + orderByName + " AS";

		sql += "\n\n\tSELECT";

		List<String> fieldsSQL = new ArrayList<String>();

		buildSelectAtts(maxLevel, level, clazzX, fieldsSQL);

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

			sql += "\t\t-- " + i;
		}

		sql += "\n\tFROM\tmassoftware." + clazzX.getName();

		fieldsSQL = new ArrayList<String>();

		fieldsSQL.add("");

		buildSelectAttsLeftJoin(maxLevel, level, clazzX, fieldsSQL);

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

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\t; -- END VIEW";

		sql += "\n\n-- SELECT * FROM massoftware.v_" + clazzX.getName() + orderByName + " LIMIT 100 OFFSET 0;";

		return sql;
	}
	
	public static void buildSelectAtts(int levelMax, int level, Clazz clazz, List<String> fields) {

		String sqlField = clazz.getName() + ".id AS " + clazz.getName() + "_id";
		fields.add(sqlField);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				sqlField = clazz.getName() + "." + att.getName() + " AS " + clazz.getName() + "_" + att.getName();
				fields.add(sqlField);

			} else {

				if (level < levelMax) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildSelectAtts(levelMax, (level + 1), dataTypeClazz.getClazz(), fields);
				} else {
					sqlField = clazz.getName() + "." + att.getName() + " AS " + clazz.getName() + "_" + att.getName();
					fields.add(sqlField);
				}

			}

		}

	}

	public static void buildSelectAttsLeftJoin(int levelMax, int level, Clazz clazz, List<String> fields) {

		String sqlField = "";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple() == false) {

				if (level < levelMax) {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					sqlField = "LEFT JOIN massoftware." + dataTypeClazz.getClazz().getName() + " ON " + clazz.getName()
							+ "." + att.getName() + " = " + dataTypeClazz.getClazz().getName() + ".id";

					fields.add(sqlField);

					buildSelectAttsLeftJoin(levelMax, (level + 1), dataTypeClazz.getClazz(), fields);
				}
			} else {

				fields.add("");

			}

		}

	}

}
