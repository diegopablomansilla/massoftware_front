package com.anthill.model.to_sql;

import java.util.ArrayList;
import java.util.List;

import com.anthill.UtilAnthill;
import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeClazz;
import com.anthill.model.to_java.UtilJavaPOJO;

public class FunctionFind {

	private String schemaName;
	private String name;
	private String table;
	private String returnName;
	private List<FunctionFindField> fields = new ArrayList<FunctionFindField>();
	private List<FunctionFindFieldLEftJoin> fieldsLeftJoin = new ArrayList<FunctionFindFieldLEftJoin>();
	private List<FunctionFindArg> args = new ArrayList<FunctionFindArg>();

	// -----------------------------------------------------------------------------------------------

	public String getSchemaName() {
		return schemaName;
	}

	public void setSchemaName(String schemaName) {
		schemaName = (schemaName != null) ? schemaName.trim() : null;
		this.schemaName = (schemaName != null && schemaName.length() == 0) ? null : schemaName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		name = (name != null) ? name.trim() : null;
		this.name = (name != null && name.length() == 0) ? null : name;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		table = (table != null) ? table.trim() : null;
		this.table = (table != null && table.length() == 0) ? null : table;
	}

	public String getReturnName() {
		return returnName;
	}

	public void setReturnName(String returnName) {
		returnName = (returnName != null) ? returnName.trim() : null;
		this.returnName = (returnName != null && returnName.length() == 0) ? null : returnName;
	}

	public List<FunctionFindArg> getArgs() {
		return args;
	}

	public void setArgs(List<FunctionFindArg> args) {
		this.args = args;
	}

	public List<FunctionFindField> getFields() {
		return fields;
	}

	public void setFields(List<FunctionFindField> fields) {
		this.fields = fields;
	}

	public List<FunctionFindFieldLEftJoin> getFieldsLeftJoin() {
		return fieldsLeftJoin;
	}

	public void setFieldsLeftJoin(List<FunctionFindFieldLEftJoin> fieldsLeftJoin) {
		this.fieldsLeftJoin = fieldsLeftJoin;
	}

	// -----------------------------------------------------------------------------------------------

