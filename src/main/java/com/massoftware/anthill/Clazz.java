package com.massoftware.anthill;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.massoftware.windows.UtilUI;

public class Clazz {

	private int maxLevel = 2;

	private String name;
	private String singular;
	private String plural;
	private String singularPre;
	private String pluralPre;
	private List<Att> atts = new ArrayList<Att>();
	private List<Argument> args = new ArrayList<Argument>();
	private List<Order> orderAtts = new ArrayList<Order>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSingular() {
		return singular;
	}

	public void setSingular(String singular) {
		this.singular = singular;
	}

	public String getPlural() {
		return plural;
	}

	public void setPlural(String plural) {
		this.plural = plural;
	}

	public String getSingularPre() {
		return singularPre;
	}

	public void setSingularPre(String singularPre) {
		this.singularPre = singularPre;
	}

	public String getPluralPre() {
		return pluralPre;
	}

	public void setPluralPre(String pluralPre) {
		this.pluralPre = pluralPre;
	}

	public List<Att> getAtts() {
		return atts;
	}

	public void setAtts(List<Att> atts) {
		this.atts = atts;
	}

	public boolean addAtt(Att e) {
		e.setClazz(this);
		return atts.add(e);
	}

	public List<Argument> getArgs() {
		return args;
	}

	public void setArgs(List<Argument> args) {
		this.args = args;
	}

	public boolean addArgument(Att att) {
		return args.add(new Argument(att));
	}

	public boolean addArgument(Att att, Boolean range) {
		return args.add(new Argument(att, range));
	}

	public boolean addArgument(Att att, String searchOption) {
		return args.add(new Argument(att, searchOption));
	}

	public List<Order> getOrderAtts() {
		return orderAtts;
	}

	public void setOrderAtts(List<Order> orderAtts) {
		this.orderAtts = orderAtts;
	}

	public boolean addOrder(Att att) {
		return orderAtts.add(new Order(att));
	}

	// public boolean addOrder(Att att, Boolean desc) {
	// return orderAtts.add(new Order(att, desc));
	// }

	////////////////////////////////////////////////////////////////////////////////////////////////

