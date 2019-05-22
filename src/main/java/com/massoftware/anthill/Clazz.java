package com.massoftware.anthill;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Clazz {

	private String namePackage;
	private String name;
	private String singular;
	private String plural;
	private String singularPre;
	private String pluralPre;
	private List<Att> atts = new ArrayList<Att>();
	private List<Argument> args = new ArrayList<Argument>();
	private List<Order> orderAtts = new ArrayList<Order>();
	private List<Uniques> uniques = new ArrayList<Uniques>();
	private List<Argument> argsSBX = new ArrayList<Argument>();
	private Order orderDefault;	

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
		if(orderDefault == null) {
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

	public String toJavaFilter() {
		return UtilJavaPOJOFilter.toJavaFilter(this);
	}

	public String toJavaDao() {
		return UtilJavaDAO.toJavaDao(this);
	}

	public String toJavaWL() throws IOException {
		return UtilJavaList.toJavaWL(this);
	}

	public String toJavaWF() throws IOException {
		return UtilJavaForm.toJavaWF(this);
	}

	public String toPopulateJava() {
		return UtilJavaPopulate.toPopulateJava(this);
	}

	public String toSQL() {
		return UtilSQL.toSQL(this);
	}

} //////////////////////////////////////////////////////////////////////////////////////////////