	private void buildArgs(Clazz clazz) {

		FunctionFindArg functionFindArg = new FunctionFindArg();
		functionFindArg.setName("id");
		functionFindArg.setDataType(UtilAnthill.ID_DATA_TYPE);
		functionFindArg.setCustom(false);
		args.add(functionFindArg);

		functionFindArg = new FunctionFindArg();
		functionFindArg.setName("orderBy");
		functionFindArg.setDataType("INTEGER");
		functionFindArg.setCustom(false);
		args.add(functionFindArg);

		functionFindArg = new FunctionFindArg();
		functionFindArg.setName("orderByDesc");
		functionFindArg.setDataType("BOOLEAN");
		functionFindArg.setCustom(false);
		args.add(functionFindArg);

		functionFindArg = new FunctionFindArg();
		functionFindArg.setName("limit");
		functionFindArg.setDataType("BIGINT");
		functionFindArg.setCustom(false);
		args.add(functionFindArg);

		functionFindArg = new FunctionFindArg();
		functionFindArg.setName("offSet");
		functionFindArg.setDataType("BIGINT");
		functionFindArg.setCustom(false);
		args.add(functionFindArg);

		for (int i = 0; i < clazz.getArgs().size(); i++) {

			Argument arg = clazz.getArgs().get(i);

			if (arg.getOnlyVisual() == true) {
				continue;
			}

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					functionFindArg = new FunctionFindArg();
					functionFindArg.setName(arg.getName());
					functionFindArg.setNameAtt(arg.getName());
					functionFindArg.setDataType(arg.getNameSQL());
					args.add(functionFindArg);

				} else {

					functionFindArg = new FunctionFindArg();
					functionFindArg.setName(arg.getName() + "From");
					functionFindArg.setNameAtt(arg.getName());
					functionFindArg.setDataType(arg.getNameSQL());
					functionFindArg.setOperator(">=");
					args.add(functionFindArg);

					functionFindArg = new FunctionFindArg();
					functionFindArg.setName(arg.getName() + "To");
					functionFindArg.setNameAtt(arg.getName());
					functionFindArg.setDataType(arg.getNameSQL());
					functionFindArg.setOperator("<=");
					args.add(functionFindArg);

				}

			} else if (arg.isString()) {

				functionFindArg = new FunctionFindArg();
				functionFindArg.setName(arg.getName());
				functionFindArg.setNameAtt(arg.getName());
				functionFindArg.setDataType(arg.getNameSQL());
				functionFindArg.setString(true);
				functionFindArg.setSearchOption(arg.getSearchOption());
				args.add(functionFindArg);

				// if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR)
				// || arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_TRASLATE)
				// || arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)
				// ||
				// arg.getSearchOption().equals(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE)
				// || arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND)
				// || arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)
				// || arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)
				// ||
				// arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE))
				// {
				//
				//// functionFindArg = new FunctionFindArg();
				//// functionFindArg.setName(arg.getName() + "Word" + 0);
				//// functionFindArg.setDataType(arg.getNameSQL());
				//// functionFindArg.setString(true);
				//// args.add(functionFindArg);
				////
				//// for (int j = 0; j < 4; j++) {
				////
				//// functionFindArg = new FunctionFindArg();
				//// functionFindArg.setName(arg.getName() + "Word" + (j + 1));
				//// functionFindArg.setDataType(arg.getNameSQL());
				//// functionFindArg.setString(true);
				//// args.add(functionFindArg);
				////
				//// }
				//
				// functionFindArg = new FunctionFindArg();
				// functionFindArg.setName(arg.getName());
				// functionFindArg.setNameAtt(arg.getName());
				// functionFindArg.setDataType(arg.getNameSQL());
				// functionFindArg.setString(true);
				// functionFindArg.setStringSplit(true);
				// args.add(functionFindArg);
				//
				// } else {
				//
				// functionFindArg = new FunctionFindArg();
				// functionFindArg.setName(arg.getName());
				// functionFindArg.setNameAtt(arg.getName());
				// functionFindArg.setDataType(arg.getNameSQL());
				// functionFindArg.setString(true);
				// args.add(functionFindArg);
				// }

			} else if (arg.isBoolean()) {

				functionFindArg = new FunctionFindArg();
				functionFindArg.setName(arg.getName());
				functionFindArg.setNameAtt(arg.getName());
				functionFindArg.setDataType(arg.getNameSQL());
				args.add(functionFindArg);

			} else if (arg.isSimple() == false) {

				functionFindArg = new FunctionFindArg();
				functionFindArg.setName(arg.getName());
				functionFindArg.setNameAtt(arg.getName());
				functionFindArg.setDataType(UtilAnthill.ID_DATA_TYPE);
				functionFindArg.setString(true);
				args.add(functionFindArg);

			}
		}
	}

	private void buildFields(int maxLevel, int level, Clazz clazz, int levelCount, String prefix) {

		if (clazz._index == null) {
			clazz._index = 0;
		}

		FunctionFindField field = new FunctionFindField();
		// field.setTable(clazz.getName());
		if (clazz._index == 0) {
			field.setTable(clazz.getName());
		} else {
			field.setTable(clazz.getName() + "_" + clazz._index);
		}

		field.setName("id");
		field.setDataType(UtilAnthill.ID_DATA_TYPE);
		field.setLevel(levelCount);
		field.setPath(prefix + "." + "id");
		fields.add(field);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				field = new FunctionFindField();
				// field.setTable(clazz.getName());

				if (clazz._index == 0) {
					field.setTable(clazz.getName());
				} else {
					field.setTable(clazz.getName() + "_" + clazz._index);
				}

				field.setName(att.getName());
				field.setDataType(att.getDataType().getNameSQL());
				field.setLevel(levelCount);
				field.setPath(prefix + "." + att.getName());
				fields.add(field);

			} else {

				if (level < maxLevel) {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					dataTypeClazz.getClazz()._index = fields.size();

					buildFields(maxLevel, (level + 1), dataTypeClazz.getClazz(), levelCount + 1,
							prefix + "." + dataTypeClazz.getClazz().getName());

				} else {

					field = new FunctionFindField();
					// field.setTable(clazz.getName());

					if (clazz._index == 0) {
						field.setTable(clazz.getName());
					} else {
						field.setTable(clazz.getName() + "_" + clazz._index);
					}

					field.setName(att.getName());
					field.setDataType(UtilAnthill.ID_DATA_TYPE + "\t" + att.getDataType().getNameSQL() + ".id ");
					field.setLevel(levelCount);
					field.setPath(prefix + "." + att.getName());
					fields.add(field);
				}

			}

		}

	}

	private void buildFieldsLeftJoin(int maxLevel, int level, Clazz clazz, int levelCount) {

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple() == false) {

				if (level < maxLevel) {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					FunctionFindFieldLEftJoin field = new FunctionFindFieldLEftJoin();
					field.setFk(true);
					// field.setTable(clazz.getName());

					if (clazz._index == null || clazz._index == 0) {
						field.setTable(clazz.getName());
					} else {
						field.setTable(clazz.getName() + "_" + clazz._index);
					}
					// field.setTable(clazz.getName() + "_" + clazz._index);

					field.setTableFk(dataTypeClazz.getClazz().getName());
					field.setName(att.getName());
					field.setLevel(levelCount);

					if (fieldsLeftJoin.size() == 0) {
						field.setIndex(1);
					} else {
						field.setIndex(fieldsLeftJoin.get(fieldsLeftJoin.size() - 1).getIndex() + 1);
					}

					dataTypeClazz.getClazz()._index = field.getIndex();

					field.setTableFkAlias(dataTypeClazz.getClazz().getName() + "_" + field.getIndex());

					fieldsLeftJoin.add(field);

					buildFieldsLeftJoin(maxLevel, (level + 1), dataTypeClazz.getClazz(), levelCount + 1);

				} else {
					FunctionFindFieldLEftJoin field = new FunctionFindFieldLEftJoin();
					field.setFk(false);
					if (fieldsLeftJoin.size() == 0) {
						field.setIndex(1);
					} else {
						field.setIndex(fieldsLeftJoin.get(fieldsLeftJoin.size() - 1).getIndex() + 1);
					}
					fieldsLeftJoin.add(field);
				}
			} else {
				FunctionFindFieldLEftJoin field = new FunctionFindFieldLEftJoin();
				field.setFk(false);
				if (fieldsLeftJoin.size() == 0) {
					field.setIndex(1);
				} else {
					field.setIndex(fieldsLeftJoin.get(fieldsLeftJoin.size() - 1).getIndex() + 1);
				}
				fieldsLeftJoin.add(field);
			}

		}

	}

	// =============================================================================================================

	public String toSQL(Clazz clazz) {

		// clazz._index = 0;

		schemaName = "massoftware";
		name = "f_" + clazz.getName();
		table = clazz.getName();
		returnName = clazz.getName();

		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {

			fields = new ArrayList<FunctionFindField>();
			fieldsLeftJoin = new ArrayList<FunctionFindFieldLEftJoin>();
			args = new ArrayList<FunctionFindArg>();

			buildArgs(clazz);
			buildFields(i, level, clazz, 0, "");
			buildFieldsLeftJoin(i, level, clazz, 0);

			sql += "\n" + toSQL(i, level);

		}

		return sql;

	}

	private String toSQL(int maxLevel, int level) {
		String sql = "";

		sql += toSQLFind(maxLevel, level);

		sql += "\n";

		sql += toSQLFindById(maxLevel, level);

		sql += "\n";

		sql += toSQLFindExecute(maxLevel, level);

		return sql;
	}

	private String toSQLFindById(int maxLevel, int level) {

		String sql = "";

		// -------------------------------------------------------------------------

		sql += "\n";
		sql += "DROP FUNCTION IF EXISTS " + this.getSchemaName() + "." + this.getName() + "ById";
		if (maxLevel > 0) {
			sql += "_" + maxLevel;
		}
		sql += " (idArg " + UtilAnthill.ID_DATA_TYPE + ") CASCADE;";

		// -------------------------------------------------------------------------

		sql += "\n\n";
		sql += "CREATE OR REPLACE FUNCTION " + this.getSchemaName() + "." + this.getName() + "ById";
		if (maxLevel > 0) {
			sql += "_" + maxLevel;
		}
		sql += " (idArg " + UtilAnthill.ID_DATA_TYPE + "";
		if (maxLevel == 0) {
			sql += ") RETURNS SETOF " + this.getSchemaName() + "." + this.getReturnName() + " AS $$";
		} else {
			sql += ") RETURNS SETOF " + this.getSchemaName() + ".t_" + this.getReturnName() + "_" + maxLevel + " AS $$";
		}

		sql += "\n\n";
		sql += "DECLARE";

		sql += "\n\n";
		sql += "BEGIN";
		sql += "\n";

		// ----

		sql += "\n\n\t";
		sql += "IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN";

		sql += "\n\t\t";
		sql += "RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';";

		sql += "\n\t";
		sql += "END IF;";

		sql += "\n\n\t";
		sql += "RETURN QUERY SELECT * FROM " + this.getSchemaName() + "." + this.getName() + "";
		if (maxLevel > 0) {
			sql += "_" + maxLevel;
		}
		sql += " (";
		for (int i = 0; i < this.args.size(); i++) {
			sql += (i == 0) ? " idArg " : ", null";
		}
		sql += "); ";

		// ----

		sql += "\n\n";
		sql += "END;";

		sql += "\n";
		sql += "$$ LANGUAGE plpgsql;";

		return sql;

	}

	private String toSQLFind(int maxLevel, int level) {
		String sql = "";

		String s = "";
		String t = "";

		int cs = 0;
		int ct = 0;

		for (int i = 0; i < this.args.size(); i++) {
			FunctionFindArg arg = this.args.get(i);

			String nameArg = "  " + arg.getName() + "Arg" + i;

			if (cs < nameArg.length()) {
				cs = nameArg.length();
			}

			if (ct < arg.getDataType().length()) {
				ct = arg.getDataType().length();
			}
		}

		for (int i = 0; i < cs; i++) {
			s += " ";
		}
		for (int i = 0; i < ct; i++) {
			t += " ";
		}

		// -------------------------------------------------------------------------

		sql += "\n";
		sql += "DROP FUNCTION IF EXISTS " + this.getSchemaName() + "." + this.getName();
		if (maxLevel > 0) {
			sql += "_" + maxLevel;
		}
		sql += " (";
		sql += "\n";

		// ----

		for (int i = 0; i < this.args.size(); i++) {
			FunctionFindArg arg = this.args.get(i);

			String nameArg = arg.getName() + "Arg" + i;

			nameArg += " " + s.substring(nameArg.length() - 1, s.length() - 1) + arg.getDataType()
					+ t.substring(arg.getDataType().length() - 1, t.length() - 1) + "\t-- " + i;

			sql += "\n\t";
			sql += (i == 0) ? "  " + nameArg : ", " + nameArg;
		}

		// ----

		sql += "\n\n";
		sql += ") CASCADE;";

		// -------------------------------------------------------------------------

		sql += "\n\n";
		sql += "CREATE OR REPLACE FUNCTION " + this.getSchemaName() + "." + this.getName();
		if (maxLevel > 0) {
			sql += "_" + maxLevel;
		}
		sql += " (";
		sql += "\n";

		for (int i = 0; i < this.args.size(); i++) {
			FunctionFindArg arg = this.args.get(i);

			String nameArg = arg.getName() + "Arg" + i;

			nameArg += " " + s.substring(nameArg.length() - 1, s.length() - 1) + arg.getDataType()
					+ t.substring(arg.getDataType().length() - 1, t.length() - 1) + "\t-- " + i;

			sql += "\n\t";
			sql += (i == 0) ? "  " + nameArg : ", " + nameArg;
		}

		sql += "\n\n";
		if (maxLevel == 0) {
			sql += ") RETURNS SETOF " + this.getSchemaName() + "." + this.getReturnName() + " AS $$";
		} else {
			sql += ") RETURNS SETOF " + this.getSchemaName() + ".t_" + this.getReturnName() + "_" + maxLevel + " AS $$";
		}

		sql += "\n\n";
		sql += "DECLARE";

		sql += "\n\n\t";
		sql += "sqlSrc TEXT = '';";
		sql += "\n\t";
		sql += "sqlSrcWhere TEXT = '';";
		sql += "\n\t";
		sql += "sqlSrcWhereCount INTEGER = 0;";
		sql += "\n\t";
		sql += "sqlSrcWhereCountOR INTEGER = 0;";
		sql += "\n\t";
		sql += "searchById BOOLEAN = false;";

		sql += "\n\t";
		sql += "words TEXT[];";
		sql += "\n\t";
		sql += "word TEXT = '';";

		sql += "\n\n";
		sql += "BEGIN";
		sql += "\n";

		// ----

		s = "";
		t = "";

		cs = 0;
		ct = 0;

		for (int i = 0; i < this.fields.size(); i++) {
			FunctionFindField field = this.fields.get(i);

			// String nameArg = field.getTable() + "." + field.getName();
			String nameArg = field.getTable() + "_" + i + "." + field.getName();

			if (cs < nameArg.length()) {
				cs = nameArg.length();
			}

			String typeArg = " AS " + field.getTable() + "_" + field.getName();

			if (ct < typeArg.length()) {
				ct = typeArg.length();
			}

		}

		for (int i = 0; i < cs; i++) {
			s += " ";
		}
		for (int i = 0; i < ct; i++) {
			t += " ";
		}

		sql += "\n\n\t";
		sql += "sqlSrc = '";

		sql += "\n\n\t\t";
		sql += "SELECT";

		String maxPath = "";

		for (int i = 0; i < this.fields.size(); i++) {
			FunctionFindField field = this.fields.get(i);

			if (maxPath.length() < field.getPath().length()) {
				maxPath = field.getPath();
			}
		}

		for (int i = 0; i < this.fields.size(); i++) {
			FunctionFindField field = this.fields.get(i);

			String nameArg = field.getTable() + "." + field.getName();
			// String nameArg = field.getTable() + "_" + i + "." + field.getName();

			String typeArg = " AS " + field.getTable() + "_" + field.getName();

			nameArg += " " + s.substring(nameArg.length() - 1, s.length() - 1) + typeArg
					+ t.substring(typeArg.length() - 1, t.length() - 1) + "\t-- " + i + "\t" + field.getPath();

			for (int j = 0; j < maxPath.length() - field.getPath().length() - 1; j++) {
				nameArg += " ";
			}

			// nameArg += maxPath.substring(field.getPath().length() - 1, maxPath.length() -
			// 1) + " " + field.getDataType();
			nameArg += "\t\t" + field.getDataType();

			sql += "\n\t\t\t\t";

			if (field.getLevel() > 0) {

				for (int j = 0; j < field.getLevel(); j++) {
					// sql += "\t";
				}
			}

			sql += (i == 0) ? "  " + nameArg : ", " + nameArg;

		}

		sql += "\n\n\t\t";
		sql += "FROM";
		sql += "\t";
		sql += this.getSchemaName() + "." + this.getTable();

		List<String> tmp = new ArrayList<String>();

		s = "";

		cs = 0;

		for (int i = 0; i < this.fieldsLeftJoin.size(); i++) {

			FunctionFindFieldLEftJoin field = this.fieldsLeftJoin.get(i);

			if (field.getFk() == true) {

				String f = "";

				// String nameArg = "LEFT JOIN massoftware." + field.getTableFk() + " ON " +
				// field.getTable() + "."
				// + field.getName() + " = " + field.getTableFk() + ".id";

				// String nameArg = "LEFT JOIN massoftware." + field.getTableFk();
				String nameArg = "LEFT JOIN massoftware." + field.getTableFk() + " AS " + field.getTableFkAlias();

				f += "\n\t\t\t";

				if (field.getLevel() > 0) {

					for (int j = 0; j < field.getLevel(); j++) {
						f += "\t";
					}
				}

				f += (i == 0) ? "" + nameArg : "" + nameArg;

				tmp.add(f);

				f = f.replace("\t", "------");

				if (cs < f.length()) {
					cs = f.length();
				}

			} else {
				tmp.add(null);
			}

		}

		for (int i = 0; i < cs; i++) {
			s += " ";
		}

		// for (int i = 0; i < this.fieldsLeftJoin.size(); i++) {
		// FunctionFindFieldLEftJoin field = this.fieldsLeftJoin.get(i);
		// field.setIndex(i);
		// }

		for (int i = 0; i < this.fieldsLeftJoin.size(); i++) {

			FunctionFindFieldLEftJoin field = this.fieldsLeftJoin.get(i);

			if (field.getFk() == true) {

				// String nameArg = tmp.get(i) + s.substring(tmp.get(i).length() - 1, s.length()
				// - 1) + " ON "
				// + field.getTable() + "." + field.getName() + " = " + field.getTableFk() +
				// ".id \t-- " + i;

				String nameArg = tmp.get(i);

				for (int j = 0; j < cs - nameArg.length() - 1; j++) {
					nameArg += " ";
				}

				// nameArg += " ON " + field.getTable() + "." + field.getName() + " = " +
				// field.getTableFk() + ".id \t-- t_"
				// + (field.getLevel() + 1) + "_" + field.getIndex();

				nameArg += " ON " + field.getTable() + "." + field.getName() + " = " + field.getTableFkAlias()
						+ ".id \t-- " + field.getIndex() + " LEFT LEVEL: " + (field.getLevel() + 1);

				sql += nameArg;

			}

		}

		sql += "\n\n\t";
		sql += "';";

		// ----

		sql += "\n\n\t";
		sql += "IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN";

		sql += "\n\t\t";
		sql += "sqlSrcWhere = sqlSrcWhere || ' " + this.getTable() + ".id = ''' || TRIM(idArg0) || '''';";

		sql += "\n\t\t";
		sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		sql += "\n\t\t";
		sql += "searchById = true;";

		sql += "\n\t";
		sql += "END IF;";

		for (int i = 0; i < this.args.size(); i++) {

			FunctionFindArg arg = this.args.get(i);

			String nameArg = arg.getName() + "Arg" + i;

			// nameArg += " " + s.substring(nameArg.length() - 1, s.length() - 1) +
			// arg.getDataType()
			// + t.substring(arg.getDataType().length() - 1, t.length() - 1) + "\t-- " + i;

			if (arg.getCustom() == true) {

				sql += "\n\n\t";

				sql += "IF searchById = false AND " + nameArg + " IS NOT NULL";

				if (arg.getString() == true) {
					sql += " AND CHAR_LENGTH(TRIM(" + nameArg + ")) > 0";
				}

				sql += " THEN";

				// sql += "\n\n\t\t";
				// sql += "IF sqlSrcWhereCount > 0 THEN";
				// sql += "\n\t\t\t";
				// sql += "sqlSrcWhere = sqlSrcWhere || ' AND ';";
				// sql += "\n\t\t";
				// sql += "END IF;";

				if (arg.getString() == true) {
					sql += buildStringWhere(arg, nameArg);
				} else {
					sql += "\n\t\t";
					sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";
					sql += "\n\t\t";
					sql += "sqlSrcWhere = sqlSrcWhere || ' " + this.getTable() + "." + arg.getNameAtt() + " "
							+ arg.getOperator() + " ' || " + nameArg + ";";
					sql += "\n\t\t";
					sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";
				}

				sql += "\n\t";
				sql += "END IF;";

			}

		}

		sql += "\n\n\t";
		sql += "IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN";

		sql += "\n\t\t";
		sql += "sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;";

		sql += "\n\t";
		sql += "END IF;";

		sql += "\n\n\t";
		sql += "IF searchById = false AND orderByArg1 IS NOT NULL AND orderByArg1 > -1 THEN";

		sql += "\n\t\t";
		sql += "sqlSrc = sqlSrc || ' ORDER BY ' || orderByArg1;";

		sql += "\n\t";
		sql += "ELSEIF searchById = false THEN ";

		sql += "\n\t\t";
		sql += "sqlSrc = sqlSrc || ' ORDER BY 1 ';";

		sql += "\n\t";
		sql += "END IF;";

		sql += "\n\n\t";
		sql += "IF searchById = false AND orderByDescArg2 IS NOT NULL AND orderByDescArg2 = true THEN";

		sql += "\n\t\t";
		sql += "sqlSrc = sqlSrc || ' DESC ';";

		sql += "\n\t";
		sql += "END IF;";

		// ------------------------

		// sql += "\n\n\t";
		// sql += "IF searchById = false AND limitArg2 IS NOT NULL AND (limitArg2 < 1 OR
		// limitArg2 > 100) THEN";
		//
		// sql += "\n\t\t";
		// sql += "limitArg2 = 100;";
		//
		// sql += "\n\t";
		// sql += "END IF;";
		//
		// sql += "\n\n\t";
		// sql += "IF searchById = false AND offSetArg3 IS NOT NULL AND offSetArg3 < 0
		// THEN";
		//
		// sql += "\n\t\t";
		// sql += "offSetArg3 = 0;";
		//
		// sql += "\n\t";
		// sql += "END IF;";

		sql += "\n\n\t";
		sql += "IF searchById = false AND limitArg3 IS NOT NULL AND offSetArg4 IS NOT NULL AND limitArg3 > 0 AND limitArg3 <= 100 AND offSetArg4 >= 0 THEN";

		sql += "\n\t\t";
		sql += "sqlSrc = sqlSrc || ' LIMIT ' || limitArg3 || ' OFFSET ' || offSetArg4;";

		// sql += "\n\t";
		// sql += "ELSE IF searchById = false THEN ";
		//
		// sql += "\n\t\t";
		// sql += "sqlSrc = sqlSrc || ' LIMIT limitArg2 OFFSET offSetArg3 ';";

		sql += "\n\t";
		sql += "END IF;";

		// --------------------------

		sql += "\n\n\t";
		sql += "-- RAISE EXCEPTION 'information messagess % ', sqlSrc;";

		sql += "\n\n\t";
		sql += "RETURN QUERY EXECUTE sqlSrc || ';';";

		// ----

		sql += "\n\n";
		sql += "END;";

		sql += "\n";
		sql += "$$ LANGUAGE plpgsql;";

		return sql;

	}

	private String toSQLFindExecute(int maxLevel, int level) {

		String sql = "";

		// -------------------------------------------------------------------------

		// ----

		sql += "\n\n";
		sql += "-- ";
		sql += "SELECT * FROM " + this.getSchemaName() + "." + this.getName() + "";
		if (maxLevel > 0) {
			sql += "_" + maxLevel;
		}
		sql += " (";
		for (int i = 0; i < this.args.size(); i++) {
			sql += (i == 0) ? " null " : ", null";
		}
		sql += "); ";		

		// ----

		sql += "\n\n";
		sql += "-- ";
		sql += "SELECT * FROM " + this.getSchemaName() + "." + this.getName() + "ById";
		if (maxLevel > 0) {
			sql += "_" + maxLevel;
		}
		sql += " ('xxx'); ";

		// ----

		return sql;

	}

	private String buildStringWhere(FunctionFindArg arg, String nameArg) {
		String sql = "";

		if (arg.getSearchOption().equalsIgnoreCase(Argument.EQUALS)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += " = ''' || ";
			sql += nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.EQUALS_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() + ",\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " = ''' || ";
			sql += nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.EQUALS_IGNORE_CASE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "LOWER(" + this.getTable() + "." + arg.getNameAtt() + ")";
			sql += " = ''' || ";
			sql += nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(LOWER(" + this.getTable() + "." + arg.getNameAtt() + "),\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " = ''' || ";
			sql += nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.STARTS_WITCH)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += " LIKE ' || ";
			// sql += "'''%' || " + nameArg + " || '%'''";
			sql += "'''' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.STARTS_WITCH_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() + ",\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.STARTS_WITCH_IGNORE_CASE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "LOWER(" + this.getTable() + "." + arg.getNameAtt() + ")";
			sql += " LIKE ' || ";
			sql += "'''' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(LOWER(" + this.getTable() + "." + arg.getNameAtt() + "),\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.ENDS_WITCH)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.ENDS_WITCH_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() + ",\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.ENDS_WITCH_IGNORE_CASE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "LOWER(" + this.getTable() + "." + arg.getNameAtt() + ")";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(LOWER(" + this.getTable() + "." + arg.getNameAtt() + "),\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || ''''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() + ",\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_IGNORE_CASE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "LOWER(" + this.getTable() + "." + arg.getNameAtt() + ")";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(LOWER(" + this.getTable() + "." + arg.getNameAtt() + "),\n\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || " + nameArg + " || '%'''";
			sql += ";";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_OR)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || '('; ";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCountOR > 0 THEN sqlSrcWhere = sqlSrcWhere || ' OR '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCountOR = sqlSrcWhereCountOR + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ')'; ";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCountOR = 0;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_OR_TRASLATE)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || '('; ";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCountOR > 0 THEN sqlSrcWhere = sqlSrcWhere || ' OR '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			// sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() + ",\n\t\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCountOR = sqlSrcWhereCountOR + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ')'; ";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCountOR = 0;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_OR_IGNORE_CASE)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || '('; ";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCountOR > 0 THEN sqlSrcWhere = sqlSrcWhere || ' OR '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "LOWER(" + this.getTable() + "." + arg.getNameAtt() + ")";
			// sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() +
			// ",\n\t\t\t\t'" + Argument.TRASLATE_A + "',\n\t\t\t\t'" + Argument.TRASLATE_B
			// + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCountOR = sqlSrcWhereCountOR + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ')'; ";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCountOR = 0;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_OR_IGNORE_CASE_TRASLATE)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || '('; ";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCountOR > 0 THEN sqlSrcWhere = sqlSrcWhere || ' OR '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(LOWER(" + this.getTable() + "." + arg.getNameAtt() + "),\n\t\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCountOR = sqlSrcWhereCountOR + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

			sql += "\n\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ')'; ";

			sql += "\n\t\t";
			sql += "sqlSrcWhereCountOR = 0;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_AND)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

			return sql;

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRIM(" + nameArg + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			// sql += "" + this.getTable() + "." + arg.getNameAtt() + "";
			sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() + ",\n\t\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "LOWER(" + this.getTable() + "." + arg.getNameAtt() + ")";
			// sql += "TRANSLATE(" + this.getTable() + "." + arg.getNameAtt() +
			// ",\n\t\t\t\t'" + Argument.TRASLATE_A + "',\n\t\t\t\t'" + Argument.TRASLATE_B
			// + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

		} else if (arg.getSearchOption().equalsIgnoreCase(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

			sql += "\n\t\t";
			sql += nameArg + " = REPLACE(" + nameArg + ", '''', '''''')";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = LOWER(TRIM(" + nameArg + "))";
			sql += ";";

			sql += "\n\t\t";
			sql += nameArg + " = TRANSLATE(" + nameArg + ",\n\t\t\t" + Argument.TRASLATE_A + ",\n\t\t\t "
					+ Argument.TRASLATE_B + ")";
			sql += ";";

			sql += "\n\t\t";
			sql += "words = regexp_split_to_array(" + nameArg + ", ' ')";
			sql += ";";

			sql += "\n\t\t";
			sql += "FOREACH word IN ARRAY words";
			sql += "\n\t\t";
			sql += "LOOP";

			sql += "\n\t\t\t";
			sql += "IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN";

			sql += "\n\t\t\t\t";
			sql += "word = TRIM(word)";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhere = sqlSrcWhere || ' ";
			sql += "TRANSLATE(LOWER(" + this.getTable() + "." + arg.getNameAtt() + "),\n\t\t\t\t'" + Argument.TRASLATE_A
					+ "',\n\t\t\t\t'" + Argument.TRASLATE_B + "')";
			sql += " LIKE ' || ";
			sql += "'''%' || word || '%'''";
			sql += ";";

			sql += "\n\t\t\t\t";
			sql += "sqlSrcWhereCount = sqlSrcWhereCount + 1;";

			sql += "\n\t\t\t";
			sql += "END IF;";

			sql += "\n\t\t";
			sql += "END LOOP;";

		}

		return sql;
	}

}
