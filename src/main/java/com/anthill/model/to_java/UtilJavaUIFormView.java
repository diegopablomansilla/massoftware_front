package com.anthill.model.to_java;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;

import com.anthill.model.Argument;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeBigDecimal;
import com.anthill.model.DataTypeClazz;
import com.anthill.model.DataTypeDouble;
import com.anthill.model.DataTypeInteger;
import com.anthill.model.DataTypeLong;

public class UtilJavaUIFormView {

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
		URL url = classLoader.getResource("form.txt");
		String path = url.toString().substring(6, url.toString().length());

		FileReader f = new FileReader(path);
		BufferedReader b = new BufferedReader(f);
		while ((linea = b.readLine()) != null) {
			source += "\n" + linea;
			// System.out.println(linea);
		}
		b.close();

		source = source.trim();

		source = source.replaceAll("@NAME_PACKAGE@", clazzX.getNamePackage());
		source = source.replaceAll("@NAME@", clazzX.getName());
		source = source.replaceAll("@NAME@", clazzX.getName());
		source = source.replaceAll("@LABEL@", clazzX.getSingular());

		String atts = "";
		for (int i = 0; i < clazzX.getAtts().size(); i++) {
			Att arg = clazzX.getAtts().get(i);

			String sc = ", ";

			if (i == 0) {
				sc = "";
			}

			// if (arg.isSimple() == false) {
			//
			// atts += sc + arg.getName();
			//
			// } else if (arg.getRange()) {
			//
			// if (arg.isNumber() || arg.isDate()) {
			// atts += sc + arg.getName() + "From";
			// atts += sc + arg.getName() + "To";
			// }
			//
			// } else {
			// atts += sc + arg.getName();
			//
			// }

			atts += sc + arg.getName();

		}

		source = source.replaceAll("@ATTS@", atts);

		source = source.replaceAll("@DECLARE_IMPORTS@", buildImports(clazzX));
		source = source.replaceAll("@DECLARE_CONTROLS@", buildDeclareControls(clazzX));
		source = source.replaceAll("@INSTANCE_CONTROLS@", buildInstanceControls(clazzX));
		// source = source.replaceAll("@REQUIRED@", buildCheck(clazzX));

		java += source;

