package a.dao.op;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;

import a.convention1.pg.UtilConvention1Pg;

public class Mapper {

	private UtilConvention1Pg util;

	public Mapper() {
		super();
		util = new UtilConvention1Pg();
	}

	@SuppressWarnings({ "rawtypes", "unused" })
	public Object fill(Class instanceClass, String[] pathMapping, Object[] row)
			throws InstantiationException, IllegalAccessException, NoSuchMethodException, SecurityException,
			IllegalArgumentException, InvocationTargetException {

		if (pathMapping == null) {
			throw new IllegalArgumentException("Se esperaba un array de path's no nulo.");
		}

		if (pathMapping.length == 0) {
			throw new IllegalArgumentException("Se esperaba un array path's no vacio.");
		}

		if (row == null) {
			throw new IllegalArgumentException("Se esperaba un array de valores no nulo.");
		}

		if (row.length == 0) {
			throw new IllegalArgumentException("Se esperaba un array valores no vacio.");
		}

		if (pathMapping.length != row.length) {
			throw new IllegalStateException(
					"Se esperaba un array de rutas de campos, del mismo tamaño que el array de valores.");
		}

		Object root = instanceClass.newInstance();

		for (int i = 0; i < pathMapping.length; i++) {

			if (pathMapping[i] == null || pathMapping[i].trim().isEmpty()) {
				throw new IllegalStateException("Se esperaba un array de rutas de campos no vacias o nulas.");
			}

			Object value = row[i];
			String[] pathCanonicalArray = pathMapping[i].split("[.]");
			String attName = pathCanonicalArray[pathCanonicalArray.length - 1];
			String[] phatPrefixArray = new String[0];
			if (pathCanonicalArray.length > 1) {
				phatPrefixArray = Arrays.copyOf(pathCanonicalArray, pathCanonicalArray.length - 1);
			}

			Object objSet = root;

			if (phatPrefixArray.length > 0) {

				Object objPerfix = root;

				for (String attNamePrefix : phatPrefixArray) {
					objPerfix = searchPrefixObject(objPerfix, attNamePrefix);
				}

				objSet = objPerfix;

			}

			Method methodGet = objSet.getClass().getMethod("get" + util.toCamelCase(attName));

			if (methodGet != null && util.isList(methodGet.getReturnType()) == false
					&& util.isScalar(methodGet.getReturnType()) == true) {

				Class[] argTypes = new Class[] { methodGet.getReturnType() };

				Method methodSet = objSet.getClass().getDeclaredMethod("set" + util.toCamelCase(attName), argTypes);

				methodSet.invoke(objSet, value);

			}

		}

		return root;
	}

	@SuppressWarnings("rawtypes")
	private Object searchPrefixObject(Object root, String attName) throws NoSuchMethodException, SecurityException,
			IllegalAccessException, IllegalArgumentException, InvocationTargetException, InstantiationException {

		Object objValue = null;

		boolean existsMethod = false;

		for (Method method : root.getClass().getMethods()) {
			if (method.getName().equals("get" + util.toCamelCase(attName))) {
				existsMethod = true;
			}
		}

		if (existsMethod) {

			Method methodGet = root.getClass().getMethod("get" + util.toCamelCase(attName));

			if (methodGet != null && util.isList(methodGet.getReturnType()) == false
					&& util.isScalar(methodGet.getReturnType()) == false) {

				objValue = methodGet.invoke(root);

				if (objValue == null) {

					objValue = methodGet.getReturnType().newInstance();

					Class[] argTypes = new Class[] { methodGet.getReturnType() };

					Method methodSet = root.getClass().getDeclaredMethod("set" + util.toCamelCase(attName), argTypes);

					methodSet.invoke(root, objValue);
				}

			}

		}

		return objValue;

	}

}
