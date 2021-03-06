package com.anthill.model.to_java;

import java.util.Random;

import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeBigDecimal;
import com.anthill.model.DataTypeClazz;
import com.anthill.model.DataTypeDouble;
import com.anthill.model.DataTypeInteger;
import com.anthill.model.DataTypeLong;

public class UtilJavaPopulate {

	private static String toCamelStart(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		return text.substring(0, 1).toUpperCase() + text.substring(1, text.length());
	}

	public static String toPopulateJava(Clazz clazzX) {
		String java = "";

		java += "\n";
		java += "\t";

		java += "public static void insert" + clazzX.getName() + "() throws Exception {";

		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += clazzX.getName() + "Service service = AppCX.services().build" + clazzX.getName() + "Service();";

		for (Att att : clazzX.getAtts()) {

			if (att.isSimple() == false) {

				DataTypeClazz dt = (DataTypeClazz) att.getDataType();

				java += "\n";
				java += "\t";
				java += "\t";				
//				java += dt.getClazz().getName() + "Service service" + dt.getClazz().getName() + " = AppCX.services().build"
//						+ dt.getClazz().getName() + "Service();";
				
				java += dt.getClazz().getName() + "Service service" + att.getName() + " = AppCX.services().build"
						+ dt.getClazz().getName() + "Service();";

				java += "\n";
				java += "\t";
				java += "\t";				
//				java += "Long " + att.getName() + "Count = service" + dt.getClazz().getName() + ".count();";
				java += "Long " + att.getName() + "Count = service" + att.getName() + ".count();";

			}

		}

		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "for(int i = 0; i < maxRows; i++){";

		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "try {";

		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "\t";
		java += clazzX.getName() + " obj = new " + clazzX.getName() + "();";

		for (Att att : clazzX.getAtts()) {

			java += "\n";

			if (att.isBigDecimal()) {

				DataTypeBigDecimal td = (DataTypeBigDecimal) att.getDataType();

				td.getPrecision();

				String min = null;
				String max = null;

				if (td.getMaxValue() != null) {
					max = "new java.math.BigDecimal(\"" + td.getMaxValue() + "\")";
				}
				if (td.getMinValue() != null) {
					min = "new java.math.BigDecimal(\"" + td.getMinValue() + "\")";
				}

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "obj.set" + toCamelStart(att.getName()) + "(UtilPopulate.getBigDecimalRandom(" + min + ", "
						+ max + ", " + att.isRequired() + ", " + td.getPrecision() + ", " + td.getScale() + "));";

			} else if (att.isDouble()) {

				DataTypeDouble td = (DataTypeDouble) att.getDataType();

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "obj.set" + toCamelStart(att.getName()) + "(UtilPopulate.getDoubleRandom(" + td.getMinValue()
						+ ", " + td.getMaxValue() + ", " + att.isRequired() + "));";

			} else if (att.isLong()) {

				DataTypeLong td = (DataTypeLong) att.getDataType();

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "obj.set" + toCamelStart(att.getName()) + "(UtilPopulate.getLongRandom(" + td.getMinValue()
						+ "L, " + td.getMaxValue() + "L, " + att.isRequired() + "));";

			} else if (att.isInteger()) {

				DataTypeInteger td = (DataTypeInteger) att.getDataType();

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "obj.set" + toCamelStart(att.getName()) + "(UtilPopulate.getIntegerRandom(" + td.getMinValue()
						+ ", " + td.getMaxValue() + ", " + att.isRequired() + "));";

			} else if (att.isBoolean()) {

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "obj.set" + toCamelStart(att.getName()) + "(new Random().nextBoolean());";

			} else if (att.isString()) {

				int leftLimit = 97; // letter 'a'
				int rightLimit = 122; // letter 'z'
				int targetStringLength = 30;

				if (att.getMinLength() != null && att.getMaxLength() != null) {
					targetStringLength = att.getMaxLength();
				} else if (att.getMinLength() != null && att.getMaxLength() == null) {
					targetStringLength = att.getMinLength();
				} else if (att.getMinLength() == null && att.getMaxLength() != null) {
					targetStringLength = att.getMaxLength();
				}

				Random r = new Random();

				StringBuilder buffer = new StringBuilder(targetStringLength);

				for (int i = 0; i < targetStringLength; i++) {

					int randomLimitedInt = leftLimit + (int) (r.nextFloat() * (rightLimit - leftLimit + 1));
					buffer.append((char) randomLimitedInt);

				}

				String value = buffer.toString();

				if (att.isRequired() == false) {
					value = (r.nextBoolean()) ? value : null;
				}

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "obj.set" + toCamelStart(att.getName()) + "(UtilPopulate.getStringRandom(" + att.getMinLength()
						+ ", " + att.getMaxLength() + ", " + att.isRequired() + "));";

			} else if (att.isDate()) {

				// long offset = Timestamp.valueOf("2012-01-01 00:00:00").getTime();
				// long end = Timestamp.valueOf("2013-01-01 00:00:00").getTime();
				// long diff = end - offset + 1;
				// long value = offset + (long) (Math.random() * diff);
				//
				// if (att.isRequired() == false) {
				// value = (new Random().nextBoolean()) ? value : null;
				// }

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
//				java += "obj.set" + toCamelStart(att.getName()) + "(new java.util.Date(UtilPopulate.getDateRandom(2000, 2019, " + att.isRequired() + ")));";
				java += "obj.set" + toCamelStart(att.getName()) + "(UtilPopulate.getDateRandom(2000, 2019, " + att.isRequired() + "));";

			} else if (att.isTimestamp()) {

				// long offset = Timestamp.valueOf("2012-01-01 00:00:00").getTime();
				// long end = Timestamp.valueOf("2013-01-01 00:00:00").getTime();
				// long diff = end - offset + 1;
				// long value = offset + (long) (Math.random() * diff);
				//
				// if (att.isRequired() == false) {
				// value = (new Random().nextBoolean()) ? value : null;
				// }
				//
				// java += "\n";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "obj.set" + this.toCamelStart(att.getName()) + "(new
				// java.sql.Timestamp(" + value + "L));";

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
//				java += "obj.set" + toCamelStart(att.getName())
//						+ "(new java.sql.Timestamp(UtilPopulate.getTimestampRandom(2000, 2019, " + att.isRequired() + ")));";
				java += "obj.set" + toCamelStart(att.getName()) + "(UtilPopulate.getDateTimeRandom(2000, 2019, " + att.isRequired() + "));";

			} else if (att.isSimple() == false) {

				DataTypeClazz dt = (DataTypeClazz) att.getDataType();

				// java += "\n";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += dt.getClazz().getName() + "DAO dao" + dt.getClazz().getName() + " =
				// new "
				// + dt.getClazz().getName() + "DAO();";

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += dt.getClazz().getNamePlural() + "Filtro " + att.getName() + "Filtro = new " + dt.getClazz().getNamePlural()
						+ "Filtro();";

				// java += "\n";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "filtro.setUnlimited(true);";

				// java += "\n";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "Long " + att.getName() + "Count = dao" + dt.getClazz().getName() +
				// ".count();";

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "int " + att.getName() + "Index = UtilPopulate.getIntegerRandom(0, " + att.getName()
						+ "Count.intValue()-1);";

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				java += att.getName() + "Filtro.setOffset(" + att.getName() + "Index);";

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
//				java += att.getName() + "Filtro.setLimit(" + att.getName() + "Index);";
				java += att.getName() + "Filtro.setLimit(1);";

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
//				java += "List<" + dt.getClazz().getName() + "> " + att.getName() + "Listado = service"
//						+ dt.getClazz().getName() + ".find(" + att.getName() + "Filtro);";
				java += "List<" + dt.getClazz().getNamePlural() + "> " + att.getName() + "Listado = service"
						+ att.getName() + ".find(" + att.getName() + "Filtro);";

				// java += "\n";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// java += "\t";
				// // java += "int index = new Random().nextInt(((listado.size()-1) - 0) + 1) +
				// // (listado.size()-1);";
				// java += "int index = UtilPopulate.getIntegerRandom(0, listado.size()-1);";

				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";				
				java += toCamelStart(att.getDataType().getName()) + " objFk" + toCamelStart(att.getName()) + "  = new " + toCamelStart(att.getDataType().getName()) + "();";
				
				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";				
				java += "objFk" + toCamelStart(att.getName()) + ".setId(" + att.getName() + "Listado.get(0).getId());";
				
				java += "\n";
				java += "\t";
				java += "\t";
				java += "\t";
				java += "\t";
				// java += "obj.set" + toCamelStart(att.getName()) + "(listado.get(index));";				
				java += "obj.set" + toCamelStart(att.getName()) + "(objFk" + toCamelStart(att.getName()) + ");";

			}

		}

		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "service.insert(obj);";

		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "} catch (org.dsw.SQLExceptionWrapper e) {";
		
		
//		System.out.println(e.getSQLState());
//		
//		if("23505".equals(e.getSQLState()) || "23502".equals(e.getSQLState()) ) {					
//				
//		} else {
//			throw e;
//		}
		
		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "if((\"23505\".equals(e.getSQLState()) || \"23502\".equals(e.getSQLState()) || \"23514\".equals(e.getSQLState()) ) == false ) {	";
		
		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "throw e;";
		
		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "}";
		
		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "\t";
		java += "}";
		
		

		java += "\n";
		java += "\n";
		java += "\t";
		java += "\t";
		java += "}";

		java += "\n";
		java += "\n";
		java += "\t";
		java += "}";

		java += "\n";

		return java;
	}

}
