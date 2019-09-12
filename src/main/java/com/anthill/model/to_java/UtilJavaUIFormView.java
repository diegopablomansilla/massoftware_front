package com.anthill.model.to_java;

import java.io.IOException;

import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeBigDecimal;
import com.anthill.model.DataTypeDouble;
import com.anthill.model.DataTypeInteger;
import com.anthill.model.DataTypeLong;

public class UtilJavaUIFormView extends Vaadin13 {

	private String src = "";
	private String srcImport = "";
	private String srcDeclareControls = "";
	private String srcInstanceControls = "";
	private String srcInstanceControlsMethod = "";
	private String srcControls = "";

	public String toJava(Clazz c) throws IOException {

		src += loadFileTemplate("form_view.txt");

		src = src.replaceAll("@NAME_PACKAGE@", c.getNamePackage());
		src = src.replaceAll("@NAME@", c.getName());
		src = src.replaceAll("@NAME@", c.getName());
		src = src.replaceAll("@LABEL@", c.getSingular());

		// ------------------------------------------------------------------------------

		for (int i = 0; i < c.getAtts().size(); i++) {

			Att att = c.getAtts().get(i);

			if (att.isBoolean()) {

				buildSrcBoolean(c, att);

			} else if (att.isString()) {

				buildSrcString(c, att);

			} else if (att.isNumber()) {

				buildSrcNumber(c, att);

			} else if (att.isDate()) {

				buildSrcDate(c, att);

			} else if (att.isTimestamp()) {

				buildSrcTimestamp(c, att);

			} else if (att.isSimple() == false) {

				buildSrcObject(c, att);
			}
		}

		// ------------------------------------------------------------------------------

		srcImport += "\n";
		srcDeclareControls += "\n";
		srcInstanceControlsMethod += "\n";

		src = src.replaceAll("@DECLARE_IMPORTS@", srcImport);
		src = src.replaceAll("@DECLARE_CONTROLS@", srcDeclareControls);
		src = src.replaceAll("@INSTANCE_CONTROLS@", srcInstanceControls);
		src = src.replaceAll("@INSTANCE_CONTROLS_METHOD@", srcInstanceControlsMethod);
		src = src.replaceAll("@ATTS@", srcControls);

		return src;
	}

	// ==============================================================================

	private void buildSrcBoolean(Clazz c, Att att) {

		srcControls += NT2 + "form.add(" + att.getName() + ");";
		srcInstanceControls += NT2 + "build" + toCamelStart(att.getName()) + "();";

		srcImport += buildImport(srcImport, CONTROL_CHECKBOX_PKG);

		srcDeclareControls += buildDeclare(CONTROL_CHECKBOX, att.getName());

		srcInstanceControlsMethod += buildInstanceBoolean(c, att);

	}

	private void buildSrcString(Clazz c, Att att) {

		srcControls += NT2 + "form.add(" + att.getName() + ");";
		srcInstanceControls += NT2 + "build" + toCamelStart(att.getName()) + "();";

		if (att.getMinLength() != null && att.getMinLength() > 120) {

			srcImport += buildImport(srcImport, CONTROL_TEXT_AREA_PKG);
			srcDeclareControls += buildDeclare(CONTROL_TEXT_AREA, att.getName());

		} else if (att.getMaxLength() != null && att.getMaxLength() > 120) {

			srcImport += buildImport(srcImport, CONTROL_TEXT_AREA_PKG);
			srcDeclareControls += buildDeclare(CONTROL_TEXT_AREA, att.getName());

		} else {

			srcImport += buildImport(srcImport, CONTROL_TEXT_FIELD_PKG);
			srcDeclareControls += buildDeclare(CONTROL_TEXT_FIELD, att.getName());

		}

		srcInstanceControlsMethod += buildInstanceString(c, att);

	}