		return java;
	}

	private static String buildImports(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n";

			if (att.isNumber()) {

				String im = "import com.vaadin.flow.component.textfield.NumberField;";

				if (java.contains(im) == false) {
					java += sc + im;
				}

				if (att.isInteger()) {
					im = "import com.massoftware.ui.util.DoubleToIntegerConverter;";
					if (java.contains(im) == false) {
						java += sc + im;
					}
				} else if (att.isBigDecimal()) {
					im = "import com.massoftware.ui.util.DoubleToBigDecimalConverter;";
					if (java.contains(im) == false) {
						java += sc + im;
					}
				} else if (att.isLong()) {
					im = "import com.massoftware.ui.util.DoubleToLongConverter;";
					if (java.contains(im) == false) {
						java += sc + im;
					}
				}

			} else if (att.isDate()) {

				String im = "import com.vaadin.flow.component.datepicker.DatePicker;";

				if (java.contains(im) == false) {
					java += sc + im;
				}

			} else if (att.isTimestamp()) {

			} else if (att.isString()) {

				String im = "import com.vaadin.flow.component.textfield.TextField;";

				if (java.contains(im) == false) {
					java += sc + im;
				}

			} else if (att.isBoolean()) {

				String im = "import com.vaadin.flow.component.combobox.ComboBox;";

				if (java.contains(im) == false) {
					java += sc + im;
				}

				im = "import com.massoftware.service.FBoolean;";

				if (java.contains(im) == false) {
					java += sc + im;
				}

			} else if (att.isSimple() == false) {
				String im = "import com.vaadin.flow.component.combobox.ComboBox;";

				if (java.contains(im) == false) {
					java += sc + im;
				}

				im = "import java.util.List;";

				if (java.contains(im) == false) {
					java += sc + im;
				}

				DataTypeClazz dt = (DataTypeClazz) att.getDataType();

				String java1 = "\nimport com.massoftware.service." + dt.getClazz().getNamePackage() + "."
						+ dt.getClazz().getName() + ";";
				if (java.contains(java1) == false
						&& clazzX.getNamePackage().equals(dt.getClazz().getNamePackage()) == false) {
					java += java1;
				}

				// java1 = "\nimport com.massoftware.service." + dt.getClazz().getNamePackage()
				// + "."
				// + dt.getClazz().getNamePlural() + "Filtro;";
				// if (java.contains(java1) == false
				// && clazzX.getNamePackage().equals(dt.getClazz().getNamePackage()) == false) {
				// java += java1;
				// }
				//
				// java1 = "\nimport com.massoftware.service." + dt.getClazz().getNamePackage()
				// + "."
				// + dt.getClazz().getName() + "Service;";
				// if (java.contains(java1) == false
				// && clazzX.getNamePackage().equals(dt.getClazz().getNamePackage()) == false) {
				// java += java1;
				// }

			}
		}

		java += "\n";

		return java;
	}

	private static String buildDeclareControls(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			String sc = "\n\t";

			if (att.isNumber()) {

				java += sc + "private NumberField " + att.getName() + ";";

			} else if (att.isDate()) {

				java += sc + "private DatePicker " + att.getName() + ";";

			} else if (att.isTimestamp()) {

			} else if (att.isString()) {

				java += sc + "private TextField " + att.getName() + ";";

			} else if (att.isBoolean()) {

				java += sc + "private ComboBox<FBoolean> " + att.getName() + ";";

			} else if (att.isSimple() == false) {
				java += sc + "private ComboBox<" + att.getDataType().getName() + "> " + att.getName() + ";";
			}
		}

		java += "\n";

		return java;
	}

	private static String buildInstanceControls(Clazz clazzX) {
		String java = "";

		int digit = 0;

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			digit++;

			Att att = clazzX.getAtts().get(i);

			// String t1 = "\n\t";
			String t2 = "\n\t\t";
			String t3 = "\n\t\t\t";
			String t4 = "\n\t\t\t\t";

			if (att.isNumber()) {

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
				
				

				java += "\n\n\t\t//-------------------------------------------------------------------";

				String f = "";
				String f2 = "";

				java += t2 + "// " + att.getLabel() + " (" + f2 + ")";
				java += t2 + att.getName() + f + " = new NumberField();";
				if (att.isRequired()) {
					// java += t2 + arg.getName() + ".setRequired(true);";
				}
				if (min != null) {
					java += t2 + att.getName() + f + ".setMin(" + min + ");";
				}
				if (max != null) {
					java += t2 + att.getName() + f + ".setMax(" + max + ");";
				}
				java += t2 + att.getName() + f + ".setPlaceholder(\"" + att.getLabel() + f2 + " \");";
				java += t2 + att.getName() + f + ".setPrefixComponent(VaadinIcon.SEARCH.create());";
				java += t2 + att.getName() + f + ".setClearButtonVisible(true);";
				// java += t2 + att.getName() + f + ".addFocusShortcut(Key.DIGIT_" + digit + ",
				// KeyModifier.ALT);";
				java += t2 + "binder.forField(" + att.getName() + f + ")";
				if (att.isRequired()) {
					java += t3 + ".asRequired(\"" + att.getLabel() + " es requerido.\")		";
				}
				if (att.isInteger()) {
					java += t3 + ".withConverter(new DoubleToIntegerConverter())";
				} else if (att.isBigDecimal()) {
					java += t3 + ".withConverter(new DoubleToBigDecimalConverter())";
				} else if (att.isLong()) {
					java += t3 + ".withConverter(new DoubleToLongConverter())";
				} else if (att.isDouble()) {

				} else {
					java += t3 + "666";
				}
				if (att.isBigDecimal() == false) {
					java += t3 + ".withValidator(value -> (value != null) ? value >= " + min
							+ " : true, \"El valor tiene que ser >= " + min + "\")";
					java += t3 + ".withValidator(value -> (value != null) ? value <= " + max
							+ " : true,\"El valor tiene que ser <= \" + " + max + ")";
				}
				java += t3 + ".bind(" + clazzX.getName() + "::get" + toCamelStart(att.getName()) + f + ", "
						+ clazzX.getName() + "::set" + toCamelStart(att.getName()) + f + ");";

				// java += t2 + arg.getName() + f + ".addKeyPressListener(Key.ENTER, event ->
				// {";
				// java += t3 + "search();";
				// java += t2 + "});";
				// java += t2 + arg.getName() + f + ".addValueChangeListener(event -> {";
				// java += t2 + "if (event.getValue() == null ||
				// event.getValue().toString().trim().length() == 0) {";
				// java += t3 + "search();";
				// java += t2 + "}";
				// java += t2 + "});";
				// java += t2 + arg.getName() + f + ".addBlurListener(event -> {";
				// java += t3 + "search();";
				// java += t2 + "});";

			} else if (att.isDate()) {

			} else if (att.isTimestamp()) {

			} else if (att.isString()) {

				// java += sc + "private TextField " + arg.getName() + ";";

				java += "\n\n\t\t//-------------------------------------------------------------------";
				java += t2 + "// " + att.getLabel() + "";
				java += t2 + att.getName() + " = new TextField();";
				if (att.isRequired()) {
					java += t2 + att.getName() + ".setRequired(true);";
				}
				java += t2 + att.getName() + ".setPlaceholder(\"" + att.getLabel() + "\");";
				java += t2 + att.getName() + ".setPrefixComponent(VaadinIcon.SEARCH.create());";
				java += t2 + att.getName() + ".setWidthFull();";
				java += t2 + att.getName() + ".setClearButtonVisible(true);";
				java += t2 + att.getName() + ".setAutoselect(true);";
				// java += t2 + att.getName() + ".addFocusShortcut(Key.DIGIT_" + digit + ",
				// KeyModifier.ALT);";

				java += t2 + "binder.forField(" + att.getName() + ")";
				if (att.isRequired()) {
					java += t3 + ".asRequired(\"" + att.getLabel() + " es requerido.\")		";
				}
				java += t3 + ".bind(" + clazzX.getName() + "::get" + toCamelStart(att.getName()) + ", "
						+ clazzX.getName() + "::set" + toCamelStart(att.getName()) + ");";

				// java += t2 + arg.getName() + ".addKeyPressListener(Key.ENTER, event -> {";
				// java += t3 + "search();";
				// java += t2 + "});";
				// java += t2 + arg.getName() + ".addValueChangeListener(event -> {";
				// java += t3 + "if (event.getValue() == null ||
				// event.getValue().toString().trim().length() == 0) {";
				// java += t4 + "search();";
				// java += t3 + "}";
				// java += t2 + "});";
				// java += t2 + arg.getName() + ".addBlurListener(event -> {";
				// java += t3 + "search();";
				// java += t2 + "});";

			} else if (att.isBoolean()) {

				java += "\n\n\t\t//-------------------------------------------------------------------";
				java += t2 + "// " + att.getLabel() + "";
				// java += t2 + att.getName() + " = new ComboBox<>();";
				// if (att.isRequired()) {
				// java += t2 + att.getName() + ".setRequired(true);";
				// }
				// java += t2 + att.getName() + ".setPlaceholder(\"" + att.getLabel() + ":
				// Todos\");";
				// java += t2 + "FBoolean value" + toCamelStart(att.getName()) + " = new
				// FBoolean(\"" + att.getLabel()
				// + ": \", null, \"Todos\");";
				// java += t2 + att.getName() + ".setItems(value" + toCamelStart(att.getName())
				// + ", new FBoolean(\""
				// + att.getLabel() + ": \", true, \"Si\"), new FBoolean(\"" + att.getLabel()
				// + ": \", false, \"No\"));";
				// java += t2 + att.getName() + ".setValue(value" + toCamelStart(att.getName())
				// + ");";
				// java += t2 + "binder.forField(" + att.getName() + ")";
				// if (att.isRequired()) {
				// java += t3 + ".asRequired(\"" + att.getLabel() + " es requerido.\") ";
				// }
				// java += t3 + ".bind(" + clazzX.getName() + "::get" +
				// toCamelStart(att.getName()) + "X, "
				// + clazzX.getName() + "::set" + toCamelStart(att.getName()) + "X);";

				// java += t2 + arg.getName() + ".addValueChangeListener(event -> {";
				// java += t3 + "search();";
				// java += t2 + "});";
				// java += t2 + arg.getName() + ".addBlurListener(event -> {";
				// java += t3 + "search();";
				// java += t2 + "});";

			} else if (att.isSimple() == false) {

				java += "\n\n\t\t//-------------------------------------------------------------------";
				java += t2 + "// " + att.getLabel() + "";
				java += t2 + att.getName() + " = new ComboBox<>();";
				if (att.isRequired()) {
					java += t2 + att.getName() + ".setRequired(true);";
				}
				java += t2 + att.getName() + ".setPlaceholder(\"" + att.getLabel() + "\");";

				// java += t2 + att.getDataType().getName() + "Service " + att.getName() +
				// "Service = new "
				// + att.getDataType().getName() + "Service();";
				// java += t2 + att.getDataType().getNamePlural() + "Filtro " + att.getName() +
				// "Filtro = new "
				// + att.getDataType().getNamePlural() + "Filtro();";
				// java += t2 + att.getName() + "Filtro.setUnlimited(true);";
				// java += t2 + "List<" + att.getDataType().getNamePlural() + "> " +
				// att.getName() + "Items = "
				// + att.getName() + "Service.find(" + att.getName() + "Filtro);";
				//
				// java += t2 + att.getName() + ".setItems(" + att.getName() + "Items);";
				// java += t2 + arg.getName() + ".setValue(value" + toCamelStart(arg.getName())
				// + ");";

				java += t2 + "binder.forField(" + att.getName() + ")";
				if (att.isRequired()) {
					java += t3 + ".asRequired(\"" + att.getLabel() + " es requerido.\")		";
				}
				java += t3 + ".bind(" + clazzX.getName() + "::get" + toCamelStart(att.getName()) + ", "
						+ clazzX.getName() + "::set" + toCamelStart(att.getName()) + ");";

				// java += t2 + "if(" + att.getName() + "Items.size() > 0){";
				// java += t3 + att.getName() + ".setValue(" + att.getName() + "Items.get(0));";
				// java += t2 + "}";

				// java += t2 + arg.getName() + ".addValueChangeListener(event -> {";
				// java += t3 + "search();";
				// java += t2 + "});";
				// java += t2 + arg.getName() + ".addBlurListener(event -> {";
				// java += t3 + "search();";
				// java += t2 + "});";
			}
		}

		java += "\n";

		return java;
	}

	private static String buildCheck(Clazz clazzX) {
		String java = "";

		for (int i = 0; i < clazzX.getAtts().size(); i++) {

			Att att = clazzX.getAtts().get(i);

			if (att.isRequired() == false) {
				continue;
			}

			String sc = "\n\t";

			java += sc + buildRequired(clazzX.getName(), att.getName());

			// if (att.isNumber()) {
			//
			// java += sc + buildRequired(clazzX.getNamePlural(), att.getName());}
			//
			// } else if (att.isDate()) {
			//
			// java += sc + buildRequired(clazzX.getNamePlural(), att.getName());
			//
			// } else if (att.isTimestamp()) {
			//
			// java += sc + buildRequired(clazzX.getNamePlural(), att.getName());
			//
			// } else if (att.isString()) {
			//
			// java += sc + buildRequired(clazzX.getNamePlural(), att.getName());
			//
			// } else if (att.isBoolean()) {
			//
			// java += sc + buildRequired(clazzX.getNamePlural(), att.getName());
			//
			// } else if (att.isSimple() == false) {
			//
			// java += sc + buildRequired(clazzX.getNamePlural(), att.getName());
			// }
		}

		java += "\n";

		return java;
	}

	private static String buildRequired(String m, String n) {
		String s = "";

		s += "\n\t\tif (filter.get" + toCamelStart(n) + "() == null || filter.get" + toCamelStart(n)
				+ "().toString().trim().isEmpty()) {";

		s += "\n\t\t\t" + n + ".setInvalid(true);";

		s += "\n\t\t}";

		return s;
	}

}
