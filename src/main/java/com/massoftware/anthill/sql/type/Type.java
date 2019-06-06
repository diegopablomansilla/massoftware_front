package com.massoftware.anthill.sql.type;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeClazz;
import com.massoftware.anthill.UtilAnthill;
import com.massoftware.anthill.UtilJavaPOJO;

public class Type {

	private String schemaName;
	private String name;
	private String table;
	private String returnName;
	private List<TypeField> fields = new ArrayList<TypeField>();

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

	public List<TypeField> getFields() {
		return fields;
	}

	public void setFields(List<TypeField> fields) {
		this.fields = fields;
	}

	// -----------------------------------------------------------------------------------------------

	private void buildFields(int maxLevel, int level, Clazz clazz, int levelCount, String prefix) {

		if (clazz._index == null) {
			clazz._index = 0;
		}

		TypeField field = new TypeField();
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

				field = new TypeField();
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

					field = new TypeField();
					// field.setTable(clazz.getName());

					if (clazz._index == 0) {
						field.setTable(clazz.getName());
					} else {
						field.setTable(clazz.getName() + "_" + clazz._index);
					}

					field.setName(att.getName());
					field.setDataType(UtilAnthill.ID_DATA_TYPE);
					// field.setDataType(UtilAnthill.ID_DATA_TYPE + "\t" +
					// att.getDataType().getNameSQL() + ".id ");
					field.setLevel(levelCount);
					field.setPath(prefix + "." + att.getName());
					fields.add(field);
				}

			}

		}

	}

	// =============================================================================================================

	public String toSQL(Clazz clazz) {

		// clazz._index = 0;

		schemaName = "massoftware";
		name = "t_" + clazz.getName();
		table = clazz.getName();
		returnName = clazz.getName();

		int maxLevel = UtilJavaPOJO.buildMapperDefaultLevel(clazz);
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {

			if (i != 0) {
				fields = new ArrayList<TypeField>();
				buildFields(i, level, clazz, 0, clazz.getName());
				sql += "\n" + toSQL(i, level);
			}

		}

		return sql;

	}

	private String toSQL(int maxLevel, int level) {
		String sql = "";

		// -------------------------------------------------------------------------

		sql += "\n";
		sql += "DROP TYPE IF EXISTS " + this.getSchemaName() + "." + this.getName() + "_" + maxLevel + " CASCADE;";

		// -------------------------------------------------------------------------

		sql += "\n\n";
		sql += "CREATE TYPE " + this.getSchemaName() + "." + this.getName() + "_" + maxLevel + " AS (";
		sql += "\n";

		// ----

		String s = "";
		String t = "";

		int cs = 0;
		int ct = 0;

		for (int i = 0; i < this.fields.size(); i++) {

			TypeField field = this.fields.get(i);

			String nameArg = field.getTable() + "_" + field.getName();

			if (cs < nameArg.length()) {
				cs = nameArg.length();
			}

			String typeArg = field.getDataType();

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

		String maxPath = "";

		for (int i = 0; i < this.fields.size(); i++) {

			TypeField field = this.fields.get(i);

			if (maxPath.length() < field.getPath().length()) {
				maxPath = field.getPath();
			}
		}

		for (int i = 0; i < this.fields.size(); i++) {

			TypeField field = this.fields.get(i);

			String nameArg = field.getTable() + "_" + field.getName();
			String typeArg = field.getDataType();

			nameArg += s.substring(nameArg.length() - 1, s.length() - 1);

			nameArg += "\t" + typeArg;

			nameArg += t.substring(typeArg.length() - 1, t.length() - 1) + "\t\t-- " + i + "\t" + field.getPath();

			sql += "\n\t";

			if (field.getLevel() > 0) {

				for (int j = 0; j < field.getLevel(); j++) {
					// sql += "\t";
				}
			}

			sql += (i == 0) ? "  " + nameArg : ", " + nameArg;

		}

		// ----

		sql += "\n\n";
		sql += ");";

		return sql;

	}

}
