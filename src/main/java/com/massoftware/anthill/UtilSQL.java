package com.massoftware.anthill;

import java.util.ArrayList;
import java.util.List;

public class UtilSQL {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toSQL(Clazz clazz) {

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

		sql += UtilSQL.buildSQLTabla(clazz);

		// buildInsert();

		sql += UtilSQL.buildSQLSelects(clazz);

		sql += UtilSQL.buildSQLDeleteById(clazz);

		sql += UtilSQL.buildSQLInsert(clazz);

		sql += UtilSQL.buildSQLUpdate(clazz);

		sql += UtilSQL.buildSQLFindExists(clazz);

		sql += UtilSQL.buildSQLFindNextValue(clazz);

		// buildSelect();
		
		sql += buildSQLFindType(clazz);

		sql += UtilSQL.buildSQLFindById(clazz);

		sql += UtilSQL.buildSQLFind(clazz);

		return sql;
	}

	public static String toSQLTable(Clazz clazz) {

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

		sql += UtilSQL.buildSQLTabla(clazz);

		// buildInsert();

		sql += UtilSQL.buildSQLSelects(clazz);

		return sql;
	}

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

		sql += UtilSQL.buildSQLSelects(clazz);

		sql += UtilSQL.buildSQLFindExists(clazz);

		return sql;
	}

	public static String toSQLIUD(Clazz clazz) {

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

		sql += UtilSQL.buildSQLSelects(clazz);

		sql += UtilSQL.buildSQLDeleteById(clazz);

		sql += UtilSQL.buildSQLInsert(clazz);

		sql += UtilSQL.buildSQLUpdate(clazz);

		return sql;
	}

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

		sql += UtilSQL.buildSQLFindNextValue(clazz);

		return sql;
	}

	public static String toSQLFindTypeReturn(Clazz clazz) {

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

		sql += UtilSQL.buildSQLFindType(clazz);

		return sql;
	}

	public static String toSQLFindById(Clazz clazz) {

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

		sql += UtilSQL.buildSQLFindById(clazz);

		return sql;
	}

	public static String toSQLFind0(Clazz clazz) {

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

		sql += UtilSQL.buildSQLFind(clazz, 0);

		return sql;
	}

	public static String toSQLFind1(Clazz clazz) {

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

		sql += UtilSQL.buildSQLFind(clazz, 1);

		return sql;
	}

	public static String toSQLFind2(Clazz clazz) {

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

		sql += UtilSQL.buildSQLFind(clazz, 2);

		return sql;
	}

	public static String toSQLFind3(Clazz clazz) {

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

		sql += UtilSQL.buildSQLFind(clazz, 3);

		return sql;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	private static String buildSQLTabla(Clazz clazz) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";
		sql += "\n\nDROP TABLE IF EXISTS massoftware." + clazz.getName() + " CASCADE;";
		sql += "\n\nCREATE TABLE massoftware." + clazz.getName();
		sql += "\n(";

		sql += "\n\tid VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),";

		for (Att att : clazz.getAtts()) {
			sql += "\n\t" + att.toSQL();
		}

		sql = "\n\n" + sql.trim().substring(0, sql.trim().length() - 1);

		sql += "\n);";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		for (Att att : clazz.getAtts()) {

			if (att.isUnique() && att.isString()) {

				if (Unique.EQUALS_TRASLATE.equals(att.getSearchOptionUnique())) {

					sql += "\n\nCREATE UNIQUE INDEX u_" + clazz.getName() + "_" + att.getName() + " ON massoftware."
							+ clazz.getName() + " (TRANSLATE(TRIM(" + att.getName() + ")"
							+ "\n\t, '/\\\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'"
							+ "\n\t, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));";

				} else if (Unique.EQUALS_IGNORE_CASE.equals(att.getSearchOptionUnique())) {

					sql += "\n\nCREATE UNIQUE INDEX u_" + clazz.getName() + "_" + att.getName() + " ON massoftware."
							+ clazz.getName() + " (LOWER(TRIM(" + att.getName() + ")));";

				} else if (Unique.EQUALS_IGNORE_CASE_TRASLATE.equals(att.getSearchOptionUnique())) {

					sql += "\n\nCREATE UNIQUE INDEX u_" + clazz.getName() + "_" + att.getName() + " ON massoftware."
							+ clazz.getName() + " (TRANSLATE(LOWER(TRIM(" + att.getName() + "))"
							+ "\n\t, '/\\\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'"
							+ "\n\t, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));";

				}

			}
		}

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";
		sql += "\nDROP FUNCTION IF EXISTS massoftware.ftgFormat" + clazz.getName() + "() CASCADE;\n";
		sql += "\nCREATE OR REPLACE FUNCTION massoftware.ftgFormat" + clazz.getName() + "() RETURNS TRIGGER AS $format"
				+ clazz.getName() + "$";
		sql += "\nDECLARE";
		sql += "\nBEGIN";

		sql += "\n\t NEW.id := massoftware.white_is_null(NEW.id);";

		for (Att att : clazz.getAtts()) {

			if (att.isString() || att.isSimple() == false) {
				sql += "\n\t NEW." + att.getName() + " := massoftware.white_is_null(NEW." + att.getName() + ");";
			}
		}

		sql += "\n\n\tRETURN NEW;";
		sql += "\nEND;";
		sql += "\n$format" + clazz.getName() + "$ LANGUAGE plpgsql;";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\nDROP TRIGGER IF EXISTS tgFormat" + clazz.getName() + " ON massoftware." + clazz.getName()
				+ " CASCADE;\n";
		sql += "\nCREATE TRIGGER tgFormat" + clazz.getName() + " BEFORE INSERT OR UPDATE";
		sql += "\n\tON massoftware." + clazz.getName() + " FOR EACH ROW";
		sql += "\n\tEXECUTE PROCEDURE massoftware.ftgFormat" + clazz.getName() + "();";

		return sql;
	}

	private static String buildSQLSelects(Clazz clazz) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\n\n-- SELECT COUNT(*) FROM massoftware." + clazz.getName() + ";";
		sql += "\n\n-- SELECT * FROM massoftware." + clazz.getName() + " LIMIT 100 OFFSET 0;";
		sql += "\n\n-- SELECT * FROM massoftware." + clazz.getName() + ";";
		sql += "\n\n-- SELECT * FROM massoftware." + clazz.getName() + " WHERE id = 'xxx';";

		return sql;
	}

	private static String buildSQLDeleteById(Clazz clazz) {

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

	private static String buildSQLInsert(Clazz clazz) {

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

	private static String buildSQLUpdate(Clazz clazz) {

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

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.u_" + clazz.getName() + "(\n\t\t  idArg VARCHAR(36)\n" + argsSQL
				+ "\n) CASCADE;";

		sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.u_" + clazz.getName() + "(\n\t\t  idArg VARCHAR(36)\n"
				+ argsSQL + "\n) RETURNS BOOLEAN AS $$\n\nBEGIN";

		// String attNames = "";

		// for (int i = 0; i < this.getAtts().size(); i++) {
		//
		// Att att = this.getAtts().get(i);
		//
		// attNames += (i == 0) ? att.getName() : ", " + att.getName();
		// }

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isTimestamp()) {
				DataTypeTimestamp dt = (DataTypeTimestamp) att.getDataType();
				if (dt.getDefNowUpdate() == true) {

					sql += "\n\n\tIF " + att.getName() + "Arg IS NULL THEN";
					sql += "\n\n\t\t" + att.getName() + "Arg = now();";
					sql += "\n\n\tEND IF;";

				}
			} else if (att.isBigDecimal()) {
				DataTypeBigDecimal dt = (DataTypeBigDecimal) att.getDataType();
				if (dt.getDefValueUpdate() != null) {
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

			argsSQL += (i == 0) ? "\n\t\t  " + att.getName() + " = " + att.getName() + "Arg"
					: "\n\t\t, " + att.getName() + " = " + att.getName() + "Arg";

		}

		sql += "\n\n\tUPDATE massoftware." + clazz.getName() + " SET " + argsSQL
				+ "\n\tWHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
				+ ".id = TRIM(idArg)::VARCHAR;";

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
		sql += "\n\nSELECT * FROM massoftware.u_" + clazz.getName() + "(\n\t\tnull::VARCHAR(36)" + argsSQL + "\n);";

		sql += "\n\n*/";

		return sql;
	}

	private static String buildSQLFindExists(Clazz clazz) {
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

		sql += "\n\n\tSELECT (COUNT(*) > 0)::BOOLEAN\n\tFROM\tmassoftware." + clazz.getName() + "\n\tWHERE";

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

		sql += "\n\n/*";

		sql += "\n\nSELECT * FROM massoftware.f_" + prefix + "_" + clazz.getName() + "_" + att.getName() + "("
				+ "null::" + att.getNameSQL() + ");";

		sql += "\n\n*/";

		return sql;
	}

	private static String buildSQLFindNextValue(Clazz clazz) {
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

		sql += "\n\n\tSELECT (COALESCE(MAX(" + att.getName() + "),0) + 1)::" + att.getNameSQL()
				+ "\n\tFROM\tmassoftware." + clazz.getName() + ";";

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\n$$ LANGUAGE SQL;";

		sql += "\n\n/*";

		sql += "\n\nSELECT * FROM massoftware.f_next_" + clazz.getName() + "_" + att.getName() + "();";

		sql += "\n\n*/";

		return sql;
	}

	private static String buildSQLFindById(Clazz clazz) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			sql += buildSQLFindById(clazz, i, level);
		}

		return sql;
	}

	private static String buildSQLFindById(Clazz clazz, int maxLevel, int level) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_level_" + maxLevel;
		}

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + clazz.getName() + "ById" + ml
				+ "(idArg VARCHAR(36)) CASCADE;";

		if(level > 0) {
			sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazz.getName() + "ById" + ml + "(idArg VARCHAR(36)) RETURNS massoftware.type_" + clazz.getName() + ml + " AS $$";	
		} else {
			sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazz.getName() + "ById" + ml + "(idArg VARCHAR(36)) RETURNS massoftware." + clazz.getName() + ml + " AS $$";
		}
		

/*		
		sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazz.getName() + "ById" + ml
				+ "(idArg VARCHAR(36)) RETURNS\n\tTABLE(";

		List<String> fieldsSQL = new ArrayList<String>();

		buildFunctionReturnSelectAtts(maxLevel, level, clazz, fieldsSQL);

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

		sql += "\n\t) AS $$";
		
		
*/
		
		
		sql += "\n\n\tSELECT";

		List<String> fieldsSQL = new ArrayList<String>();

		buildSelectAtts(maxLevel, level, clazz, fieldsSQL);

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

		sql += "\n\n\tFROM\tmassoftware." + clazz.getName();

		fieldsSQL = new ArrayList<String>();

		fieldsSQL.add("");

		buildSelectAttsLeftJoin(maxLevel, level, clazz, fieldsSQL);

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

		sql += "\n\n\tWHERE \tidArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + clazz.getName()
				+ ".id = TRIM(idArg)::VARCHAR;";

		sql += "\n\n$$ LANGUAGE SQL;";

		sql += "\n\n-- SELECT * FROM massoftware.f_" + clazz.getName() + "ById" + ml + "('xxx');";
		sql += "\n\n-- SELECT * FROM massoftware.f_" + clazz.getName() + "ById" + ml + "((SELECT " + clazz.getName()
				+ ".id FROM massoftware." + clazz.getName() + " LIMIT 1)::VARCHAR);";

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

				}

			}

		}

	}

	private static void buildSelectAtts(int levelMax, int level, Clazz clazz, List<String> fields) {

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
				}

			}

		}

	}

	private static void buildSelectAttsLeftJoin(int levelMax, int level, Clazz clazz, List<String> fields) {

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

	private static String buildSQLFind(Clazz clazz, int levelArg) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			String sqlLevel = buildSQLFind(clazz, i, level);

			if (levelArg == i) {
				return sqlLevel;
			}

			sql += sqlLevel;
		}

		return sql;
	}

	private static String buildSQLFind(Clazz clazz) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			sql += buildSQLFind(clazz, i, level);
		}

		return sql;
	}

	private static String buildSQLFind(Clazz clazz, int maxLevel, int level) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_" + maxLevel + "";
		}

		String sql = "";

		sql += buildSQLFind(clazz, false, maxLevel, level, ml, clazz.getName() + ".id");

		sql += buildSQLFind(clazz, true, maxLevel, level, ml, clazz.getName() + ".id");

		for (int i = 0; i < clazz.getOrderAtts().size(); i++) {

			sql += buildSQLFind(clazz, true, maxLevel, level,
					"_asc_" + clazz.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(clazz.getOrderAtts().get(i).getName()) + ml,
					clazz.getOrderAtts().get(i).getClazz().getName() + "." + clazz.getOrderAtts().get(i).getName()
							+ " ASC");

			sql += buildSQLFind(clazz, true, maxLevel, level,
					"_des_" + clazz.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(clazz.getOrderAtts().get(i).getName()) + ml,
					clazz.getOrderAtts().get(i).getClazz().getName() + "." + clazz.getOrderAtts().get(i).getName()
							+ " DESC");

			sql += buildSQLFind(clazz, false, maxLevel, level,
					"_asc_" + clazz.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(clazz.getOrderAtts().get(i).getName()) + ml,
					clazz.getOrderAtts().get(i).getClazz().getName() + "." + clazz.getOrderAtts().get(i).getName()
							+ " ASC");

			sql += buildSQLFind(clazz, false, maxLevel, level,
					"_des_" + clazz.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(clazz.getOrderAtts().get(i).getName()) + ml,
					clazz.getOrderAtts().get(i).getClazz().getName() + "." + clazz.getOrderAtts().get(i).getName()
							+ " DESC");

		}

		return sql;

	}

	private static String buildSQLFind(Clazz clazzX, boolean limit, int maxLevel, int level, String orderByName,
			String orderBy) {

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
			sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + clazzX.getName() + orderByName
					+ "(\n\t\tlimitArg BIGINT\n\t\t, offsetArg BIGINT\n" + argsSQL + "\n) CASCADE;";

			sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() + orderByName
					+ "(\n\t\tlimitArg BIGINT\n\t\t, offsetArg BIGINT\n" + argsSQL + "\n) RETURNS\n\n\tTABLE(";
		} else {
			sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + clazzX.getName() + orderByName + "(\n"
					+ argsSQL.replaceFirst(",", " ") + "\n) CASCADE;";

			sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.f_" + clazzX.getName() + orderByName + "(\n"
					+ argsSQL.replaceFirst(",", " ") + "\n) RETURNS\n\n\tTABLE(";
		}

		List<String> fieldsSQL = new ArrayList<String>();

		buildFunctionReturnSelectAtts(maxLevel, level, clazzX, fieldsSQL);

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

		sql += "\n\t) AS $$";

		sql += "\n\n\tSELECT";

		fieldsSQL = new ArrayList<String>();

		buildSelectAtts(maxLevel, level, clazzX, fieldsSQL);

		lengthMaxFieldsSQL = 0;

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
							+ clazzX.getName() + "." + arg.getName() + " = " + arg.getName() + "Arg" + countArgs + ")";

				} else {

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "FromArg" + countArgs + " IS NULL OR "
							+ clazzX.getName() + "." + arg.getName() + " >= " + arg.getName() + "FromArg" + countArgs
							+ ")";

					countArgs++;

					sc = " AND ";
					w = "\n\t";

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "ToArg" + countArgs + " IS NULL OR "
							+ clazzX.getName() + "." + arg.getName() + " <= " + arg.getName() + "ToArg" + countArgs
							+ ")";
				}

			} else if (arg.isString()) {

				if (arg.getSearchOption().equals(Argument.EQUALS)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR = TRIM(" + argName + ")::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR = TRIM(massoftware.TRANSLATE(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(LOWER(" + attName + "))::VARCHAR = TRIM(LOWER(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(LOWER(massoftware.TRANSLATE(" + attName
							+ ")))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE (TRIM(" + argName + ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE (TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE (TRIM(" + argName + ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE (TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

					String attName = clazzX.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

					String attName = clazzX.getName() + "." + arg.getName();
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

					String attName = clazzX.getName() + "." + arg.getName();
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

					String attName = clazzX.getName() + "." + arg.getName();
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

					String attName = clazzX.getName() + "." + arg.getName();
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

					String attName = clazzX.getName() + "." + arg.getName();
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

				String attName = clazzX.getName() + "." + arg.getName();
				String argName = arg.getName() + "Arg" + countArgs;
				String whereSQL = attName + " = TRIM(" + argName + ")::VARCHAR";

				argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName + ")) > 0 AND "
						+ whereSQL + "))";
			}
		}

		sql += argsSQL;

		sql += "\n\n\tORDER BY " + orderBy;

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
		if (limit) {
			sql += "\n\nSELECT * FROM massoftware.f_" + clazzX.getName() + orderByName + "(\n\t\t100\n\t\t, 0" + argsSQL
					+ "\n);";
		} else {
			sql += "\n\nSELECT * FROM massoftware.f_" + clazzX.getName() + orderByName + "("
					+ argsSQL.replaceFirst(",", "") + "\n);";
		}

		sql += "\n\n*/";

		return sql;
	}

	private static String buildSQLFindType(Clazz clazz) {

		// int maxLevel = this.maxLevel;
		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			if(i != 0) {
				sql += buildSQLFindType(clazz, i, level);	
			}
			
		}

		return sql;
	}

	private static String buildSQLFindType(Clazz clazz, int maxLevel, int level) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_level_" + maxLevel + "";
		}

		String sql = "";

		for (int i = 0; i < clazz.getOrderAtts().size(); i++) {

			String sqlItem = buildSQLFindType(clazz, true, maxLevel, level, ml);

			if (sql.contains(sqlItem) == false) {
				sql += sqlItem;
			}

		}

		return sql;

	}

	private static String buildSQLFindType(Clazz clazzX, boolean limit, int maxLevel, int level, String orderByName) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP TYPE IF EXISTS massoftware.type_" + clazzX.getName() + orderByName + " CASCADE;";

		sql += "\n\nCREATE TYPE massoftware.type_" + clazzX.getName() + orderByName + "(\n";

		List<String> fieldsSQL = new ArrayList<String>();

		buildFunctionReturnSelectAtts(maxLevel, level, clazzX, fieldsSQL);

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

		sql += "\n);";

		return sql;
	}

}