	private void buildSelectAtts(int levelMax, int level, Clazz clazz, List<String> fields) {

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

	private void buildSelectAttsLeftJoin(int levelMax, int level, Clazz clazz, List<String> fields) {

		String sqlField = "";

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple() == false) {

				if (level < levelMax) {

					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					sqlField = "LEFT JOIN massoftware." + dataTypeClazz.getClazz().getName() + " ON " + clazz.getName()
							+ ".id = " + dataTypeClazz.getClazz().getName() + ".id";

					fields.add(sqlField);

					buildSelectAttsLeftJoin(levelMax, (level + 1), dataTypeClazz.getClazz(), fields);
				}
			} else {

				fields.add("");

			}

		}

	}

	private void buildFunctionReturnSelectAtts(int levelMax, int level, Clazz clazz, List<String> fields) {

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

	public String toJava() {

		String java = "package com.massoftware.model;";

		java += "\n\nimport com.massoftware.backend.annotation.ClassLabelAnont;";
		java += "\nimport com.massoftware.backend.annotation.FieldConfAnont;";

		java += "\n\n@ClassLabelAnont(singular = \"" + this.getSingular() + "\", plural = \"" + this.getPlural()
				+ "\", singularPre = \"" + this.getSingularPre() + "\", pluralPre = \"" + this.getPluralPre() + "\")";

		java += "\npublic class " + this.getName() + " extends EntityId {";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\t@FieldConfAnont(label = \"ID\")";
		java += "\n\tprivate String id;";

		for (Att att : this.getAtts()) {

			java += "\n\n\t// " + att.getLabel();

			String label = "label = \"" + att.getLabel() + "\"";
			String labelError = "labelError = \"\"";
			String unique = "unique = " + att.isUnique();
			String readOnly = "readOnly = " + att.isReadOnly();
			String required = "required = " + att.isRequired();
			String columns = "columns = 20f";
			String maxLength = "maxLength = " + att.getMaxLength();
			String minValue = "minValue = \"" + "" + "\"";
			String maxValue = "maxValue = \"" + "" + "\"";
			String mask = "mask = \"\"";

			if (att.getLabelError() != null) {
				labelError = "labelError = \"" + att.getLabelError() + "\"";
			}

			if (att.getColumns() != null) {
				columns = "columns = " + att.getColumns() + "f";
			}

			if (att.getMask() != null) {
				mask = "mask = \"" + att.getMask() + "\"";
			}

			if (att.isNumber()) {
				if (att.isInteger()) {
					DataTypeInteger dt = (DataTypeInteger) att.getDataType();
					if (dt.getMinValue() != null) {
						minValue = "minValue = \"" + dt.getMinValue() + "\"";
					} else {
						minValue = "minValue = \"" + Integer.MIN_VALUE + "\"";
					}
					if (dt.getMaxValue() != null) {
						maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
					} else {
						maxValue = "maxValue = \"" + Integer.MAX_VALUE + "\"";
					}

					if (att.getMaxLength() == null) {

						int length = 0;

						if (dt.getMinValue() != null) {
							length = dt.getMinValue().toString().length();
						} else if (dt.getMinValue() == null) {
							length = (Integer.MIN_VALUE + "").length();
						}

						if (dt.getMaxValue() != null) {
							if (length < dt.getMaxValue().toString().length()) {
								length = dt.getMaxValue().toString().length();
							}
						} else if (dt.getMaxValue() == null) {
							if (length < (Integer.MAX_VALUE + "").length()) {
								length = (Integer.MAX_VALUE + "").length();
							}
						}

						maxLength = "maxLength = " + length;

					}

				} else if (att.isLong()) {
					DataTypeLong dt = (DataTypeLong) att.getDataType();
					if (dt.getMinValue() != null) {
						minValue = "minValue = \"" + dt.getMinValue() + "\"";
					} else {
						minValue = "minValue = \"" + Long.MIN_VALUE + "\"";
					}
					if (dt.getMaxValue() != null) {
						maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
					} else {
						maxValue = "maxValue = \"" + Long.MAX_VALUE + "\"";
					}

					if (att.getMaxLength() == null) {

						int length = 0;

						if (dt.getMinValue() != null) {
							length = dt.getMinValue().toString().length();
						} else if (dt.getMinValue() == null) {
							length = (Long.MIN_VALUE + "").length();
						}

						if (dt.getMaxValue() != null) {
							if (length < dt.getMaxValue().toString().length()) {
								length = dt.getMaxValue().toString().length();
							}
						} else if (dt.getMaxValue() == null) {
							if (length < (Long.MAX_VALUE + "").length()) {
								length = (Long.MAX_VALUE + "").length();
							}
						}

						maxLength = "maxLength = " + length;

					}

				} else if (att.isDouble()) {
					DataTypeDouble dt = (DataTypeDouble) att.getDataType();
					if (dt.getMinValue() != null) {
						minValue = "minValue = \"" + dt.getMinValue() + "\"";
					} else {
						minValue = "minValue = \"" + Double.MIN_VALUE + "\"";
					}
					if (dt.getMaxValue() != null) {
						maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
					} else {
						maxValue = "maxValue = \"" + Double.MAX_VALUE + "\"";
					}

					if (att.getMaxLength() == null) {

						int length = 0;

						if (dt.getMinValue() != null) {
							length = dt.getMinValue().toString().length();
						} else if (dt.getMinValue() == null) {
							length = (Double.MIN_VALUE + "").length();
						}

						if (dt.getMaxValue() != null) {
							if (length < dt.getMaxValue().toString().length()) {
								length = dt.getMaxValue().toString().length();
							}
						} else if (dt.getMaxValue() == null) {
							if (length < (Double.MAX_VALUE + "").length()) {
								length = (Double.MAX_VALUE + "").length();
							}
						}

						maxLength = "maxLength = " + length;

					}

				} else if (att.isBigDecimal()) {
					DataTypeBigDecimal dt = (DataTypeBigDecimal) att.getDataType();
					if (dt.getMinValue() != null) {
						minValue = "minValue = \"" + dt.getMinValue() + "\"";
					}
					if (dt.getMaxValue() != null) {
						maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
					}

					if (att.getMaxLength() == null) {

						int length = 0;

						if (dt.getMinValue() != null) {
							length = dt.getMinValue().toString().length();
						}

						if (dt.getMaxValue() != null) {
							if (length < dt.getMaxValue().toString().length()) {
								length = dt.getMaxValue().toString().length();
							}
						}

						if (length > 0) {
							maxLength = "maxLength = " + length;
						}

					}

				}
			} else if (att.isString()) {
				minValue = "minValue = \"" + "" + "\"";
				maxValue = "maxValue = \"" + "" + "\"";
			} else if (att.isBoolean()) {
				minValue = "minValue = \"" + "" + "\"";
				maxValue = "maxValue = \"" + "" + "\"";
				maxLength = "maxLength = " + -1;
			} else if (att.isTimestamp()) {
				minValue = "minValue = \"" + "" + "\"";
				maxValue = "maxValue = \"" + "" + "\"";
				maxLength = "maxLength = " + -1;
			} else if (att.isSimple() == false) {
				minValue = "minValue = \"" + "" + "\"";
				maxValue = "maxValue = \"" + "" + "\"";
				maxLength = "maxLength = " + -1;
			}

			java += "\n\t@FieldConfAnont(" + label + ", " + labelError + ", " + unique + ", " + readOnly + ", "
					+ required + ", " + columns + ", " + maxLength + ", " + minValue + ", " + maxValue + ", " + mask
					+ ")";
			java += "\n\tprivate " + att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + "";

			if (att.isBoolean()) {
				java += " = false";
			}

			java += ";";

		}

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic " + this.getName() + "() {";
		java += "\n\t}";

		java += buildConstructorAtts();

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\t// GET ID";
		java += "\n\tpublic String getId() {";
		java += "\n\t\treturn this.id;";
		java += "\n\t}";

		java += "\n\t// SET ID";
		java += "\n\tpublic void setId(String id){";
		java += "\n\t\tid = (id != null) ? id.trim() : null;";
		java += "\n\t\tthis.id = (id != null && id.length() == 0) ? null : id;";
		java += "\n\t}";

		for (Att att : this.getAtts()) {

			if (att.isSimple() == false) {
				java += "\n\n\t// BUILD IF NULL AND GET " + att.getLabel();
				java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " build"
						+ att.getNameJavaUperCase() + "() {";

				java += "\n\t\tthis." + att.getName() + " = (this." + att.getName() + " == null) ? new "
						+ att.getDataType().getName() + "() : this." + att.getName() + ";";
				java += "\n\t\treturn this." + att.getName() + ";";
				java += "\n\t}";
			}

			java += "\n\n\t// GET " + att.getLabel();
			java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " get"
					+ att.getNameJavaUperCase() + "() {";

			if (att.isSimple()) {
				java += "\n\t\treturn this." + att.getName() + ";";
			} else {
				java += "\n\t\tthis." + att.getName() + " = (this." + att.getName() + " != null && this."
						+ att.getName() + ".getId() == null) ? null : this.moneda;";
				java += "\n\t\treturn this." + att.getName() + ";";
			}

			java += "\n\t}";

			java += "\n\n\t// SET " + att.getLabel();
			java += "\n\tpublic void set" + att.getNameJavaUperCase() + "("
					+ att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + " ){";

			if (att.isBoolean()) {
				java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " == null) ? false : " + att.getName()
						+ ";";
			} else if (att.isString()) {
				java += "\n\t\t" + att.getName() + " = (" + att.getName() + " != null) ? " + att.getName()
						+ ".trim() : null;";
				java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " != null && " + att.getName()
						+ ".length() == 0) ? null : " + att.getName() + ";";
			} else {
				java += "\n\t\tthis." + att.getName() + " = " + att.getName() + ";";
			}

			java += "\n\t}";

		}

		java += buildSetter();

		// java += "\n\n\t//
		// ---------------------------------------------------------------------------------------------------------------------------\n";
		//
		// java += "\n\n\t//
		// ---------------------------------------------------------------------------------------------------------------------------\n";
		//
		// java += "\n\n\t//
		// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n} // END CLASS ----------------------------------------------------------------------------------------------------------";

		return java;
	}

	private String buildConstructorAtts() {

		int maxLevel = this.maxLevel;
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildConstructorAtts(i, level);

			if (java.contains(java2) == false) {
				java += java2;
			}
		}

		return java;
	}

	private String buildConstructorAtts(int maxLevel, int level) {
		String java = "";

		java += "\n\n\tpublic " + this.getName() + "(";

		List<String> fieldsSQL = new ArrayList<String>();

		buildConstructorArgs(maxLevel, level, this, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {
				java += fieldsSQL.get(i) + i;
			} else {
				java += ", " + fieldsSQL.get(i) + i;
			}

		}

		java += ") {\n";

		///////////////////////////////////////////////////////

		java += "\n\t\tsetter(";

		fieldsSQL = new ArrayList<String>();

		buildSetterArgs(maxLevel, level, this, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {
				java += fieldsSQL.get(i) + i;
			} else {
				java += ", " + fieldsSQL.get(i) + i;
			}

		}

		java += ");";

		java += "\n\n\t}";

		return java;
	}

	private void buildConstructorArgs(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "String idArg";
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + "Arg";

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildConstructorArgs(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				}

			}

		}

	}

	private void buildSetterArgs(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "idArg";
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getName() + "Arg";

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildSetterArgs(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				}

			}

		}

	}

	private String buildSetter() {
		int maxLevel = this.maxLevel;
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildSetter(i, level);

			if (java.contains(java2) == false) {
				java += java2;
			}
		}

		return java;
	}

	private String buildSetter(int maxLevel, int level) {

		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic void setter(";

		List<String> fieldsSQL = new ArrayList<String>();

		buildConstructorArgs(maxLevel, level, this, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {
				java += fieldsSQL.get(i) + i;
			} else {
				java += ", " + fieldsSQL.get(i) + i;
			}

		}

		java += ") {\n";

		///////////////////////////////////////////////////////

		fieldsSQL = new ArrayList<String>();

		buildConstructorAtts(maxLevel, level, "", this, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			String[] paths = fieldsSQL.get(i).split("[.]");
			String path = "";

			for (int j = 0; j < paths.length; j++) {

				if (j == 0) {
					path += "this";
				} else if (j == paths.length - 1) {
					path += ".set" + toCamelStart(paths[j]) + "(" + paths[j] + "Arg" + i + ");";
				} else {
					path += ".build" + toCamelStart(paths[j]) + "()";
				}

			}

			java += "\n\t\t" + path;
		}

		java += "\n\n\t}";

		return java;
	}

	private void buildConstructorAtts(int maxLevel, int level, String source, Clazz clazz, List<String> fields) {

		String java = "";

		if (source.length() > 0) {
			java = source + "." + clazz.getName() + ".id";
		} else {
			java = clazz.getName() + ".id";
		}

		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				if (source.length() > 0) {
					java = source + "." + clazz.getName() + "." + att.getName();
				} else {
					java = clazz.getName() + "." + att.getName();
				}

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();

					if (source.length() > 0) {
						buildConstructorAtts(maxLevel, (level + 1), source + "." + clazz.getName(),
								dataTypeClazz.getClazz(), fields);
					} else {
						buildConstructorAtts(maxLevel, (level + 1), clazz.getName(), dataTypeClazz.getClazz(), fields);
					}
				}

			}

		}

	}

	private String buildAtt(Argument att) {
		String java = "";

		java += "\n\n\t// " + att.getLabel();

		String label = "label = \"" + att.getLabel() + "\"";
		String labelError = "labelError = \"\"";
		// String unique = "unique = " + att.isUnique();
		String readOnly = "readOnly = " + att.isReadOnly();
		String required = "required = " + att.isRequired();
		String columns = "columns = 20f";
		String maxLength = "maxLength = " + att.getMaxLength();
		String minValue = "minValue = \"" + "" + "\"";
		String maxValue = "maxValue = \"" + "" + "\"";
		String mask = "mask = \"\"";

		if (att.getLabelError() != null) {
			labelError = "labelError = \"" + att.getLabelError() + "\"";
		}

		if (att.getColumns() != null) {
			columns = "columns = " + att.getColumns() + "f";
		}

		if (att.getMask() != null) {
			mask = "mask = \"" + att.getMask() + "\"";
		}

		if (att.isNumber()) {
			if (att.isInteger()) {
				DataTypeInteger dt = (DataTypeInteger) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				} else {
					minValue = "minValue = \"" + Integer.MIN_VALUE + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				} else {
					maxValue = "maxValue = \"" + Integer.MAX_VALUE + "\"";
				}

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					} else if (dt.getMinValue() == null) {
						length = (Integer.MIN_VALUE + "").length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					} else if (dt.getMaxValue() == null) {
						if (length < (Integer.MAX_VALUE + "").length()) {
							length = (Integer.MAX_VALUE + "").length();
						}
					}

					maxLength = "maxLength = " + length;

				}

			} else if (att.isLong()) {
				DataTypeLong dt = (DataTypeLong) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				} else {
					minValue = "minValue = \"" + Long.MIN_VALUE + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				} else {
					maxValue = "maxValue = \"" + Long.MAX_VALUE + "\"";
				}

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					} else if (dt.getMinValue() == null) {
						length = (Long.MIN_VALUE + "").length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					} else if (dt.getMaxValue() == null) {
						if (length < (Long.MAX_VALUE + "").length()) {
							length = (Long.MAX_VALUE + "").length();
						}
					}

					maxLength = "maxLength = " + length;

				}

			} else if (att.isDouble()) {
				DataTypeDouble dt = (DataTypeDouble) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				} else {
					minValue = "minValue = \"" + Double.MIN_VALUE + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				} else {
					maxValue = "maxValue = \"" + Double.MAX_VALUE + "\"";
				}

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					} else if (dt.getMinValue() == null) {
						length = (Double.MIN_VALUE + "").length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					} else if (dt.getMaxValue() == null) {
						if (length < (Double.MAX_VALUE + "").length()) {
							length = (Double.MAX_VALUE + "").length();
						}
					}

					maxLength = "maxLength = " + length;

				}

			} else if (att.isBigDecimal()) {
				DataTypeBigDecimal dt = (DataTypeBigDecimal) att.getDataType();
				if (dt.getMinValue() != null) {
					minValue = "minValue = \"" + dt.getMinValue() + "\"";
				}
				if (dt.getMaxValue() != null) {
					maxValue = "maxValue = \"" + dt.getMaxValue() + "\"";
				}

				if (att.getMaxLength() == null) {

					int length = 0;

					if (dt.getMinValue() != null) {
						length = dt.getMinValue().toString().length();
					}

					if (dt.getMaxValue() != null) {
						if (length < dt.getMaxValue().toString().length()) {
							length = dt.getMaxValue().toString().length();
						}
					}

					if (length > 0) {
						maxLength = "maxLength = " + length;
					}

				}

			}
		} else if (att.isString()) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
		} else if (att.isBoolean()) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
			maxLength = "maxLength = " + -1;
		} else if (att.isTimestamp()) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
			maxLength = "maxLength = " + -1;
		} else if (att.isSimple() == false) {
			minValue = "minValue = \"" + "" + "\"";
			maxValue = "maxValue = \"" + "" + "\"";
			maxLength = "maxLength = " + -1;
		}

		java += "\n\t@FieldConfAnont(" + label + ", " + labelError + /* ", " + unique + */ ", " + readOnly + ", "
				+ required + ", " + columns + ", " + maxLength + ", " + minValue + ", " + maxValue + ", " + mask + ")";
		java += "\n\tprivate " + att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + "";

		if (att.isBoolean()) {
			java += " = false";
		}

		java += ";";

		return java;
	}

	public String toJavaFilter() {

		String java = "package com.massoftware.dao.model;";

		java += "\n\nimport com.massoftware.backend.annotation.FieldConfAnont;";
		java += "\nimport com.massoftware.model.Entity;";

		java += "\n\npublic class " + this.getName() + "Filtro extends Entity {";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\t@FieldConfAnont(label = \"Unlimited\")";
		java += "\n\tprivate Boolean unlimited = false;";

		java += "\n\n\t@FieldConfAnont(label = \"Limit\")";
		java += "\n\tprivate Integer limit;";

		java += "\n\n\t@FieldConfAnont(label = \"Offset\")";
		java += "\n\tprivate Integer offset;";

		java += "\n\n\t@FieldConfAnont(label = \"Order by att\")";
		java += "\n\tprivate String orderBy;";

		java += "\n\n\t@FieldConfAnont(label = \"Order by desc\")";
		java += "\n\tprivate Boolean orderByDesc = false;";

		java += "\n\n\t@FieldConfAnont(label = \"Level\")";
		java += "\n\tprivate Integer level = 0;";

		for (Argument arg : this.getArgs()) {

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {
					java += buildAtt(arg);
				} else {

					String name = arg.getName();
					String label = arg.getLabel();
					String labelError = arg.getLabelError();

					arg.setName(name + "From");
					arg.setLabel(label + " (desde)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildAtt(arg);
					arg.setName(name + "To");
					arg.setLabel(label + " (hasta)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildAtt(arg);

					arg.setName(name);
					arg.setLabel(label);
					arg.setLabelError(labelError);

				}
			} else {
				java += buildAtt(arg);
			}

		}

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\t// GET Unlimited";
		java += "\n\tpublic Boolean getUnlimited() {";
		java += "\n\t\treturn this.unlimited;";
		java += "\n\t}";

		java += "\n\n\t// SET Unlimited";
		java += "\n\tpublic void setUnlimited(Boolean unlimited){";
		java += "\n\t\tunlimited = (unlimited == null) ? false : unlimited;";
		java += "\n\t\tthis.unlimited = unlimited;";
		java += "\n\t}";

		java += "\n\n\t// GET Limit";
		java += "\n\tpublic Integer getLimit() {";
		java += "\n\t\treturn this.limit;";
		java += "\n\t}";

		java += "\n\n\t// SET Limit";
		java += "\n\tpublic void setLimit(Integer limit){";
		java += "\n\t\tlimit = (limit == null || limit < 1) ? 100 : limit;";
		java += "\n\t\tthis.limit = limit;";
		java += "\n\t}";

		java += "\n\n\t// GET Offset";
		java += "\n\tpublic Integer getOffset() {";
		java += "\n\t\treturn this.offset;";
		java += "\n\t}";

		java += "\n\n\t// SET Offset";
		java += "\n\tpublic void setOffset(Integer offset){";
		java += "\n\t\toffset = (offset == null || offset < 0) ? 0 : offset;";
		java += "\n\t\tthis.offset = offset;";
		java += "\n\t}";

		java += "\n\n\t// GET Order by att";
		java += "\n\tpublic String getOrderBy() {";
		java += "\n\t\treturn this.orderBy;";
		java += "\n\t}";

		java += "\n\n\t// SET Order by att";
		java += "\n\tpublic void setOrderBy(String orderBy){";
		// java += "\n\t\torderBy = (orderBy == null) ? \"1\" : orderBy;";
		java += "\n\t\tthis.orderBy = orderBy;";
		java += "\n\t}";

		java += "\n\n\t// GET Order by desc";
		java += "\n\tpublic Boolean getOrderByDesc() {";
		java += "\n\t\treturn this.orderByDesc;";
		java += "\n\t}";

		java += "\n\n\t// SET Order by desc";
		java += "\n\tpublic void setOrderByDesc(Boolean orderByDesc){";
		java += "\n\t\torderByDesc = (orderByDesc == null) ? false : orderByDesc;";
		java += "\n\t\tthis.orderByDesc = orderByDesc;";
		java += "\n\t}";

		java += "\n\n\t// GET Level";
		java += "\n\tpublic Integer getLevel() {";
		java += "\n\t\treturn this.level;";
		java += "\n\t}";

		java += "\n\n\t// SET Level";
		java += "\n\tpublic void setLevel(Integer level){";
		java += "\n\t\tlevel = (level == null || level < 0) ? 0 : level;";
		java += "\n\t\tlevel = (level != null && level > 3) ? 3 : level;";
		java += "\n\t\tthis.level = level;";
		java += "\n\t}";

		for (Argument arg : this.getArgs()) {

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {
					java += buildGetSet(arg);
				} else {

					String name = arg.getName();
					String label = arg.getLabel();
					String labelError = arg.getLabelError();

					arg.setName(name + "From");
					arg.setLabel(label + " (desde)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildGetSet(arg);
					arg.setName(name + "To");
					arg.setLabel(label + " (hasta)");
					if (labelError != null && labelError.trim().length() > 0) {
						arg.setLabelError(labelError + " (desde)");
					}
					java += buildGetSet(arg);

					arg.setName(name);
					arg.setLabel(label);
					arg.setLabelError(labelError);

				}
			} else {
				java += buildGetSet(arg);
			}
		}

		java += "\n\n} // END CLASS ----------------------------------------------------------------------------------------------------------";

		return java;
	}

	private String buildGetSet(Argument att) {
		String java = "";

		java += "\n\n\t// GET " + att.getLabel();
		java += "\n\tpublic " + att.getDataType().getName().replace("java.lang.", "") + " get"
				+ att.getNameJavaUperCase() + "() {";

		java += "\n\t\treturn this." + att.getName() + ";";

		java += "\n\t}";

		java += "\n\n\t// SET " + att.getLabel();
		java += "\n\tpublic void set" + att.getNameJavaUperCase() + "("
				+ att.getDataType().getName().replace("java.lang.", "") + " " + att.getName() + " ){";

		if (att.isBoolean()) {
			java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " == null) ? false : " + att.getName()
					+ ";";
		} else if (att.isString()) {
			java += "\n\t\tthis." + att.getName() + " = (" + att.getName() + " != null && " + att.getName()
					+ ".trim().length() == 0) ? null : " + att.getName() + ";";
		} else {
			java += "\n\t\tthis." + att.getName() + " = " + att.getName() + ";";
		}

		java += "\n\t}";

		return java;
	}

	public String toJavaDao() {

		String java = "package com.massoftware.dao;";

		java += "\n\nimport java.util.List;";
		java += "\nimport java.util.ArrayList;";
		java += "\nimport java.util.UUID;";
		java += "\nimport com.massoftware.backend.BackendContextPG;";
		java += "\nimport com.massoftware.dao.model." + this.getName() + "Filtro;";
		java += "\nimport com.massoftware.model." + this.getName() + ";";

		java += "\n\npublic class " + this.getName() + "DAO {";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic String insert(" + this.getName() + " obj) throws Exception {";

		java += "\n\n\t\tif(obj == null){";

		java += "\n\n\t\t\tthrow new IllegalArgumentException(\"Se esperaba un objeto " + this.getName()
				+ " no nulo.\");";

		java += "\n\n\t\t}";

		java += "\n";

		String args = "\n\t\tObject id = UUID.randomUUID().toString();";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			String sc = "\n\t\t";

			String n = "obj.get" + this.toCamelStart(att.getName()) + "()";

			if (att.isSimple()) {

				args += sc + "Object " + att.getName() + " = ( " + n + " == null ) ? "
						+ att.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

			} else {

				args += sc + "Object " + att.getName() + " = ( " + n + " != null && " + n + ".getId() != null) ? " + n
						+ ".getId() : String.class;";

			}
		}

		java += "\n";

		java += args;

		java += "\n";

		args = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			args += ", ?";
		}

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.i_" + this.getName() + "(?" + args + ")\";";

		java += "\n";

		args = "id";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			args += ", " + att.getName();
		}

		java += "\n\t\tObject[] args = new Object[] {" + args + "};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += "\n\n\t\t\tif(row.length == 1){";

		java += "\n\n\t\t\t\tBoolean ok = (Boolean) row[0];";

		java += "\n\n\t\t\t\tif(ok){";

		java += "\n\n\t\t\t\t\treturn id.toString();";

		java += "\n\n\t\t\t\t} else { ";

		java += "\n\n\t\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la sentencia no insertara en la base de datos.\");";

		java += "\n\n\t\t\t\t}";

		java += "\n\n\t\t\t} else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + row.length + \" columnas.\");";

		java += "\n\n\t\t\t}";

		java += "\n\n\t\t} else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		// java += "\n\n\t\treturn null;";

		java += "\n\n\t}";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic boolean deleteById(String id) throws Exception {";

		java += "\n";

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.d_" + this.getName() + "ById(?)\";";

		java += "\n";

		java += "\n\t\tObject[] args = new Object[] {id};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += "\n\n\t\t\treturn row[0].equals(true);";

		java += "\n\n\t\t} else if(table.length > 1 ) {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		java += "\n\n\t\treturn false;";

		java += "\n\n\t}";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic " + this.getName() + " findById(String id, Integer level) throws Exception {";

		java += "\n";
		java += "\n\t\t" + this.getName() + " obj = null;";

		java += "\n";

		java += "\n\t\tlevel = (level == null || level < 0) ? 0 : level;";
		java += "\n\t\tlevel = (level != null && level > 3) ? 3 : level;";

		java += "\n";

		java += "\n\t\tString levelString = (level > 0) ? \"_\" + level : \"\";";

		java += "\n";

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.f_" + this.getName()
				+ "ById\" + levelString + \"(?)\";";

		java += "\n";

		java += "\n\t\tObject[] args = new Object[] {id};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tif(table.length == 1){";

		java += "\n\n\t\t\tObject[] row = table[0];";

		java += buildMapperIfById();

		java += "\n\n\t\t} else if(table.length > 1 ) {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva \" + table.length + \" filas.\");";

		java += "\n\n\t\t}";

		java += "\n\n\t\treturn null;";

		java += "\n\n\t}";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += "\n\n\tpublic List<" + this.getName() + "> find(" + this.getName()
				+ "Filtro filtro) throws Exception {";

		java += "\n";
		java += "\n\t\tList<" + this.getName() + "> listado = new ArrayList<" + this.getName() + ">();";

		java += "\n";

		java += "\n\t\tString levelString = (filtro.getLevel() > 0) ? \"_\" + filtro.getLevel() : \"\";";

		java += "\n\t\tString orderByString = (filtro.getOrderBy() == null) ? \"\" : \"_\" + filtro.getOrderBy();";

		java += "\n\t\tString params = (filtro.getUnlimited() == true) ? \"\" : \"?, ?, \";";

		java += "\n";

		java += "\n\t\tString sql = \"SELECT * FROM massoftware.f_" + this.getName()
				+ "\" + orderByString + levelString + \"(\" + params + \"";

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += (i == 0) ? "?" : ", ?";

				} else {
					java += (i == 0) ? "?" : ", ?";
					java += (i == 0) ? "?" : ", ?";
				}

			} else if (arg.isString()) {
				/////////////////////////////////////// **********************************************

				if (arg.getSearchOption().equals(Argument.EQUALS)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

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

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						java += (i == 0) ? "?" : ", ?";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						java += (i == 0) ? "?" : ", ?";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						java += (i == 0) ? "?" : ", ?";
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

					java += (i == 0) ? "?" : ", ?";

					for (int j = 0; j < 4; j++) {

						java += (i == 0) ? "?" : ", ?";
					}

				}

				/////////////////////////////////////// **********************************************
			} else {
				java += (i == 0) ? "?" : ", ?";
			}
		}

		java += ")\";";

		args = "";

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			String sc = "\n\t\t";

			if (arg.isSimple()) {

				if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

					if (arg.getRange() == false) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "From()";

						args += sc + "Object " + arg.getName() + "From = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

						n = "filtro.get" + this.toCamelStart(arg.getName()) + "To()";

						args += sc + "Object " + arg.getName() + "To = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";
					}

				} else if (arg.isString()) {

					/////////////////////////////////////// **********************************************

					if (arg.getSearchOption().equals(Argument.EQUALS)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
								+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

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

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
								+ " == null ) ? new String[0] : " + n + ".split(\" \");";

						for (int j = 0; j < 5; j++) {

							args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
									+ "Words.length > " + j + " && " + arg.getName() + "Words[" + j
									+ "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
									+ arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						}

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
								+ " == null ) ? new String[0] : " + n + ".split(\" \");";

						for (int j = 0; j < 5; j++) {

							args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
									+ "Words.length > " + j + " && " + arg.getName() + "Words[" + j
									+ "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
									+ arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						}

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
								+ " == null ) ? new String[0] : " + n + ".split(\" \");";

						for (int j = 0; j < 5; j++) {

							args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
									+ "Words.length > " + j + " && " + arg.getName() + "Words[" + j
									+ "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
									+ arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						}

					} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

						String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

						args += "\n" + sc + "String[] " + arg.getName() + "Words = ( " + n
								+ " == null ) ? new String[0] : " + n + ".split(\" \");";

						for (int j = 0; j < 5; j++) {

							args += sc + "Object " + arg.getName() + "Word" + j + " = ( " + arg.getName()
									+ "Words.length > " + j + " && " + arg.getName() + "Words[" + j
									+ "].trim().length() > 0) ? " + arg.getName() + "Words[" + j + "].trim() : "
									+ arg.getDataType().getName().replace("java.lang.", "") + ".class;";
						}

					}

					/////////////////////////////////////// **********************************************

				} else {

					String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

					args += sc + "Object " + arg.getName() + " = ( " + n + " == null ) ? "
							+ arg.getDataType().getName().replace("java.lang.", "") + ".class : " + n + ";";

				}

			} else {

				String n = "filtro.get" + this.toCamelStart(arg.getName()) + "()";

				args += sc + "Object " + arg.getName() + " = ( " + n + " != null && " + n + ".getId() != null) ? " + n
						+ ".getId() : String.class;";

			}
		}

		java += "\n";

		java += args;

		String javaArgs = "";

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName() + "From";
					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName() + "To";
				}

			} else if (arg.isString()) {

				/////////////////////////////////////// **********************************************

				if (arg.getSearchOption().equals(Argument.EQUALS)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

					javaArgs += (i == 0) ? "" : ", ";
					javaArgs += arg.getName();

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

					for (int j = 0; j < 5; j++) {

						javaArgs += (i == 0) ? "" : ", ";
						javaArgs += arg.getName() + "Word" + j;
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_TRASLATE)) {

					for (int j = 0; j < 5; j++) {

						javaArgs += (i == 0) ? "" : ", ";
						javaArgs += arg.getName() + "Word" + j;
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE)) {

					for (int j = 0; j < 5; j++) {

						javaArgs += (i == 0) ? "" : ", ";
						javaArgs += arg.getName() + "Word" + j;
					}

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_WORDS_AND_IGNORE_CASE_TRASLATE)) {

					for (int j = 0; j < 5; j++) {

						javaArgs += (i == 0) ? "" : ", ";
						javaArgs += arg.getName() + "Word" + j;
					}

				}

				/////////////////////////////////////// **********************************************
			} else {
				javaArgs += (i == 0) ? "" : ", ";
				javaArgs += arg.getName();
			}

		}

		////////////////////////////////////////////////////////

		java += "\n";

		java += "\n\t\tObject[] args = null;";

		java += "\n\t\tif(filtro.getUnlimited()){";

		java += "\n\t\t\targs = new Object[] {" + javaArgs + "};";

		java += "\n\t\t} else {";

		java += "\n\t\t\targs = new Object[] {filtro.getLimit(), filtro.getOffset(), " + javaArgs + "};";

		java += "\n\t\t}";

		// java += "};";

		java += "\n\n\t\tObject[][] table = BackendContextPG.get().find(sql, args);";

		java += "\n\n\t\tfor(int i = 0; i < table.length; i++){";

		java += "\n\n\t\t\tObject[] row = table[i];";

		java += buildMapperIf();

		java += "\n\n\t\t}";

		java += "\n\n\t\treturn listado;";

		java += "\n\n\t}";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		java += buildMapper();

		java += "\n\n} // END CLASS ----------------------------------------------------------------------------------------------------------";

		return java;
	}

	private String buildMapperIfById() {

		int maxLevel = this.maxLevel;
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildMapperIfById(i, level);

			if (java.contains(java2) == false) {
				if (i == 0) {
					java += java2;
				} else {
					java += " else " + java2.trim();
				}

			}
		}

		java += " else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva una fila con  \" + row.length + \" columnas.\");";

		java += "\n\n\t\t\t}";

		return java;
	}

	private String buildMapperIfById(int maxLevel, int level) {

		String java = "";

		List<String> fieldsSQL = new ArrayList<String>();

		buildMapper(maxLevel, level, this, fieldsSQL);

		java += "\n\n\t\t\tif(row.length == " + fieldsSQL.size() + ") {";

		java += "\n\n\t\t\t\tobj = mapper" + fieldsSQL.size() + "Fields(row);";
		java += "\n\n\t\t\t\treturn obj;";

		java += "\n\n\t\t\t}";

		return java;
	}

	private String buildMapperIf() {

		int maxLevel = this.maxLevel;
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildMapperIf(i, level);

			if (java.contains(java2) == false) {
				if (i == 0) {
					java += java2;
				} else {
					java += " else " + java2.trim();
				}

			}
		}

		java += " else {";

		java += "\n\n\t\t\t\tthrow new IllegalStateException(\"No se esperaba que la consulta a la base de datos devuelva una fila con  \" + row.length + \" columnas.\");";

		java += "\n\n\t\t\t}";

		return java;
	}

	private String buildMapperIf(int maxLevel, int level) {

		String java = "";

		List<String> fieldsSQL = new ArrayList<String>();

		buildMapper(maxLevel, level, this, fieldsSQL);

		java += "\n\n\t\t\tif(row.length == " + fieldsSQL.size() + ") {";

		java += "\n\n\t\t\t\t" + this.getName() + " obj = mapper" + fieldsSQL.size() + "Fields(row);";
		java += "\n\n\t\t\t\tlistado.add(obj);";

		java += "\n\n\t\t\t}";

		return java;
	}

	private String buildMapper() {

		int maxLevel = this.maxLevel;
		int level = 0;

		String java = "";

		for (int i = 0; i <= maxLevel; i++) {
			String java2 = buildMapper(i, level);

			if (java.contains(java2) == false) {
				java += java2;
			}
		}

		return java;
	}

	private String buildMapper(int maxLevel, int level) {

		String java = "";

		java += "\n\n\t// ---------------------------------------------------------------------------------------------------------------------------\n";

		List<String> fieldsSQL = new ArrayList<String>();

		buildMapper(maxLevel, level, this, fieldsSQL);

		java += "\n\n\tprivate " + this.getName() + " mapper" + fieldsSQL.size() + "Fields(Object[] row) {";

		java += "\n\n\t\tint c = -1;\n";

		for (int i = 0; i < fieldsSQL.size(); i++) {

			java += "\n\t\t" + fieldsSQL.get(i);

		}

		java += "\n\n\t\t" + this.getName() + " obj = new " + this.getName() + "(";

		fieldsSQL = new ArrayList<String>();

		buildMapperArgs(maxLevel, level, this, fieldsSQL);

		for (int i = 0; i < fieldsSQL.size(); i++) {

			if (i == 0) {

				java += fieldsSQL.get(i);
			} else {
				java += ", " + fieldsSQL.get(i);
			}

		}

		java += ");";

		java += "\n\n\t\treturn obj;";

		java += "\n\n\t}";

		return java;
	}

	private void buildMapper(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "String id" + clazz.getName() + "Arg" + fields.size() + " = (String) row[++c];";
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getDataType().getName().replace("java.lang.", "") + " " + att.getName()
						+ att.getClazz().getName() + "Arg" + fields.size() + " = ("
						+ att.getDataType().getName().replace("java.lang.", "") + ") row[++c];";

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildMapper(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				}

			}

		}

	}

	private void buildMapperArgs(int maxLevel, int level, Clazz clazz, List<String> fields) {

		String java = "";

		java = "id" + clazz.getName() + "Arg" + fields.size();
		fields.add(java);

		for (int i = 0; i < clazz.getAtts().size(); i++) {

			Att att = clazz.getAtts().get(i);

			if (att.isSimple()) {

				java = att.getName() + att.getClazz().getName() + "Arg" + fields.size();

				fields.add(java);

			} else {

				if (level < maxLevel) {
					DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
					buildMapperArgs(maxLevel, (level + 1), dataTypeClazz.getClazz(), fields);
				}

			}

		}

	}

	/////////////////////////////////////////////////////////////////////////////////

	public String toJavaWListado() throws IOException {
		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("wlistado.txt");
		String path = url.toString().substring(6, url.toString().length());
		System.out.println(path);

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
			// System.out.println(linea);
		}
		b.close();

		source = source.replaceAll("NOMBRE_PAQUETE", this.getName().toLowerCase());
		source = source.replaceAll("NOMBRE_CLASE", this.getName());
		source = source.replaceAll("CONTROLES", buildWListadoControls());
		source = source.replaceAll("INSTANCE", buildWListadoControlsInstance());
		source = source.replaceAll("ADD", buildWListadoControlsInstanceAdd());
		source = source.replaceAll("COLUMNAS", buildWColumnsAdd());
		source = source.replaceAll("ANCHOS", buildWColumnsProperties());
		source = source.replaceAll("LOGICO", buildWColumnsPropertiesLogico());
		source = source.replaceAll("FECHA", buildWColumnsPropertiesDate());
		source = source.replaceAll("TIEMPO", buildWColumnsPropertiesTiempo());

		System.out.println(source);

		java += source;

		// java += buildWListadoPackage();
		// java += buildWListadoImports();
		// java += buildWListadoControls();
		// java += buildWListadoControlsInstance();

		return java;
	}

	// private String buildWListadoPackage() {
	// String java = "";
	//
	// java += "\n";
	// java += "package com.massoftware.windows." + this.getName().toLowerCase() +
	// ";";
	// java += "\n";
	//
	// return java;
	// }
	//
	// private String buildWListadoImports() {
	// String java = "";
	//
	// java += "\n";
	// java += "import com.massoftware.model." + this.getName() + ";";
	// java += "\n";
	// java += "import com.massoftware.dao.model." + this.getName() + "Filtro;";
	// java += "\n";
	// java += "import com.massoftware.dao." + this.getName() + "DAO;";
	// java += "\n";
	//
	// return java;
	// }
	//
	// private String buildWListadoClassName() {
	// String java = "";
	//
	// java += "\n";
	// java += "import com.massoftware.model." + this.getName() + ";";
	// java += "\n";
	// java += "import com.massoftware.dao.model." + this.getName() + "Filtro;";
	// java += "\n";
	// java += "import com.massoftware.dao." + this.getName() + "DAO;";
	// java += "\n";
	//
	// return java;
	// }

	private String buildWListadoControls() {
		String java = "";

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			String sc = "\n\t";

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + "private TextFieldBox " + arg.getName() + "TXTB;";

				} else {

					java += sc + "private TextFieldBox " + arg.getName() + "FromTXTB;";
					java += sc + "private TextFieldBox " + arg.getName() + "ToTXTB;";

				}

			} else if (arg.isString()) {

				java += sc + "private TextFieldBox " + arg.getName() + "TXTB;";

			} else if (arg.isBoolean()) {
				java += sc + "private OptionGroupEntityBoolean " + arg.getName() + "OPT;";
			} else if (arg.isSimple() == false) {
				java += sc + "private SelectorBox " + arg.getName() + "CBXB;";
			}
		}

		java += "\n";

		return java;
	}

	private String buildWListadoControlsInstance() {
		String java = "";

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			String sc = "\n\n\t\t// ------------------------------------------------------------------\n\n\t\t";

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + arg.getName() + "TXTB = new TextFieldBox(this, filterBI, \"" + arg.getName() + "\");";

				} else {

					java += sc + arg.getName() + "FromTXTB = new TextFieldBox(this, filterBI, \"" + arg.getName()
							+ "\");";
					java += sc + arg.getName() + "ToTXTB = new TextFieldBox(this, filterBI, \"" + arg.getName()
							+ "\");";

				}

			} else if (arg.isString()) {

				java += sc + arg.getName() + "TXTB = new TextFieldBox(this, filterBI, \"" + arg.getName() + "\");";

			} else if (arg.isBoolean()) {

				java += sc + arg.getName() + "OPT = new OptionGroupEntityBoolean(this, filterBI, " + arg.getName()
						+ ", \"Activas\", \"Obsoletas\", \"Todas\", true, 0)";

			} else if (arg.isSimple() == false) {
				java += sc + arg.getDataType().getName().replaceAll("java.lang", "") + " " + arg.getName()
						+ "Filtro = new " + arg.getName() + "Filtro();";
				java += sc + arg.getName() + "Filtro.setUnlimited(true);";
				java += sc + arg.getDataType().getName().replaceAll("java.lang", "") + "DAO " + arg.getName()
						+ "DAO = new " + arg.getName() + "DAO();";
				java += sc + "List<" + arg.getDataType().getName().replaceAll("java.lang", "") + ">" + arg.getName()
						+ "Lista = " + arg.getName() + "DAO.find(" + arg.getName() + "Filtro);";

				java += sc + arg.getName() + "CBXB = new ComboBoxBox(this, filterBI, \"" + arg.getName() + "\", "
						+ arg.getName() + "Lista" + ");";

				java += sc + "private SelectorBox " + arg.getName() + "CBXB;";
			}
		}

		java += "\n";

		return java;
	}

	private String buildWListadoControlsInstanceAdd() {
		String java = "";

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			String sc = (i == 0) ? "" : ", ";

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					java += sc + arg.getName() + "TXTB";

				} else {

					java += sc + arg.getName() + "FromTXTB";
					java += sc + arg.getName() + "ToTXTB";

				}

			} else if (arg.isString()) {

				java += sc + arg.getName() + "TXTB";

			} else if (arg.isBoolean()) {

				java += sc + arg.getName() + "OPT";

			} else if (arg.isSimple() == false) {

				java += sc + arg.getName() + "CBXB";
			}
		}

		return java;
	}

	private String buildWColumnsAdd() {
		String java = "\"id\", ";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			String sc = (i == 0) ? "" : ", ";

			java += sc + "\"" + att.getName() + "\"";

		}

		return java;
	}

	private String buildWColumnsProperties() {
		String java = "UtilUI.confColumn(itemsGRD.getColumn(\"id\"), true, true, true, -1);";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			String sc = "\n\n\t\t";

			String w = "-1";

			if (att.getColumns() != null) {
				w = att.getColumns().intValue() * 12 + "";
			}

			java += sc + "UtilUI.confColumn(itemsGRD.getColumn(\"" + att.getName() + "\"), true, " + w + ");";

		}

		return java;
	}

	private String buildWColumnsPropertiesLogico() {
		String java = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			if (att.isBoolean()) {
				String sc = "\n\n\t\t";

				java += sc + "itemsGRD.getColumn(\"" + att.getName()
						+ "\").setRenderer(new HtmlRenderer(), new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),FontAwesome.SQUARE_O.getHtml()));";
				;

			}

		}

		return java;
	}

	private String buildWColumnsPropertiesDate() {
		String java = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			if (att.isDate()) {
				String sc = "\n\n\t\t";

				java += sc + "itemsGRD.getColumn(\"" + att.getName()
						+ "\").setRenderer(new DateRenderer(new SimpleDateFormat(\"dd/MM/yyyy\")));";

			}

		}

		return java;
	}

	private String buildWColumnsPropertiesTiempo() {
		String java = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			if (att.isTimestamp()) {
				String sc = "\n\n\t\t";

				java += sc + "itemsGRD.getColumn(\"" + att.getName()
						+ "\").setRenderer(new DateRenderer(new SimpleDateFormat(\"dd/MM/yyyy HH:mm:ss\")));";

			}

		}

		return java;
	}

	/////////////////////////////////////////////////////////////////////////////////

	private String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	/////////////////////////////////////////////////////////////////////////////////

	public String toSQL() {

		String sql = "";

		sql += "\n-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////";
		sql += "\n-- //                                                                                                                        //";
		sql += "\n-- //          TABLA: ";
		sql += getName();
		int c = 25 + getName().length();
		int l = 128 - c;
		for (int i = 0; i < l; i++) {
			sql += " ";
		}
		sql += "//";
		sql += "\n-- //                                                                                                                        //";
		sql += "\n-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////";

		sql += "\n\n\n-- Table: massoftware." + getName();

		sql += buildSQLTabla();

		// buildInsert();

		sql += buildSQLSelects();

		// buildSelect();

		sql += buildSQLFindById();

		sql += buildSQLFind();

		sql += buildSQLDeleteById();

		sql += buildSQLInsert();

		return sql;
	}

	private String buildSQLTabla() {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";
		sql += "\n\nDROP TABLE IF EXISTS massoftware." + getName() + " CASCADE;";
		sql += "\n\nCREATE TABLE massoftware." + getName();
		sql += "\n(";

		sql += "\n\tid VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),";

		for (Att att : atts) {
			sql += "\n\t" + att.toSQL();
		}

		sql = "\n\n" + sql.trim().substring(0, sql.trim().length() - 1);

		sql += "\n);";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		for (Att att : atts) {

			if (att.isUnique() && att.isString()) {
				sql += "\n\nCREATE UNIQUE INDEX u_" + this.getName() + "_" + att.getName() + " ON massoftware."
						+ this.getName() + " (TRANSLATE(LOWER(TRIM(" + att.getName() + "))"
						+ "\n\t, '/\\\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'"
						+ "\n\t, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));";
			}
		}

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";
		sql += "\nDROP FUNCTION IF EXISTS massoftware.ftgFormat" + this.getName() + "() CASCADE;\n";
		sql += "\nCREATE OR REPLACE FUNCTION massoftware.ftgFormat" + this.getName() + "() RETURNS TRIGGER AS $format"
				+ this.getName() + "$";
		sql += "\nDECLARE";
		sql += "\nBEGIN";

		sql += "\n\t NEW.id := massoftware.white_is_null(NEW.id);";

		for (Att att : atts) {

			if (att.isString() || att.isSimple() == false) {
				sql += "\n\t NEW." + att.getName() + " := massoftware.white_is_null(NEW." + att.getName() + ");";
			}
		}

		sql += "\n\n\tRETURN NEW;";
		sql += "\nEND;";
		sql += "\n$format" + this.getName() + "$ LANGUAGE plpgsql;";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\nDROP TRIGGER IF EXISTS tgFormat" + this.getName() + " ON massoftware." + this.getName()
				+ " CASCADE;\n";
		sql += "\nCREATE TRIGGER tgFormat" + getName() + " BEFORE INSERT OR UPDATE";
		sql += "\n\tON massoftware." + getName() + " FOR EACH ROW";
		sql += "\n\tEXECUTE PROCEDURE massoftware.ftgFormat" + getName() + "();";

		return sql;
	}

	private String buildSQLSelects() {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\n\n-- SELECT COUNT(*) FROM massoftware." + getName() + ";";
		sql += "\n\n-- SELECT * FROM massoftware." + getName() + " LIMIT 100 OFFSET 0;";
		sql += "\n\n-- SELECT * FROM massoftware." + getName() + ";";
		sql += "\n\n-- SELECT * FROM massoftware." + getName() + " WHERE id = 'xxx';";

		return sql;
	}

	private String buildSQLFindById() {

		int maxLevel = this.maxLevel;
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			sql += buildSQLFindById(i, level);
		}

		return sql;
	}

	private String buildSQLFindById(int maxLevel, int level) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_" + maxLevel;
		}

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + this.getName() + "ById" + ml
				+ "(idArg VARCHAR(36)) CASCADE;";

		sql += "\n\nCREATE FUNCTION massoftware.f_" + this.getName() + "ById" + ml
				+ "(idArg VARCHAR(36)) RETURNS\n\tTABLE(";

		List<String> fieldsSQL = new ArrayList<String>();

		buildFunctionReturnSelectAtts(maxLevel, level, this, fieldsSQL);

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

		buildSelectAtts(maxLevel, level, this, fieldsSQL);

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

		sql += "\n\n\tFROM\tmassoftware." + getName();

		fieldsSQL = new ArrayList<String>();

		fieldsSQL.add("");

		buildSelectAttsLeftJoin(maxLevel, level, this, fieldsSQL);

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

		sql += "\n\n\tWHERE \tidArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + this.getName()
				+ ".id = TRIM(idArg)::VARCHAR;";

		sql += "\n\n$$ LANGUAGE SQL;";

		sql += "\n\n-- SELECT * FROM massoftware.f_" + this.getName() + "ById" + ml + "('xxx');";
		sql += "\n\n-- SELECT * FROM massoftware.f_" + this.getName() + "ById" + ml + "((SELECT " + this.getName()
				+ ".id FROM massoftware." + this.getName() + " LIMIT 1)::VARCHAR);";

		return sql;
	}

	private String buildSQLFind() {

		int maxLevel = this.maxLevel;
		int level = 0;

		String sql = "";

		for (int i = 0; i <= maxLevel; i++) {
			sql += buildSQLFind(i, level);
		}

		return sql;
	}

	private String buildSQLFind(int maxLevel, int level) {

		String ml = "";

		if (maxLevel > 0) {
			ml = "_" + maxLevel + "";
		}

		String sql = "";

		sql += buildSQLFind(false, maxLevel, level, ml, getName() + ".id");

		sql += buildSQLFind(true, maxLevel, level, ml, getName() + ".id");

		for (int i = 0; i < this.getOrderAtts().size(); i++) {

			sql += buildSQLFind(true, maxLevel, level,
					"_a_" + this.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(this.getOrderAtts().get(i).getName()) + ml,
					this.getOrderAtts().get(i).getClazz().getName() + "." + this.getOrderAtts().get(i).getName()
							+ " ASC");

			sql += buildSQLFind(true, maxLevel, level,
					"_d_" + this.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(this.getOrderAtts().get(i).getName()) + ml,
					this.getOrderAtts().get(i).getClazz().getName() + "." + this.getOrderAtts().get(i).getName()
							+ " DESC");

			sql += buildSQLFind(false, maxLevel, level,
					"_a_" + this.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(this.getOrderAtts().get(i).getName()) + ml,
					this.getOrderAtts().get(i).getClazz().getName() + "." + this.getOrderAtts().get(i).getName()
							+ " ASC");

			sql += buildSQLFind(false, maxLevel, level,
					"_d_" + this.getOrderAtts().get(i).getClazz().getName() + "_"
							+ toCamelStart(this.getOrderAtts().get(i).getName()) + ml,
					this.getOrderAtts().get(i).getClazz().getName() + "." + this.getOrderAtts().get(i).getName()
							+ " DESC");

		}

		return sql;

	}

	private String buildSQLFind(boolean limit, int maxLevel, int level, String orderByName, String orderBy) {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		String argsSQL = "";

		int countArgs = -1;

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

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
			sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + this.getName() + orderByName
					+ "(\n\t\tlimitArg BIGINT\n\t\t, offsetArg BIGINT\n" + argsSQL + "\n) CASCADE;";

			sql += "\n\nCREATE FUNCTION massoftware.f_" + this.getName() + orderByName
					+ "(\n\t\tlimitArg BIGINT\n\t\t, offsetArg BIGINT\n" + argsSQL + "\n) RETURNS\n\n\tTABLE(";
		} else {
			sql += "\n\nDROP FUNCTION IF EXISTS massoftware.f_" + this.getName() + orderByName + "(\n"
					+ argsSQL.replaceFirst(",", " ") + "\n) CASCADE;";

			sql += "\n\nCREATE FUNCTION massoftware.f_" + this.getName() + orderByName + "(\n"
					+ argsSQL.replaceFirst(",", " ") + "\n) RETURNS\n\n\tTABLE(";
		}

		List<String> fieldsSQL = new ArrayList<String>();

		buildFunctionReturnSelectAtts(maxLevel, level, this, fieldsSQL);

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

		buildSelectAtts(maxLevel, level, this, fieldsSQL);

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

		sql += "\n\n\tFROM\tmassoftware." + getName();

		fieldsSQL = new ArrayList<String>();

		fieldsSQL.add("");

		buildSelectAttsLeftJoin(maxLevel, level, this, fieldsSQL);

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

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			String sc = " AND ";

			String w = "\n\t";

			if (i == 0) {
				sc = "";
				w = "\n\n\tWHERE";
			}

			countArgs++;

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "Arg" + countArgs + " IS NULL OR " + this.getName()
							+ "." + arg.getName() + " = " + arg.getName() + "Arg" + countArgs + ")";

				} else {

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "FromArg" + countArgs + " IS NULL OR "
							+ this.getName() + "." + arg.getName() + " >= " + arg.getName() + "FromArg" + countArgs
							+ ")";

					countArgs++;

					sc = " AND ";
					w = "\n\t";

					argsSQL += w + "\t" + sc + "(" + arg.getName() + "ToArg" + countArgs + " IS NULL OR "
							+ this.getName() + "." + arg.getName() + " <= " + arg.getName() + "ToArg" + countArgs + ")";
				}

			} else if (arg.isString()) {

				if (arg.getSearchOption().equals(Argument.EQUALS)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR = TRIM(" + argName + ")::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR = TRIM(massoftware.TRANSLATE(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(LOWER(" + attName + "))::VARCHAR = TRIM(LOWER(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.EQUALS_IGNORE_CASE_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(LOWER(massoftware.TRANSLATE(" + attName
							+ ")))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE (TRIM(" + argName + ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE (TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE (TRIM(" + argName + ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.STARTS_WITCH_IGNORE_CASE_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE (TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName + "))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.ENDS_WITCH_IGNORE_CASE_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")))::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR LIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(massoftware.TRANSLATE(" + attName
							+ "))::VARCHAR LIKE ('%' || TRIM(massoftware.TRANSLATE(" + argName + ")) || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE)) {

					String attName = this.getName() + "." + arg.getName();
					String argName = arg.getName() + "Arg" + countArgs;
					String whereSQL = "TRIM(" + attName + ")::VARCHAR ILIKE ('%' || TRIM(" + argName
							+ ") || '%')::VARCHAR";

					argsSQL += w + "\t" + sc + "(" + argName + " IS NULL OR (CHAR_LENGTH(TRIM(" + argName
							+ ")) > 0 AND " + whereSQL + "))";

				} else if (arg.getSearchOption().equals(Argument.CONTAINS_IGNORE_CASE_TRASLATE)) {

					String attName = this.getName() + "." + arg.getName();
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

					String attName = this.getName() + "." + arg.getName();
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

					String attName = this.getName() + "." + arg.getName();
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

					String attName = this.getName() + "." + arg.getName();
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

					String attName = this.getName() + "." + arg.getName();
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

				String attName = this.getName() + "." + arg.getName();
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

		for (int i = 0; i < this.getArgs().size(); i++) {

			Argument arg = this.getArgs().get(i);

			String sc = "\n\t\t, ";

			// if (i == 0) {
			// sc = "\n\t\t";
			// }

			countArgs++;

			if (arg.isNumber() || arg.isTimestamp() || arg.isDate()) {

				if (arg.getRange() == false) {

					if (arg.isNumber()) {
						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + this.getName() + "_" + arg.getName()
								+ "Arg" + countArgs;
					} else if (arg.isTimestamp()) {
						argsSQL += sc + "now()::TIMESTAMP" + " -- " + this.getName() + "_" + arg.getName() + "Arg"
								+ countArgs;
					} else if (arg.isDate()) {
						argsSQL += sc + "now()::DATE" + " -- " + this.getName() + "_" + arg.getName() + "Arg"
								+ countArgs;
					}

				} else {

					if (arg.isNumber()) {
						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + this.getName() + "_" + arg.getName()
								+ "FromArg" + countArgs;
					} else if (arg.isTimestamp()) {
						argsSQL += sc + "now()::TIMESTAMP" + " -- " + this.getName() + "_" + arg.getName() + "FromArg"
								+ countArgs;
					} else if (arg.isDate()) {
						argsSQL += sc + "now()::DATE" + " -- " + this.getName() + "_" + arg.getName() + "FromArg"
								+ countArgs;
					}

					countArgs++;

					sc = "\n\t\t, ";

					if (arg.isNumber()) {
						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + this.getName() + "_" + arg.getName()
								+ "ToArg" + countArgs;
					} else if (arg.isTimestamp()) {
						argsSQL += sc + "now()::TIMESTAMP" + " -- " + this.getName() + "_" + arg.getName() + "ToArg"
								+ countArgs;
					} else if (arg.isDate()) {
						argsSQL += sc + "now()::DATE" + " -- " + this.getName() + "_" + arg.getName() + "ToArg"
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

					argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + this.getName() + "_" + arg.getName() + "Word"
							+ 0 + "Arg" + countArgs;

					for (int j = 0; j < 4; j++) {

						countArgs++;

						argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + this.getName() + "_" + arg.getName()
								+ "Word" + (j + 1) + "Arg" + countArgs;

					}

				} else {
					argsSQL += sc + "null::" + arg.getNameSQL() + " -- " + this.getName() + "_" + arg.getName() + "Arg"
							+ countArgs;
				}

			} else if (arg.isBoolean()) {
				argsSQL += sc + "false::" + arg.getNameSQL() + " -- " + this.getName() + "_" + arg.getName() + "Arg"
						+ countArgs;
			} else if (arg.isSimple() == false) {

				argsSQL += sc + "null::VARCHAR" + " -- " + this.getName() + "_" + arg.getName() + "Arg" + countArgs;
			}
		}

		sql += "\n\n/*";
		if (limit) {
			sql += "\n\nSELECT * FROM massoftware.f_" + this.getName() + orderByName + "(\n\t\t100\n\t\t, 0" + argsSQL
					+ "\n);";
		} else {
			sql += "\n\nSELECT * FROM massoftware.f_" + this.getName() + orderByName + "("
					+ argsSQL.replaceFirst(",", "") + "\n);";
		}

		sql += "\n\n*/";

		return sql;
	}

	private String buildSQLDeleteById() {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.d_" + this.getName() + "ById" + "(idArg VARCHAR(36)) CASCADE;";

		sql += "\n\nCREATE FUNCTION massoftware.d_" + this.getName() + "ById"
				+ "(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$\n\nBEGIN";

		sql += "\n\n\tIF ((SELECT COUNT(*) FROM massoftware." + getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + this.getName()
				+ ".id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN";

		sql += "\n\n\t\tRETURN false;";

		sql += "\n\n\tEND IF;";

		sql += "\n\n\tDELETE FROM massoftware." + getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + this.getName()
				+ ".id = TRIM(idArg)::VARCHAR;";

		sql += "\n\n\tRETURN ((SELECT COUNT(*) FROM massoftware." + getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + this.getName()
				+ ".id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;";

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\nEND;\n$$ LANGUAGE plpgsql;";

		sql += "\n\n-- SELECT * FROM massoftware.d_" + this.getName() + "ById" + "('xxx');";
		sql += "\n\n-- SELECT * FROM massoftware.d_" + this.getName() + "ById" + "((SELECT " + this.getName()
				+ ".id FROM massoftware." + this.getName() + " LIMIT 1)::VARCHAR);";

		return sql;
	}

	private String buildSQLInsert() {

		String sql = "";

		sql += "\n\n-- ---------------------------------------------------------------------------------------------------------------------------\n";

		String argsSQL = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

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

		sql += "\n\nDROP FUNCTION IF EXISTS massoftware.i_" + this.getName() + "(\n\t\t  idArg VARCHAR(36)\n" + argsSQL
				+ "\n) CASCADE;";

		sql += "\n\nCREATE FUNCTION massoftware.i_" + this.getName() + "(\n\t\t  idArg VARCHAR(36)\n" + argsSQL
				+ "\n) RETURNS BOOLEAN AS $$\n\nBEGIN";

		String attNames = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			attNames += (i == 0) ? att.getName() : ", " + att.getName();
		}

		argsSQL = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

			argsSQL += (i == 0) ? att.getName() + "Arg" : ", " + att.getName() + "Arg";

		}

		sql += "\n\n\tINSERT INTO massoftware." + this.getName() + "(id, " + attNames + ") VALUES (idArg, " + argsSQL
				+ ");";

		sql += "\n\n\tRETURN ((SELECT COUNT(*) FROM massoftware." + getName()
				+ " WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND " + this.getName()
				+ ".id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;";

		/////////////////////////////////////////////////////////////////////////////////////

		sql += "\n\nEND;\n$$ LANGUAGE plpgsql;";

		argsSQL = "";

		for (int i = 0; i < this.getAtts().size(); i++) {

			Att att = this.getAtts().get(i);

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
		sql += "\n\nSELECT * FROM massoftware.i_" + this.getName() + "(\n\t\tnull::VARCHAR(36)" + argsSQL + "\n);";

		sql += "\n\n*/";

		return sql;
	}

	// private void buildInsertAttsNames(Clazz clazz, List<String> fields) {
	//
	// String sqlField = "id";
	// fields.add(sqlField);
	//
	// for (int i = 0; i < clazz.getAtts().size(); i++) {
	//
	// Att att = clazz.getAtts().get(i);
	//
	// if (att.isSimple()) {
	//
	// sqlField = att.getName();
	// fields.add(sqlField);
	//
	// } else {
	// DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
	// sqlField = dataTypeClazz.getClazz().getName();
	// fields.add(sqlField);
	// }
	//
	// }
	//
	// }
	//
	// private void buildInsertAttsValues(Clazz clazz, List<String> fields) {
	//
	// String sqlField = "'ID_' || i";
	// fields.add(sqlField);
	//
	// for (int i = 0; i < clazz.getAtts().size(); i++) {
	//
	// Att att = clazz.getAtts().get(i);
	//
	// if (att.isSimple()) {
	//
	// if (att.isString()) {
	//
	// if (att.getMaxLength() != null) {
	// // sqlField = "(SELECT (random() * " + att.getMaxLength() + " +
	// // 1)::INTEGER)::VARCHAR";
	// // sqlField = "'" + att.getName() + "_' || i";
	// sqlField = "(SELECT substring(uuid_generate_v4()::varchar from 0 for " +
	// att.getMaxLength()
	// + ")::VARCHAR)";
	// } else {
	// sqlField = "'" + att.getName() + "_' || i";
	// }
	// } else if (att.isInteger()) {
	// String min = "1";
	// String max = "cant";
	//
	// if (((DataTypeInteger) att.getDataType()).getMinValue() != null) {
	// min = ((DataTypeInteger) att.getDataType()).getMinValue().toString();
	// }
	// if (((DataTypeInteger) att.getDataType()).getMaxValue() != null) {
	// max = ((DataTypeInteger) att.getDataType()).getMaxValue().toString();
	// }
	//
	// if (((DataTypeInteger) att.getDataType()).getMinValue() != null
	// || ((DataTypeInteger) att.getDataType()).getMaxValue() != null) {
	// sqlField = "(SELECT massoftware.random_between(" + min + ", " + max + "))";
	// } else {
	// sqlField = "i";
	// }
	//
	// sqlField = "i";
	// } else if (att.isLong()) {
	// String min = "1";
	// String max = "cant";
	//
	// if (((DataTypeLong) att.getDataType()).getMinValue() != null) {
	// min = ((DataTypeLong) att.getDataType()).getMinValue().toString();
	// }
	// if (((DataTypeLong) att.getDataType()).getMaxValue() != null) {
	// max = ((DataTypeLong) att.getDataType()).getMaxValue().toString();
	// }
	//
	// if (((DataTypeLong) att.getDataType()).getMinValue() != null
	// || ((DataTypeLong) att.getDataType()).getMaxValue() != null) {
	// sqlField = "(SELECT massoftware.random_between(" + min + ", " + max + "))";
	// } else {
	// sqlField = "i";
	// }
	//
	// sqlField = "i";
	// } else if (att.isDouble()) {
	// String min = "1";
	// String max = "cant";
	//
	// if (((DataTypeDouble) att.getDataType()).getMinValue() != null) {
	// min = ((DataTypeDouble) att.getDataType()).getMinValue().toString();
	// }
	// if (((DataTypeDouble) att.getDataType()).getMaxValue() != null) {
	// max = ((DataTypeDouble) att.getDataType()).getMaxValue().toString();
	// }
	//
	// if (((DataTypeDouble) att.getDataType()).getMinValue() != null
	// || ((DataTypeDouble) att.getDataType()).getMaxValue() != null) {
	// sqlField = "(SELECT massoftware.random_between(" + min + ", " + max + "))";
	// } else {
	// sqlField = "i";
	// }
	//
	// sqlField = "i";
	// } else if (att.isBigDecimal()) {
	// String min = "1";
	// String max = "cant";
	//
	// if (((DataTypeBigDecimal) att.getDataType()).getMinValue() != null) {
	// min = ((DataTypeBigDecimal) att.getDataType()).getMinValue().toString();
	// }
	// if (((DataTypeBigDecimal) att.getDataType()).getMaxValue() != null) {
	// max = ((DataTypeBigDecimal) att.getDataType()).getMaxValue().toString();
	// }
	//
	// if (((DataTypeBigDecimal) att.getDataType()).getMinValue() != null
	// || ((DataTypeBigDecimal) att.getDataType()).getMaxValue() != null) {
	// sqlField = "(SELECT massoftware.random_between(" + min + ", " + max + "))";
	// } else {
	// sqlField = "i";
	// }
	//
	// sqlField = "i";
	// } else if (att.isBoolean()) {
	// sqlField = "(i % 2 = 0)";
	// } else if (att.isTimestamp()) {
	// sqlField = "now()";
	// }
	//
	// fields.add(sqlField);
	//
	// } else {
	// DataTypeClazz dataTypeClazz = (DataTypeClazz) att.getDataType();
	// sqlField = "(SELECT id FROM massoftware." +
	// dataTypeClazz.getClazz().getName() + " LIMIT 1)";
	// fields.add(sqlField);
	//
	// }
	//
	// }
	//
	// }

	// private String buildInsert() {
	//
	// String sql = "";
	//
	// sql += "\n\n--
	// ---------------------------------------------------------------------------------------------------------------------------\n";
	//
	// sql += "\n\n/*";
	//
	// sql += "\n\nDROP FUNCTION IF EXISTS massoftware.insert" + this.getName() + "
	// (cant INTEGER) CASCADE;";
	// sql += "\n\nCREATE OR REPLACE FUNCTION massoftware.insert" + this.getName()
	// + "(cant INTEGER) RETURNS VARCHAR AS $$";
	// sql += "\nBEGIN";
	// sql += "\n\n\tFOR i IN 1..cant LOOP";
	//
	// sql += "\n\t\tINSERT INTO massoftware." + this.getName() + "(";
	//
	// List<String> fieldsSQL = new ArrayList<String>();
	//
	// buildInsertAttsNames(this, fieldsSQL);
	//
	// int lengthMaxFieldsSQL = 0;
	//
	// for (String fieldSQL : fieldsSQL) {
	// if (fieldSQL.length() > lengthMaxFieldsSQL) {
	// lengthMaxFieldsSQL = fieldSQL.length();
	// }
	// }
	//
	// for (int i = 0; i < fieldsSQL.size(); i++) {
	// String sc = " ";
	//
	// if (i != 0) {
	// sc = ",";
	// }
	//
	// sql += "\n\t\t\t" + sc + fieldsSQL.get(i);
	//
	// for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++)
	// {
	// sql += " ";
	// }
	//
	// sql += "\t-- " + i;
	// }
	//
	// sql += "\n\t\t) VALUES (";
	//
	// fieldsSQL = new ArrayList<String>();
	//
	// buildInsertAttsValues(this, fieldsSQL);
	//
	// lengthMaxFieldsSQL = 0;
	//
	// for (String fieldSQL : fieldsSQL) {
	// if (fieldSQL.length() > lengthMaxFieldsSQL) {
	// lengthMaxFieldsSQL = fieldSQL.length();
	// }
	// }
	//
	// for (int i = 0; i < fieldsSQL.size(); i++) {
	// String sc = " ";
	//
	// if (i != 0) {
	// sc = ",";
	// }
	//
	// sql += "\n\t\t\t" + sc + fieldsSQL.get(i);
	//
	// for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++)
	// {
	// sql += " ";
	// }
	//
	// sql += "\t-- " + i;
	// }
	//
	// sql += "\n\t\t);";
	//
	// sql += "\n\tEND LOOP;";
	// sql += "\n\n\tRETURN cant || ' registros insertados de " + this.getName() +
	// "';";
	// sql += "\nEND;";
	// sql += "\n$$ LANGUAGE plpgsql;";
	// sql += "\n\nSELECT massoftware.insert" + this.getName() + " (10);";
	//
	// sql += "\n\n*/";
	//
	// return sql;
	// }

	// private String buildSelect() {
	// String sql = "";
	//
	// sql += "\n\n--
	// ---------------------------------------------------------------------------------------------------------------------------\n";
	//
	// sql += "\n\n/*";
	//
	// sql += "\n\nSELECT";
	//
	// List<String> fieldsSQL = new ArrayList<String>();
	//
	// buildSelectAtts(maxLevel, level, this, fieldsSQL);
	//
	// int lengthMaxFieldsSQL = 0;
	//
	// for (String fieldSQL : fieldsSQL) {
	// if (fieldSQL.length() > lengthMaxFieldsSQL) {
	// lengthMaxFieldsSQL = fieldSQL.length();
	// }
	// }
	//
	// for (int i = 0; i < fieldsSQL.size(); i++) {
	// String sc = " ";
	//
	// if (i != 0) {
	// sc = ",";
	// }
	//
	// sql += "\n\t" + sc + fieldsSQL.get(i);
	//
	// sql += "_" + i;
	//
	// for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 2; j++)
	// {
	// sql += " ";
	// }
	//
	// sql += "\t-- " + i;
	// }
	//
	// sql += "\n\nFROM\tmassoftware." + getName();
	//
	// fieldsSQL = new ArrayList<String>();
	//
	// fieldsSQL.add("");
	//
	// buildSelectAttsLeftJoin(maxLevel, level, this, fieldsSQL);
	//
	// lengthMaxFieldsSQL = 0;
	//
	// for (String fieldSQL : fieldsSQL) {
	// if (fieldSQL.length() > lengthMaxFieldsSQL) {
	// lengthMaxFieldsSQL = fieldSQL.length();
	// }
	// }
	//
	// for (int i = 0; i < fieldsSQL.size(); i++) {
	// if (fieldsSQL.get(i).length() > 0) {
	//
	// sql += "\n\t" + fieldsSQL.get(i);
	//
	// for (int j = 0; j < lengthMaxFieldsSQL - fieldsSQL.get(i).length() - 1; j++)
	// {
	// sql += " ";
	// }
	//
	// sql += "\t-- " + i;
	//
	// }
	// }
	//
	// sql += "\n\nWHERE \t" + this.getName() + ".id = 'xxx';";
	//
	// sql += "\n\n*/";
	//
	// return sql;
	// }

} //////////////////////////////////////////////////////////////////////////////////////////////
