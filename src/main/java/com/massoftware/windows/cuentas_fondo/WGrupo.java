package com.massoftware.windows.cuentas_fondo;

import java.util.List;

import com.massoftware.Context;
import com.massoftware.model.EntityId;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.Property;
import com.vaadin.data.Property.ValueChangeEvent;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.validator.AbstractValidator;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.ComboBox;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

class WGrupo extends WindowForm {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private BeanItem<GrupoFiltro> filterBI;
	private BeanItem<Grupo> itemBIOriginal;
	private BeanItem<Grupo> itemBI;

	// -------------------------------------------------------------

	private ComboBox rubroCB;
	private TextField numeroTXT;
	private TextField nombreTXT;

	private List<Rubro> rubros;

	// -------------------------------------------------------------

	public WGrupo() {
		init(INSERT_MODE, null, null);
	}

	public WGrupo(String mode) {
		init(mode, null, null);
	}

	public WGrupo(String mode, GrupoFiltro filtro) {
		init(mode, filtro, null);
	}

	public WGrupo(Integer numeroRubro) {
		init(INSERT_MODE, null, numeroRubro);
	}

	private void init(String mode, GrupoFiltro filtro, Integer numeroRubro) {

		try {

			this.mode = mode;

			// =======================================================
			// FILTRO

			if (filtro != null) {
				filterBI = new BeanItem<GrupoFiltro>(filtro);
			} else {
				filterBI = new BeanItem<GrupoFiltro>(new GrupoFiltro());
			}

			// =======================================================
			// BEAN

			itemBIOriginal = new BeanItem<Grupo>(new Grupo());
			itemBI = new BeanItem<Grupo>(new Grupo());

			rubros = Context.getRubrosBO().findAllRubro();

			Rubro rubro = new Rubro();

			if (numeroRubro != null && INSERT_MODE.equals(mode)) {
				for (Rubro item : rubros) {
					if (item.getNumero().equals(numeroRubro)) {
						rubro = item;
					}
				}
			}

			itemBIOriginal.getBean().setRubro(rubro.clone());
			itemBI.getBean().setRubro(rubro);

			// =======================================================
			// LAYOUT CONTROLs

			buildContent();

			// =======================================================
			// KEY EVENTs

			addKeyEvents();

			// =======================================================
			// CARGA DE DATOS

//			loadData(filterBI.getBean());777

			// =======================================================
			// ACTUALIZAR TITULO

			if (INSERT_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Agregar " + getCaption().toLowerCase());
			} else if (UPDATE_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Modificar " + getCaption().toLowerCase() + " : " + itemBI.getBean());
			} else if (COPY_MODE.equalsIgnoreCase(mode)) {
				this.setCaption("Copiar " + getCaption() + " : " + itemBI.getBean());
			}

			// =======================================================

		} catch (Exception e) {
			LogAndNotification.print(e);
		}
	}

	private void buildContent() throws Exception {

		confWinForm("Grupo");
		// this.setWidth(31f, Unit.EM);

		// =======================================================
		// CUERPO

		VerticalLayout cuerpo = buildCouerpo();

		// =======================================================
		// BOTONERAS

		HorizontalLayout filaBotoneraHL = buildBotonera1();

		// =======================================================
		// CONTENT

		VerticalLayout content = UtilUI.buildWinContentVertical();

		content.addComponents(cuerpo, filaBotoneraHL);

		content.setComponentAlignment(filaBotoneraHL, Alignment.MIDDLE_LEFT);

		this.setContent(content);
	}

