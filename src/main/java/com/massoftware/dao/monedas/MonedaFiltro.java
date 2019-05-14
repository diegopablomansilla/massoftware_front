package com.massoftware.dao.monedas;

import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.Entity;

public class MonedaFiltro extends Entity {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "Unlimited")
	private Boolean unlimited = false;

	@FieldConfAnont(label = "Limit")
	private Integer limit;

	@FieldConfAnont(label = "Offset")
	private Integer offset;

	@FieldConfAnont(label = "Order by att")
	private String orderBy;

	@FieldConfAnont(label = "Order by desc")
	private Boolean orderByDesc = false;

	@FieldConfAnont(label = "Level")
	private Integer level = 0;

	// Nº moneda (desde)
	@FieldConfAnont(label = "Nº moneda (desde)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroFrom;

	// Nº moneda (hasta)
	@FieldConfAnont(label = "Nº moneda (hasta)", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroTo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", readOnly = false, required = false, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET Unlimited
	public Boolean getUnlimited() {
		return this.unlimited;
	}

	// SET Unlimited
	public void setUnlimited(Boolean unlimited){
		unlimited = (unlimited == null) ? false : unlimited;
		this.unlimited = unlimited;
	}

	// GET Limit
	public Integer getLimit() {
		return this.limit;
	}

	// SET Limit
	public void setLimit(Integer limit){
		limit = (limit == null || limit < 1) ? 100 : limit;
		this.limit = limit;
	}

	// GET Offset
	public Integer getOffset() {
		return this.offset;
	}

	// SET Offset
	public void setOffset(Integer offset){
		offset = (offset == null || offset < 0) ? 0 : offset;
		this.offset = offset;
	}

	// GET Order by att
	public String getOrderBy() {
		return this.orderBy;
	}

	// SET Order by att
	public void setOrderBy(String orderBy){
		this.orderBy = orderBy;
	}

	// GET Order by desc
	public Boolean getOrderByDesc() {
		return this.orderByDesc;
	}

	// SET Order by desc
	public void setOrderByDesc(Boolean orderByDesc){
		orderByDesc = (orderByDesc == null) ? false : orderByDesc;
		this.orderByDesc = orderByDesc;
	}

	// GET Level
	public Integer getLevel() {
		return this.level;
	}

	// SET Level
	public void setLevel(Integer level){
		level = (level == null || level < 0) ? 0 : level;
		level = (level != null && level > 3) ? 3 : level;
		this.level = level;
	}

	// GET Nº moneda (desde)
	public Integer getNumeroFrom() {
		return this.numeroFrom;
	}

	// SET Nº moneda (desde)
	public void setNumeroFrom(Integer numeroFrom ){
		this.numeroFrom = numeroFrom;
	}

	// GET Nº moneda (hasta)
	public Integer getNumeroTo() {
		return this.numeroTo;
	}

	// SET Nº moneda (hasta)
	public void setNumeroTo(Integer numeroTo ){
		this.numeroTo = numeroTo;
	}

	// GET Nombre
	public String getNombre() {
		return this.nombre;
	}

	// SET Nombre
	public void setNombre(String nombre ){
		this.nombre = (nombre != null && nombre.trim().length() == 0) ? null : nombre;
	}

	// GET Abreviatura
	public String getAbreviatura() {
		return this.abreviatura;
	}

	// SET Abreviatura
	public void setAbreviatura(String abreviatura ){
		this.abreviatura = (abreviatura != null && abreviatura.trim().length() == 0) ? null : abreviatura;
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------