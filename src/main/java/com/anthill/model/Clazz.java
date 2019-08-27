package com.anthill.model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.anthill.UtilAnthill;
import com.anthill.model.to_java.UtilJavaDao;
import com.anthill.model.to_java.UtilJavaForm;
import com.anthill.model.to_java.UtilJavaPOJO;
import com.anthill.model.to_java.UtilJavaPOJOFilter;
import com.anthill.model.to_java.UtilJavaPopulate;
import com.anthill.model.to_java.UtilJavaService;
import com.anthill.model.to_java.UtilJavaStm;
import com.anthill.model.to_java.UtilJavaUIGrid;
import com.anthill.model.to_java.UtilJavaUIGridView;
import com.anthill.model.to_sql.FunctionFind;
import com.anthill.model.to_sql.UtilSQLDelete;
import com.anthill.model.to_sql.UtilSQLFindExists;
import com.anthill.model.to_sql.UtilSQLFindNextValue;
import com.anthill.model.to_sql.UtilSQLInsert;
import com.anthill.model.to_sql.UtilSQLTable;
import com.anthill.model.to_sql.UtilSQLUpdate;
import com.anthill.to_sql.type.Type;

public class Clazz {

	private String namePackage;
	private String name;
	private String namePlural;
	private String singular;
	private String plural;
	private String singularPre;
	private String pluralPre;
	private List<Att> atts = new ArrayList<Att>();
	private List<Att> attsGrid = new ArrayList<Att>();
	private List<Argument> args = new ArrayList<Argument>();
	private List<Order> orderAtts = new ArrayList<Order>();
	private List<Uniques> uniques = new ArrayList<Uniques>();
	private List<Argument> argsSBX = new ArrayList<Argument>();
	private Order orderDefault;

	private boolean buildStm = true;

	public boolean isBuildStm() {
		return buildStm;
	}

	public void setBuildStm(boolean buildStm) {
		this.buildStm = buildStm;
	}

	public Integer _index;

	public String getNamePackage() {
		return namePackage;
	}