	@SuppressWarnings({ "serial", "rawtypes" })
	private VerticalLayout buildCouerpo() throws Exception {

		// ---------------------------------------------------------------------------------------------------------

		// rubroCB = UtilUI.buildFieldCB(itemBI, "rubro", "Rubro", "numero", "nombre",
		// 30.0f, false, true, false,
		// Integer.class, Context.getRubrosBO().findAllRubro());

		rubroCB = UtilUI.buildFieldCB(itemBI, "rubro", "Rubro", false, false, Rubro.class, rubros);

		rubroCB.addValueChangeListener(e -> {
			validateRubroAndNumero();
		});

		// ---------------------------------------------------------------------------------------------------------

		numeroTXT = UtilUI.buildTXTShortPlus(itemBI, "numero", "Número", false, 1, true);

		numeroTXT.addValueChangeListener(new Property.ValueChangeListener() {
			public void valueChange(ValueChangeEvent event) {
				// String value = (String) event.getProperty().getValue();
				validateRubroAndNumero();
			}
		});

		// ---------------------------------------------------------------------------------------------------------

		nombreTXT = UtilUI.buildTXT(itemBI, "nombre", "Nombre", false, 30, 1, 30, true, false, null, false);
		nombreTXT.addValidator(new AbstractValidator("") {

			@Override
			protected boolean isValidValue(Object value) {

				try {

					String original = itemBIOriginal.getBean().getNombre();

					if (COPY_MODE.equals(mode)) {
						original = null;
					}

					Context.getGruposBO().checkUniqueNombre(nombreTXT.getCaption(), original, (String) value);

					return true;

				} catch (Exception e) {
					LogAndNotification.print(e);
					this.setErrorMessage(e.getMessage());
					return false;
				}

			}

			@Override
			public Class getType() {

				return String.class;
			}

		});

		// ---------------------------------------------------------------------------------------------------------

		VerticalLayout formVL = UtilUI.buildVL();
		formVL.addComponents(rubroCB, numeroTXT, nombreTXT);

		return formVL;
	}

	// =================================================================================

	protected void setMaxValues() throws Exception {
		itemBI.getBean().setNumero(maxNumero());
	}

	protected void setBean(Object obj) throws Exception {
		Grupo item = (Grupo) obj;

		itemBIOriginal.setBean(item.clone());
		itemBI.setBean(item);
	}

	// -----------------------------------------------------------------------------------

	protected void validateForm() {
		rubroCB.validate();
		numeroTXT.validate();
		nombreTXT.validate();
	}

	private void validateRubroAndNumero() {
		try {

			Integer numeroOriginal = itemBIOriginal.getBean().getNumero();
			Integer numero = itemBI.getBean().getNumero();

			Integer numeroRubroOriginal = itemBIOriginal.getBean().getRubro().getNumero();
			Integer numeroRubro = itemBI.getBean().getRubro().getNumero();

			if (COPY_MODE.equals(mode)) {
				numeroOriginal = null;
				numeroRubroOriginal = null;
			}

			Context.getGruposBO().checkUniqueRubroAndNumero(rubroCB.getCaption(), numeroTXT.getCaption(), numeroRubroOriginal,
					numeroRubro, numeroOriginal, numero);

		} catch (Exception ex) {
			LogAndNotification.print(ex);
		}
	}

	// =================================================================================
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

	public Integer maxNumero() throws Exception {
		return Context.getGruposBO().maxNumero(this.itemBI.getBean().getRubro().getNumero());

	}

	// metodo que realiza la consulta a la base de datos
//	protected Grupo queryData() {
//		try {
//
//			Grupo item = Context.getGruposBO().find(this.filterBI.getBean());
//
//			return item;
//
//		} catch (Exception e) {
//			LogAndNotification.print(e);
//		}
//
//		return new Grupo();
//	}

	protected Object insert() throws Exception {

		try {
			Context.getGruposBO().insert(this.itemBI.getBean());
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(this.itemBI.getBean().getRubro().getNumero(),
						this.itemBI.getBean().getNumero());
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	protected Object update() throws Exception {

		try {
			Context.getGruposBO().update(this.itemBIOriginal.getBean(), this.itemBI.getBean());
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(this.itemBI.getBean().getRubro().getNumero(),
						this.itemBI.getBean().getNumero());
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	@Override
	protected EntityId queryData() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void setBean(EntityId obj) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected EntityId getBean() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	// =================================================================================

}
