package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeBigDecimal;
import com.anthill.model.DataTypeDouble;
import com.anthill.model.DataTypeInteger;
import com.anthill.model.DataTypeLong;

public class UtilJavaUIGridView {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toJava(Clazz clazzX) throws IOException {

		String java = "";

		String linea;
		String source = "";

		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource("grid_view.txt");
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
			// System.out.println(linea);
		}
		b.close();

		source = source.replaceAll("@NAME_PACKAGE@", clazzX.getNamePackage());
		source = source.replaceAll("@NAME_PLURAL@", clazzX.getNamePlural());
		source = source.replaceAll("@NAME@", clazzX.getName());
		source = source.replaceAll("@LABEL@", clazzX.getSingular());
		source = source.replaceAll("@LABEL_PLURAL@", clazzX.getPlural());
		
		String atts = "";
		for (int i = 0; i < clazzX.getArgs().size(); i++) {
			Argument arg = clazzX.getArgs().get(i);
			
			if (arg.getRange()) {
				
				if (arg.isNumber()) {
					atts += ", " + arg.getName() + "From";
					atts += ", " + arg.getName() + "To";	
				}								
				
			} else if(arg.isSimple() == false ) {
//				atts += ", " + arg.getName();
			} else {
				atts += ", " + arg.getName();
			}
			
		}

		source = source.replaceAll("@ATTS@", atts);

		source = source.replaceAll("@DECLARE_CONTROLS@", buildDeclareControls(clazzX));
		source = source.replaceAll("@INSTANCE_CONTROLS@", buildInstanceControls(clazzX));

		java += source;

