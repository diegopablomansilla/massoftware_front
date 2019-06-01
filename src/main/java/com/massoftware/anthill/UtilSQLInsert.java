package com.massoftware.anthill;

public class UtilSQLInsert {
	
	public static String toSQLInsert(Clazz clazz) {

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

		sql += buildSQLInsert(clazz);

		return sql;
	}
	
	public static String buildSQLInsert(Clazz clazz) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		String argsSQL = "";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			String sc = "\n\t\t, ";

			if (att.isNumber() || att.isTimestamp() || att.isDate()) {

				argsSQL += sc + att.getName() + "Arg" + " " + att.getNameSQL();

			} else if (att.isString()) {

				argsSQL += sc + att.getName() + "Arg" + " " + att.getNameSQL() + "(" + att.getMaxLength() + ")";

			} else if (att.isBoolean()) {

				argsSQL += sc + att.getName() + "Arg" + " " + att.getNameSQL();

			} else if (att.isSimple() == false) {

				argsSQL += sc + att.getName() + "Arg" + " " + "VARCHAR(36)";
			}
		}

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.i_" + clazz.getName() + "(\n\t\t  idArg VARCHAR(36)\n" + argsSQL
				+ "\n) CASCADE;";

		sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.i_" + clazz.getName() + "(\n\t\t  idArg VARCHAR(36)\n"
				+ argsSQL + "\n) RETURNS BOOLEAN AS $$\n\nBEGIN";

		String attNames = "";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			attNames += (i == 0) ? att.getName() : ", " + att.getName();
		}

		sql += "\n\n\tIF idArg IS NULL THEN";
		sql += "\n\n\t\tidArg = uuid_generate_v4();";
		sql += "\n\n\tEND IF;";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isTimestamp()) {
				DataTypeTimestamp dt = (DataTypeTimestamp) att.getDataType();
				if (dt.getDefNowInsert() == true) {

					sql += "\n\n\tIF " + att.getName() + "Arg IS NULL THEN";
					sql += "\n\n\t\t" + att.getName() + "Arg = now();";
					sql += "\n\n\tEND IF;";

				}
			} else if (att.isBigDecimal()) {
				DataTypeBigDecimal dt = (DataTypeBigDecimal) att.getDataType();
				if (dt.getDefValueInsert() != null) {
					argsSQL += (i == 0) ? dt.getDefValueInsert() : ", " + dt.getDefValueInsert();
					sql += "\n\n\tIF " + att.getName() + "Arg IS NULL THEN";
					sql += "\n\n\t\t" + att.getName() + "Arg = " + dt.getDefValueInsert() + ";";
					sql += "\n\n\tEND IF;";
				}
			} else if (att.isBoolean()) {
				sql += "\n\n\tIF " + att.getName() + "Arg IS NULL THEN";
				sql += "\n\n\t\t" + att.getName() + "Arg = false;";
				sql += "\n\n\tEND IF;";
			}

		}

		argsSQL = "";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			argsSQL += (i == 0) ? att.getName() + "Arg" : ", " + att.getName() + "Arg";

		}

		sql += "\n\n\tINSERT INTO massoftware." + clazz.getName() + "(id, " + attNames + ") VALUES (idArg, " + argsSQL
				+ ");";

		sql += "\n\n\tRETURN ((SELECT COUNT(*) FROM massoftware." + clazz.getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
				+ ".id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;";

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\nEND;\n$$ LANGUAGE plpgsql;";

		argsSQL = "";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			String sc = "\n\t\t, ";

			if (att.isSimple()) {

				argsSQL += sc + "null::" + att.getNameSQL();

			} else if (att.isString()) {

				argsSQL += sc + "null::" + att.getNameSQL();

			} else if (att.isBoolean()) {

				argsSQL += sc + "null::" + att.getNameSQL();

			} else if (att.isSimple() == false) {

				argsSQL += sc + "null::" + "VARCHAR(36)";
			}
		}

		sql += "\n\n/*";
		sql += "\n\nSELECT * FROM massoftware.i_" + clazz.getName() + "(\n\t\tnull::VARCHAR(36)" + argsSQL + "\n);";

		sql += "\n\n*/";

		return sql;
	}

}