	public void setNamePackage(String namePackage) {
		this.namePackage = namePackage;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNamePlural() {
		return namePlural;
	}

	public void setNamePlural(String namePlural) {
		this.namePlural = namePlural;
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

	public List<Att> getAttsGrid() {
		return attsGrid;
	}

	public void setAttsGrid(List<Att> attsGrid) {
		this.attsGrid = attsGrid;
	}

	public boolean addAttGrid(Att e) {
		e.setClazz(this);
		return attsGrid.add(e);
	}

	public List<Argument> getArgs() {
		return args;
	}

	public void setArgs(List<Argument> args) {
		this.args = args;
	}

	public boolean addArgument(Att att) throws CloneNotSupportedException {
		return args.add(new Argument(att));
	}

	public Argument getLastArgument() {
		if (args.size() > 0) {
			return args.get(args.size() - 1);
		}

		return null;
	}

	public boolean addArgument(Att att, Boolean range) throws CloneNotSupportedException {
		return args.add(new Argument(att, range));
	}

	public boolean addArgument(Att att, String searchOption) throws CloneNotSupportedException {
		return args.add(new Argument(att, searchOption));
	}

	public List<Argument> getArgsSBX() {
		return argsSBX;
	}

	public void setArgsSBX(List<Argument> argsSBX) {
		this.argsSBX = argsSBX;
	}

	public boolean addArgumentSBX(Argument arg) throws CloneNotSupportedException {
		return argsSBX.add(arg);
	}

	public List<Order> getOrderAtts() {
		return orderAtts;
	}

	public void setOrderAtts(List<Order> orderAtts) {
		this.orderAtts = orderAtts;
	}

	public void addOrderAllAtts() {
		for (Att att : this.getAtts()) {
			addOrder(att);
		}
	}

	public boolean addOrder(Att att) {
		return orderAtts.add(new Order(att));
	}

	// public boolean addOrder(Att att, Boolean desc) {
	// return orderAtts.add(new Order(att, desc));
	// }

	public List<Uniques> getUniques() {
		return uniques;
	}

	public void setUniques(List<Uniques> uniques) {
		this.uniques = uniques;
	}

	public boolean addUniques(Uniques e) {
		return uniques.add(e);
	}

	public boolean addUniques(Unique... args) {
		return uniques.add(new Uniques(args));
	}

	public boolean addUniques(Att... args) {
		return uniques.add(new Uniques(args));
	}

	public Order getOrderDefault() {
		if (orderDefault == null) {
			orderDefault = this.getOrderAtts().get(0);
		}
		return orderDefault;
	}

	public void setOrderDefault(Order orderDefault) {
		this.orderDefault = orderDefault;
	}

	////////////////////////////////////////////

	public String toJava() {
		return UtilJavaPOJO.toJava(this);
	}

	public String toJavaGrid() {

		String nameTmp = this.getName();
		List<Att> attsTmp = this.getAtts();

		this.setName(this.getNamePlural());
		this.setAtts(this.getAttsGrid());

		String src = UtilJavaPOJO.toJava(this);

		this.setName(nameTmp);
		this.setAtts(attsTmp);

		return src;
	}

	public String toJavaFilter() {
		return UtilJavaPOJOFilter.toJavaFilter(this);
	}

	public String toJavaStm() throws IOException {
		return UtilJavaStm.toJavaStm(this);
	}

	public String toJavaDao() throws IOException {
		return UtilJavaDao.toJavaDao(this);
	}

	public String toJavaService() throws IOException {
		return UtilJavaService.toJava(this);
	}

	public String toJavaUIGrid() throws IOException {
		return UtilJavaUIGrid.toJava(this);
	}

	public String toJavaUIGridView() throws IOException {
		return UtilJavaUIGridView.toJava(this);
	}

	public String toJavaWF() throws IOException {
		return UtilJavaForm.toJavaWF(this);
	}

	public String toPopulateJava() {
		return UtilJavaPopulate.toPopulateJava(this);
	}

	public String toSQL() {
		String sql = "";

		sql += UtilAnthill.toSQLHeaderTable(this);

		sql += UtilSQLTable.buildSQLTabla(this);

		sql += buildSQLSelects(this);

		// sql += UtilSQLFindExists.buildSQLFindExists(this);

		// sql += UtilSQLFindNextValue.buildSQLFindNextValue(this);

		// sql += UtilSQLDelete.buildSQLDeleteById(this);

		// sql += UtilSQLInsert.buildSQLInsert(this);

		// sql += UtilSQLUpdate.buildSQLUpdate(this);

		// sql += toSQLType(false);

		// sql += new FunctionFind().toSQL(this);

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

	public String toSQLTable() {
		return UtilSQLTable.toSQLTable(this);
	}

	public String toSQLFindExists() {
		return UtilSQLFindExists.toSQLFindExists(this);
	}

	public String toSQLFindNextValue() {
		return UtilSQLFindNextValue.toSQLFindNextValue(this);
	}

	// public String toSQLFindById(boolean view) {
	// return UtilSQLFindById.toSQLFindById(this, view);
	// }

	public String toSQLFind() {
		String sql = "";

		sql += UtilAnthill.toSQLHeaderTable(this);

		sql += new FunctionFind().toSQL(this);

		return sql;
	}

	// public String toSQLFind0(boolean view) {
	// return UtilSQL.toSQLFind0(this, view);
	// }
	//
	// public String toSQLFind1(boolean view) {
	// return UtilSQL.toSQLFind1(this, view);
	// }
	//
	// public String toSQLFind2(boolean view) {
	// return UtilSQL.toSQLFind2(this, view);
	// }
	//
	// public String toSQLFind3(boolean view) {
	// return UtilSQL.toSQLFind3(this, view);
	// }

	public String toSQLType() {
		return toSQLType(true);
	}

	public String toSQLType(boolean header) {
		String sql = "";

		String sqlTmp = new Type().toSQL(this);

		if (sqlTmp == null || sqlTmp.trim().length() == 0) {
			return "";
		}

		if (header) {
			sql += UtilAnthill.toSQLHeaderTable(this);
		}

		sql += sqlTmp;

		return sql;
	}

	// public String toSQLView() {
	// return UtilSQLView.toSQLView(this);
	// }

	public String toSQLInsert() {
		return UtilSQLInsert.toSQLInsert(this);
	}

	public String toSQLUpdate() {
		return UtilSQLUpdate.toSQLUpdate(this);
	}

	public String toSQLDeleteById() {
		return UtilSQLDelete.toSQLDeleteById(this);
	}

} //////////////////////////////////////////////////////////////////////////////////////////////