		return java;
	}

	private static String buildDeclareControls(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getArgs().size(); i++) {

			Argument arg = clazzX.getArgs().get(i);

			String sc = "\n\t";

			if (arg.isNumber()) {

				if (arg.getRange() == false) {

					java += sc + "private NumberField " + arg.getName() + ";";

				} else {

					java += sc + "private NumberField " + arg.getName() + "From;";
					java += sc + "private NumberField " + arg.getName() + "To;";

				}

			} else if (arg.isDate()) {

				if (arg.getRange() == false) {

				} else {

				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

				} else {

				}

			} else if (arg.isString()) {

				java += sc + "private TextField " + arg.getName() + ";";

			} else if (arg.isBoolean()) {

				java += sc + "private ComboBox<FBoolean> " + arg.getName() + ";";

			} else if (arg.isSimple() == false) {

			}
		}

		java += "\n";

		return java;
	}

	private static String buildInstanceControls(Clazz clazzX) {
		String java = "";
		
		int digit = 0;

		for (int i = 0; i < clazzX.getArgs().size(); i++) {
			
			digit ++;

			Argument arg = clazzX.getArgs().get(i);

			String t1 = "\n\t";
			String t2 = "\n\t\t";
			String t3 = "\n\t\t\t";
			String t4 = "\n\t\t\t\t";

			if (arg.isNumber()) {

				Object min = null;
				Object max = null;

				if (arg.isInteger()) {
					min = ((DataTypeInteger) arg.getDataType()).getMinValue();
					max = ((DataTypeInteger) arg.getDataType()).getMaxValue();
				} else if (arg.isLong()) {
					min = ((DataTypeLong) arg.getDataType()).getMinValue();
					max = ((DataTypeLong) arg.getDataType()).getMaxValue();
				} else if (arg.isDouble()) {
					min = ((DataTypeDouble) arg.getDataType()).getMinValue();
					max = ((DataTypeDouble) arg.getDataType()).getMaxValue();
				} else if (arg.isBigDecimal()) {
					min = ((DataTypeBigDecimal) arg.getDataType()).getMinValue();
					max = ((DataTypeBigDecimal) arg.getDataType()).getMaxValue();
				}

				if (min == null && arg.isBigDecimal() == false) {
					min = arg.getDataType().getNameJava() + ".MIN_VALUE";
				}
				if (max == null && arg.isBigDecimal() == false) {
					max = arg.getDataType().getNameJava() + ".MAX_VALUE";
				}

				if (arg.getRange() == false) {

					String f = "";
					String f2 = "";

					java += t2 + "// " + arg.getLabel() + " (" + f2 + ")";
					java += t2 + arg.getName() + f + " = new NumberField();";
					if (min != null) {
						java += t2 + arg.getName() + f + ".setMin(" + min + ");";
					}
					if (max != null) {
						java += t2 + arg.getName() + f + ".setMax(" + max + ");";
					}
					java += t2 + arg.getName() + f + ".setPlaceholder(\"" + arg.getLabel() + f2 + " \");";
					java += t2 + arg.getName() + f + ".setPrefixComponent(VaadinIcon.SEARCH.create());";
					java += t2 + arg.getName() + f + ".setClearButtonVisible(true);";
					java += t2 + arg.getName() + f + ".addFocusShortcut(Key.DIGIT_" + digit + ", KeyModifier.ALT);";
					java += t2 + "binder.forField(" + arg.getName() + f + ")";
					if (arg.isInteger()) {
						java += t3 + ".withConverter(new DoubleToIntegerConverter())";
					} else {
						java += t3 + "666";
					}
					java += t3 + ".withValidator(value -> (value != null) ? value >= " + min
							+ " : true, \"El valor tiene que ser >= " + min + "\")";
					java += t3 + ".withValidator(value -> (value != null) ? value <= " + max
							+ " : true,\"El valor tiene que ser <= \" + " + max + ")";
					java += t3 + ".bind(" + clazzX.getNamePlural() + "Filtro::get" + toCamelStart(arg.getName()) + f
							+ ", " + clazzX.getNamePlural() + "Filtro::set" + toCamelStart(arg.getName()) + f + ");";
					java += t2 + arg.getName() + f + ".addKeyPressListener(Key.ENTER, event -> {";
					java += t3 + "search();";
					java += t2 + "});";
					java += t2 + arg.getName() + f + ".addValueChangeListener(event -> {";
					java += t2 + "if (event.getValue() == null || event.getValue().toString().trim().length() == 0) {";
					java += t3 + "search();";
					java += t2 + "}";
					java += t2 + "});";
					java += t2 + arg.getName() + f + ".addBlurListener(event -> {";
					java += t3 + "search();";
					java += t2 + "});";

				} else {

					String f = "From";
					String f2 = "desde";

					java += t2 + "// " + arg.getLabel() + " (" + f2 + ")";
					java += t2 + arg.getName() + f + " = new NumberField();";
					if (min != null) {
						java += t2 + arg.getName() + f + ".setMin(" + min + ");";
					}
					if (max != null) {
						java += t2 + arg.getName() + f + ".setMax(" + max + ");";
					}
					java += t2 + arg.getName() + f + ".setPlaceholder(\"" + arg.getLabel() + f2 + " \");";
					java += t2 + arg.getName() + f + ".setPrefixComponent(VaadinIcon.SEARCH.create());";
					java += t2 + arg.getName() + f + ".setClearButtonVisible(true);";
					java += t2 + arg.getName() + f + ".addFocusShortcut(Key.DIGIT_" + digit + ", KeyModifier.ALT);";
					java += t2 + "binder.forField(" + arg.getName() + f + ")";
					if (arg.isInteger()) {
						java += t3 + ".withConverter(new DoubleToIntegerConverter())";
					} else {
						java += t3 + "666";
					}
					java += t3 + ".withValidator(value -> (value != null) ? value >= " + min
							+ " : true, \"El valor tiene que ser >= " + min + "\")";
					java += t3 + ".withValidator(value -> (value != null) ? value <= " + max
							+ " : true,\"El valor tiene que ser <= \" + " + max + ")";
					java += t3 + ".bind(" + clazzX.getNamePlural() + "Filtro::get" + toCamelStart(arg.getName()) + f
							+ ", " + clazzX.getNamePlural() + "Filtro::set" + toCamelStart(arg.getName()) + f + ");";
					java += t2 + arg.getName() + f + ".addKeyPressListener(Key.ENTER, event -> {";
					java += t3 + "search();";
					java += t2 + "});";
					java += t2 + arg.getName() + f + ".addValueChangeListener(event -> {";
					java += t2 + "if (event.getValue() == null || event.getValue().toString().trim().length() == 0) {";
					java += t3 + "search();";
					java += t2 + "}";
					java += t2 + "});";
					java += t2 + arg.getName() + f + ".addBlurListener(event -> {";
					java += t3 + "search();";
					java += t2 + "});";

					digit ++;
					f = "To";
					f2 = "hasta";

					java += "\n";
					java += t2 + "// " + arg.getLabel() + " (" + f2 + ")";
					java += t2 + arg.getName() + f + " = new NumberField();";
					if (min != null) {
						java += t2 + arg.getName() + f + ".setMin(" + min + ");";
					}
					if (max != null) {
						java += t2 + arg.getName() + f + ".setMax(" + max + ");";
					}
					java += t2 + arg.getName() + f + ".setPlaceholder(\"" + arg.getLabel() + " " + f2 + " \");";
					java += t2 + arg.getName() + f + ".setPrefixComponent(VaadinIcon.SEARCH.create());";
					java += t2 + arg.getName() + f + ".setClearButtonVisible(true);";
					java += t2 + arg.getName() + f + ".addFocusShortcut(Key.DIGIT_" + digit + ", KeyModifier.ALT);";
					java += t2 + "binder.forField(" + arg.getName() + f + ")";
					if (arg.isInteger()) {
						java += t3 + ".withConverter(new DoubleToIntegerConverter())";
					} else {
						java += t3 + "666";
					}
					java += t3 + ".withValidator(value -> (value != null) ? value >= " + min
							+ " : true, \"El valor tiene que ser >= " + min + "\")";
					java += t3 + ".withValidator(value -> (value != null) ? value <= " + max
							+ " : true,\"El valor tiene que ser <= \" + " + max + ")";
					java += t3 + ".bind(" + clazzX.getNamePlural() + "Filtro::get" + toCamelStart(arg.getName()) + f
							+ ", " + clazzX.getNamePlural() + "Filtro::set" + toCamelStart(arg.getName()) + f + ");";
					java += t2 + arg.getName() + f + ".addKeyPressListener(Key.ENTER, event -> {";
					java += t3 + "search();";
					java += t2 + "});";
					java += t2 + arg.getName() + f + ".addValueChangeListener(event -> {";
					java += t2 + "if (event.getValue() == null || event.getValue().toString().trim().length() == 0) {";
					java += t3 + "search();";
					java += t2 + "}";
					java += t2 + "});";
					java += t2 + arg.getName() + f + ".addBlurListener(event -> {";
					java += t3 + "search();";
					java += t2 + "});";

				}

			} else if (arg.isDate()) {

				if (arg.getRange() == false) {

				} else {

				}

			} else if (arg.isTimestamp()) {

				if (arg.getRange() == false) {

				} else {

				}

			} else if (arg.isString()) {

				// java += sc + "private TextField " + arg.getName() + ";";

				java += "\n";
				java += t2 + "// " + arg.getLabel() + "";
				java += t2 + arg.getName() + " = new TextField();";
				java += t2 + arg.getName() + ".setPlaceholder(\"" + arg.getLabel() + "\");";
				java += t2 + arg.getName() + ".setPrefixComponent(VaadinIcon.SEARCH.create());";
				java += t2 + arg.getName() + ".setWidthFull();";
				java += t2 + arg.getName() + ".setClearButtonVisible(true);";
				java += t2 + arg.getName() + ".setAutoselect(true);";
				java += t2 + arg.getName() + ".addFocusShortcut(Key.DIGIT_" + digit + ", KeyModifier.ALT);";
				java += t2 + "binder.bind(" + arg.getName() + ", " + clazzX.getNamePlural() + "Filtro::get"
						+ toCamelStart(arg.getName()) + ", " + clazzX.getNamePlural() + "Filtro::set"
						+ toCamelStart(arg.getName()) + ");";
				java += t2 + arg.getName() + ".addKeyPressListener(Key.ENTER, event -> {";
				java += t3 + "search();";
				java += t2 + "});";
				java += t2 + arg.getName() + ".addValueChangeListener(event -> {";
				java += t3 + "if (event.getValue() == null || event.getValue().toString().trim().length() == 0) {";
				java += t4 + "search();";
				java += t3 + "}";
				java += t2 + "});";
				java += t2 + arg.getName() + ".addBlurListener(event -> {";
				java += t3 + "search();";
				java += t2 + "});";

			} else if (arg.isBoolean()) {

				java += "\n";
				java += t2 + "// " + arg.getLabel() + "";
				java += t2 + arg.getName() + " = new ComboBox<>();";
				java += t2 + arg.getName() + ".setPlaceholder(\"" + arg.getLabel() + ": Todos\");";
				java += t2 + "FBoolean value" + toCamelStart(arg.getName()) + " = new FBoolean(\"" + arg.getLabel()
						+ ": \", null, \"Todos\");";
				java += t2 + arg.getName() + ".setItems(value" + toCamelStart(arg.getName()) + ", new FBoolean(\""
						+ arg.getLabel() + ": \", true, \"Si\"), new FBoolean(\"" + arg.getLabel()
						+ ": \", false, \"No\"));";
				java += t2 + arg.getName() + ".setValue(value" + toCamelStart(arg.getName()) + ");";
				java += t2 + "binder.bind(" + arg.getName() + ", " + clazzX.getNamePlural() + "Filtro::get"
						+ toCamelStart(arg.getName()) + "X, " + clazzX.getNamePlural() + "Filtro::set"
						+ toCamelStart(arg.getName()) + "X);";
				java += t2 + arg.getName() + ".addValueChangeListener(event -> {";
				java += t3 + "search();";
				java += t2 + "});";
				java += t2 + arg.getName() + ".addBlurListener(event -> {";
				java += t3 + "search();";
				java += t2 + "});";

			} else if (arg.isSimple() == false) {

			}
		}

		java += "\n";

		return java;
	}

}