	private void buildSrcNumber(Clazz c, Att att) {

		srcControls += NT2 + "form.add(" + att.getName() + ");";
		srcInstanceControls += NT2 + "build" + toCamelStart(att.getName()) + "();";

		srcImport += buildImport(srcImport, CONTROL_NUMBER_FIELD_PKG);
		if (att.isInteger()) {
			srcImport += buildImport(srcImport, CONVERTER_DOUBLE_INTEGER_PKG);
		} else if (att.isLong()) {
			srcImport += buildImport(srcImport, CONVERTER_DOUBLE_LONG_PKG);
		} else if (att.isBigDecimal()) {
			srcImport += buildImport(srcImport, CONVERTER_DOUBLE_BIGDECIMAL_PKG);
		}

		srcDeclareControls += buildDeclare(CONTROL_NUMBER_FIELD, att.getName());

		srcInstanceControlsMethod += buildInstanceNumber(c, att);

	}

	private void buildSrcDate(Clazz c, Att att) {

		srcControls += NT2 + "form.add(" + att.getName() + ");";
		srcInstanceControls += NT2 + "build" + toCamelStart(att.getName()) + "();";

		srcImport += buildImport(srcImport, CONTROL_DATE_PICKER_PKG);
		srcImport += buildImport(srcImport, OBJ_UTIL_LOCALE_PKG);
		srcImport += buildImport(srcImport, OBJ_DATE_PICKER_I18N_PKG);

		srcDeclareControls += buildDeclare(CONTROL_DATE_PICKER, att.getName());

		srcInstanceControlsMethod += buildInstanceDate(c, att);

	}

	private void buildSrcTimestamp(Clazz c, Att att) {

		srcControls += NT2 + "form.add(" + att.getName() + ");";
		srcInstanceControls += NT2 + "build" + toCamelStart(att.getName()) + "();";

		srcImport += buildImport(srcImport, CONTROL_DATE_TIME_PICKER_PKG);
		srcImport += buildImport(srcImport, OBJ_UTIL_LOCALE_PKG);
		srcImport += buildImport(srcImport, OBJ_DATE_PICKER_I18N_PKG);

		srcDeclareControls += buildDeclare(CONTROL_DATE_TIME_PICKER, att.getName());

		srcInstanceControlsMethod += buildInstanceDateTime(c, att);

	}

	private void buildSrcObject(Clazz c, Att att) {

		srcControls += NT2 + "form.add(" + att.getName() + ");";
		srcInstanceControls += NT2 + "build" + toCamelStart(att.getName()) + "();";

		srcImport += buildImport(srcImport, OBJ_UTIL_LIST_PKG);
		srcImport += buildImport(srcImport, CONTROL_COMBOBOX_PKG);
		srcImport += buildImport(srcImport, c, att);
		srcImport += buildImport(srcImport, c, att, "Service");

		srcDeclareControls += buildDeclare(CONTROL_COMBOBOX, att.getDataType().getName(), att.getName());

		srcInstanceControlsMethod += buildInstanceObject(c, att);

	}

	// ==============================================================================

	private String buildInstance(Clazz c, Att att, String control) {
		String src = "";

		// src += SEPARATOR_INSTANCE_CONTROLS;
		src += NT2 + buildCommentAtt(att);
		src += NT2 + buildNewInstanceControl(att, control);
		src += NT2 + buildSetLabelControl(att);
		src += NT2 + buildSetWidthFull(att);
		// src += NT2 + buildSetClearButtonVisible(att);
		if (att.isReadOnlyGUI()) {
			src += NT2 + buildSetReadOnly(att);
		}

		return src;
	}

	private String buildInstanceBoolean(Clazz c, Att att) {
		String src = "";

		src += N + NT1 + "private void build" + toCamelStart(att.getName()) + "() throws Exception {";

		src += buildInstance(c, att, CONTROL_CHECKBOX);
		// src += NT2 + att.getName() + ".setIndeterminate(true);";
		// ------------
		src += NT2 + buildBinderForField(att);
		// src += buildBindRequied(NT3, att);
		src += NT3 + buildBind(c, att);

		src += NT1 + "}";

		return src;
	}

