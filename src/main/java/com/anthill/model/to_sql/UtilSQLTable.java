package com.anthill.model.to_sql;

import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.Unique;

public class UtilSQLTable {
	
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

		sql += UtilSQLTable.buildSQLTabla(clazz);

		// buildInsert();

		sql += buildSQLSelects(clazz);

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
	
	public static String buildSQLTabla(Clazz clazz) {

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

}
