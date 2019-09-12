package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

import com.anthill.model.Att;
import com.anthill.model.Clazz;

public class Vaadin13 {

	// ------------------------------------------------------------------------------

	protected final static String N = "\n";
	protected final static String T = "\t";
	protected final static String NT1 = N + T;
	protected final static String NT2 = N + T + T;
	protected final static String NT3 = N + T + T + T;
	protected final static String SEPARATOR_INSTANCE_CONTROLS = "\n\n\t\t//-------------------------------------------------------------------";

	// ------------------------------------------------------------------------------

	protected final static String SERVICE_PREFIX_PKG = "com.massoftware.service.";
	protected final static String UTIL_PREFIX_PKG = "com.massoftware.ui.util.";
	protected final static String COMPONENT_PREFIX_PKG = "com.vaadin.flow.component.";

	// ------------------------------------------------------------------------------

	protected final static String OBJ_UTIL_LIST = java.util.List.class.getName();
	protected final static String OBJ_UTIL_LIST_PKG = java.util.List.class.getCanonicalName();

	protected final static String OBJ_UTIL_LOCALE = java.util.Locale.class.getName();
	protected final static String OBJ_UTIL_LOCALE_PKG = java.util.Locale.class.getCanonicalName();

	protected final static String OBJ_DATE_PICKER_I18N = "UIDatePickerI18n_es_AR";
	protected final static String OBJ_DATE_PICKER_I18N_PKG = SERVICE_PREFIX_PKG + OBJ_DATE_PICKER_I18N;

	// ------------------------------------------------------------------------------

	protected final static String CONTROL_CHECKBOX = "Checkbox";
	protected final static String CONTROL_CHECKBOX_PKG = COMPONENT_PREFIX_PKG + "checkbox." + CONTROL_CHECKBOX;

	protected final static String CONTROL_TEXT_FIELD = "TextField";
	protected final static String CONTROL_TEXT_FIELD_PKG = COMPONENT_PREFIX_PKG + "textfield." + CONTROL_TEXT_FIELD;

	protected final static String CONTROL_TEXT_AREA = "TextArea";
	protected final static String CONTROL_TEXT_AREA_PKG = COMPONENT_PREFIX_PKG + "textfield." + CONTROL_TEXT_AREA;

	protected final static String CONTROL_NUMBER_FIELD = "NumberField";
	protected final static String CONTROL_NUMBER_FIELD_PKG = COMPONENT_PREFIX_PKG + "textfield." + CONTROL_NUMBER_FIELD;

	protected final static String CONTROL_DATE_PICKER = "DatePicker";
	protected final static String CONTROL_DATE_PICKER_PKG = COMPONENT_PREFIX_PKG + "datepicker." + CONTROL_DATE_PICKER;

	protected final static String CONTROL_DATE_TIME_PICKER = "UICustomDateTimePicker";
	protected final static String CONTROL_DATE_TIME_PICKER_PKG = SERVICE_PREFIX_PKG + CONTROL_DATE_TIME_PICKER;

	protected final static String CONTROL_COMBOBOX = "ComboBox";
	protected final static String CONTROL_COMBOBOX_PKG = COMPONENT_PREFIX_PKG + "combobox." + CONTROL_COMBOBOX;

	// ------------------------------------------------------------------------------

	protected final static String CONVERTER_DOUBLE_INTEGER = "DoubleToIntegerConverter";
	protected final static String CONVERTER_DOUBLE_INTEGER_PKG = UTIL_PREFIX_PKG + CONVERTER_DOUBLE_INTEGER;

	protected final static String CONVERTER_DOUBLE_LONG = "DoubleToLongConverter";
	protected final static String CONVERTER_DOUBLE_LONG_PKG = UTIL_PREFIX_PKG + CONVERTER_DOUBLE_LONG;

	protected final static String CONVERTER_DOUBLE_BIGDECIMAL = "DoubleToBigDecimalConverter";
	protected final static String CONVERTER_DOUBLE_BIGDECIMAL_PKG = UTIL_PREFIX_PKG + CONVERTER_DOUBLE_BIGDECIMAL;

	// ------------------------------------------------------------------------------

	protected static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	protected static String loadFileTemplate(String filePath) throws IOException {

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource(filePath);
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
			// System.out.println(linea);
		}
		b.close();

		source = source.trim();

		return source;
	}

	// ------------------------------------------------------------------------------

	protected static String buildImport(String src, Clazz c, Att att) {

		return buildImport(src, c, att, "");
	}

	protected static String buildImport(String src, Clazz c, Att att, String sufix) {

		String attNamePackage = att.getDataTypeClazz().getClazz().getNamePackage();
		String attName = att.getDataTypeClazz().getClazz().getName();

		if (c.getNamePackage().equals(attNamePackage) == false) {
			String srcImportService = SERVICE_PREFIX_PKG + attNamePackage + "." + attName + sufix;

			return buildImport(src, srcImportService);
		}

		return "";
	}

	protected static String buildImport(String src, String control) {
		String srcReturn = "";

		if (src.contains(control) == false) {
			srcReturn += N + "import " + control + ";";
		}

		return srcReturn;
	}

	protected static String buildDeclare(String control, String varName) {
		return buildDeclare(control, null, varName);
	}

	protected static String buildDeclare(String control, String c, String varName) {
		String srcReturn = "";

		if (c == null) {
			srcReturn += NT1 + "private " + control + " " + varName + ";";
		} else {
			srcReturn += NT1 + "private " + control + "<" + c + ">" + " " + varName + ";";
		}

		return srcReturn;
	}

	protected static String buildCommentAtt(Att att) {

		return "// " + att.getLabel() + "";
	}

	protected static String buildSetLabelControl(Att att) {

		return att.getName() + ".setLabel(\"" + att.getLabel() + "\");";
	}

	protected static String buildSetWidthFull(Att att) {

		return att.getName() + ".setWidthFull();";
	}

	protected static String buildSetReadOnly(Att att) {

		return att.getName() + ".setReadOnly(true);";
	}

	protected static String buildSetClearButtonVisible(Att att) {

		return att.getName() + ".setClearButtonVisible(true);";
	}

	protected static String buildBinderForField(Att att) {

		return "binder.forField(" + att.getName() + ")";
	}

	protected static String buildBindRequied(String t, Att att) {
		if (att.isRequired()) {
			return t + ".asRequired(\"" + att.getLabel() + " es requerido.\")		";
		}
		return "";
	}

	protected static String buildBind(Clazz c, Att att) {

		return ".bind(" + c.getName() + "::get" + toCamelStart(att.getName()) + ", " + c.getName() + "::set"
				+ toCamelStart(att.getName()) + ");";
	}

	protected static String buildNewInstanceControl(Att att, String control) {

		return att.getName() + " = new " + control + "();";
	}

}