	private String buildInstanceString(Clazz c, Att att) {
		String src = "";

		src += N + NT1 + "private void build" + toCamelStart(att.getName()) + "() throws Exception {";

		if (att.getMinLength() != null && att.getMinLength() > 120) {
			src += buildInstance(c, att, CONTROL_TEXT_AREA);
		} else if (att.getMaxLength() != null && att.getMaxLength() > 120) {
			src += buildInstance(c, att, CONTROL_TEXT_AREA);
		} else {
			src += buildInstance(c, att, CONTROL_TEXT_FIELD);
		}

		src += NT2 + buildSetClearButtonVisible(att);
		src += NT2 + att.getName() + ".setAutoselect(true);";
		if (att.isRequired()) {
			src += NT2 + att.getName() + ".setRequired(true);";
		}
		// ------------
		src += NT2 + buildBinderForField(att);
		src += buildBindRequied(NT3, att);
		// if (att.getMinLength() != null && att.getMaxLength() == null) {
		// src += NT3 + ".withValidator(new StringLengthValidator(\"El valor tiene que
		// contener al menos " + att.getMinLength() + " caracteres\", " +
		// att.getMinLength() + ", null))";
		// } else if (att.getMinLength() == null && att.getMaxLength() != null) {
		// src += NT3 + ".withValidator(new StringLengthValidator(\"El valor tiene que
		// contener menos de " + att.getMaxLength() + " caracteres\", null, " +
		// att.getMaxLength() + "))";
		// } else if (att.getMinLength() != null && att.getMaxLength() != null) {
		// src += NT3 + ".withValidator(new StringLengthValidator(\"El valor tiene que
		// contener al menos " + att.getMinLength() + " caracteres, y menos de " +
		// att.getMaxLength() + "\", " + att.getMinLength() + ", " + att.getMaxLength()
		// + "))";
		// }
		if (att.getMinLength() != null) {
			src += NT3 + ".withValidator(value -> (value != null) ? value.length() >= " + att.getMinLength()
					+ " : true, \"El valor tiene que contener al menos " + att.getMinLength() + " caracteres\")";
		}
		if (att.getMaxLength() != null) {

			src += NT3 + ".withValidator(value -> (value != null) ? value.length() <= " + att.getMaxLength()
					+ " : true, \"El valor tiene que contener menos de " + att.getMaxLength() + " caracteres\")";
		}

		src += NT3 + buildBind(c, att);

		src += NT1 + "}";

		return src;
	}

	private String buildInstanceNumber(Clazz c, Att att) {
		String src = "";

		// --------------------------------------------------------------

		Object min = null;
		Object max = null;

		if (att.isInteger()) {
			min = ((DataTypeInteger) att.getDataType()).getMinValue();
			max = ((DataTypeInteger) att.getDataType()).getMaxValue();
		} else if (att.isLong()) {
			min = ((DataTypeLong) att.getDataType()).getMinValue();
			max = ((DataTypeLong) att.getDataType()).getMaxValue();
		} else if (att.isDouble()) {
			min = ((DataTypeDouble) att.getDataType()).getMinValue();
			max = ((DataTypeDouble) att.getDataType()).getMaxValue();
		} else if (att.isBigDecimal()) {
			min = ((DataTypeBigDecimal) att.getDataType()).getMinValue();
			max = ((DataTypeBigDecimal) att.getDataType()).getMaxValue();
		}

		if (min != null && att.isLong()) {
			min = min + "L";
		}
		if (max != null && att.isLong()) {
			max = max + "L";
		}

		if (min == null && att.isBigDecimal() == false) {
			min = att.getDataType().getNameJava() + ".MIN_VALUE";
		}
		if (max == null && att.isBigDecimal() == false) {
			max = att.getDataType().getNameJava() + ".MAX_VALUE";
		}

		// --------------------------------------------------------------

		src += N + NT1 + "private void build" + toCamelStart(att.getName()) + "() throws Exception {";

		src += buildInstance(c, att, CONTROL_NUMBER_FIELD);
		// src += NT2 + att.getName() + ".setAutoselect(true);";
		src += NT2 + buildSetClearButtonVisible(att);
		if (min != null) {
			src += NT2 + att.getName() + ".setMin(" + min + ");";
		}
		if (max != null) {
			src += NT2 + att.getName() + ".setMax(" + max + ");";
		}
		// ------------
		src += NT2 + buildBinderForField(att);
		src += buildBindRequied(NT3, att);
		if (att.isInteger()) {
			src += NT3 + ".withValidator(value -> (value != null) ? value % 1 == 0"
					+ " : true, \"El valor tiene que ser entero\")";
			src += NT3 + ".withConverter(new DoubleToIntegerConverter())";
		} else if (att.isBigDecimal()) {
			src += NT3 + ".withConverter(new DoubleToBigDecimalConverter())";
		} else if (att.isLong()) {
			src += NT3 + ".withConverter(new DoubleToLongConverter())";
		} else if (att.isDouble()) {

		} else {
			src += NT3 + "666";
		}
		if (att.isBigDecimal() == false) {
			src += NT3 + ".withValidator(value -> (value != null) ? value >= " + min
					+ " : true, \"El valor tiene que ser >= " + min + "\")";
			src += NT3 + ".withValidator(value -> (value != null) ? value <= " + max
					+ " : true,\"El valor tiene que ser <= \" + " + max + ")";

			// if (min != null && max == null) {
			// src += NT3 + ".withValidator(new IntegerRangeValidator(\"El valor tiene que
			// ser >= \" + " + min + " + \"\", " + min + ", " + null + "))";
			// } else if (min == null && max != null) {
			// src += NT3 + ".withValidator(new IntegerRangeValidator(\"El valor tiene que
			// ser <= \" + " + max + " + \"\", " + null + ", " + max + "))";
			// } else if (min != null && max != null) {
			// src += NT3 + ".withValidator(new IntegerRangeValidator(\"El valor tiene que
			// ser >= \" + " + min + " + \" y <= \" + " + max + " + \"\", " + min + ", " +
			// max + "))";
			// }

		}
		src += NT3 + buildBind(c, att);

		src += NT1 + "}";

		return src;
	}

	private String buildInstanceDate(Clazz c, Att att) {
		String src = "";

		src += N + NT1 + "private void build" + toCamelStart(att.getName()) + "() throws Exception {";

		src += buildInstance(c, att, CONTROL_DATE_PICKER);
		if (att.isRequired()) {
			src += NT2 + att.getName() + ".setRequired(true);";
		}
		src += NT2 + att.getName() + ".setLocale(new Locale(\"es_AR\"));";
		src += NT2 + att.getName() + ".setI18n(new " + OBJ_DATE_PICKER_I18N + "());";

		// ------------
		src += NT2 + buildBinderForField(att);
		src += buildBindRequied(NT3, att);
		src += NT3 + buildBind(c, att);

		src += NT1 + "}";

		return src;
	}

	private String buildInstanceDateTime(Clazz c, Att att) {
		String src = "";

		src += N + NT1 + "private void build" + toCamelStart(att.getName()) + "() throws Exception {";

		src += buildInstance(c, att, CONTROL_DATE_TIME_PICKER);
		if (att.isRequired()) {
			src += NT2 + att.getName() + ".setRequired(true);";
		}
		src += NT2 + att.getName() + ".setLocale(new Locale(\"es_AR\"));";
		src += NT2 + att.getName() + ".setI18n(new " + OBJ_DATE_PICKER_I18N + "());";

		// ------------
		src += NT2 + buildBinderForField(att);
		src += buildBindRequied(NT3, att);
		src += NT3 + buildBind(c, att);

		src += NT1 + "}";

		return src;
	}

	private String buildInstanceObject(Clazz c, Att att) {
		String src = "";

		src += N + NT1 + "private void build" + toCamelStart(att.getName()) + "() throws Exception {";

		src += buildInstance(c, att, CONTROL_COMBOBOX + "<>");
		if (att.isRequired()) {
			src += NT2 + att.getName() + ".setRequired(true);";
		}
		// ------------

		src += NT2 + "List<" + att.getDataType().getName() + "> " + "items = new " + att.getDataType().getName()
				+ "Service().find();";
		src += NT2 + att.getName() + ".setItems(items);";

		// ------------

		src += NT2 + buildBinderForField(att);
		src += buildBindRequied(NT3, att);
		src += NT3 + buildBind(c, att);

		src += NT1 + "}";

		return src;
	}

}
