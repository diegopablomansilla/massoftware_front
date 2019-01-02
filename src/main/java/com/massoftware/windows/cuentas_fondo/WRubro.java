package com.massoftware.windows.cuentas_fondo;

import com.massoftware.Context;
import com.massoftware.model.EntityId;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.vaadin.data.util.BeanItem;
import com.vaadin.data.validator.AbstractValidator;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.TextField;
import com.vaadin.ui.VerticalLayout;

public class WRubro extends WindowForm {

	private static final long serialVersionUID = -6410625501465383928L;

	// -------------------------------------------------------------

	private BeanItem<RubroFiltro> filterBI;
	private BeanItem<Rubro> itemBIOriginal;
	private BeanItem<Rubro> itemBI;

	// -------------------------------------------------------------

	private TextField numeroTXT;
	private TextField nombreTXT;

	// -------------------------------------------------------------

	public WRubro() {
		init(INSERT_MODE, null);
	}

	public WRubro(String mode) {
		init(mode, null);
	}

	public WRubro(String mode, RubroFiltro filtro) {
		init(mode, filtro);
	}

	private void init(String mode, RubroFiltro filtro) {

		try {

			this.mode = mode;

			// =======================================================
			// FILTRO

			if (filtro != null) {
				filterBI = new BeanItem<RubroFiltro>(filtro);
			} else {
				filterBI = new BeanItem<RubroFiltro>(new RubroFiltro());
			}

			// =======================================================
			// BEAN

			itemBIOriginal = new BeanItem<Rubro>(new Rubro());
			itemBI = new BeanItem<Rubro>(new Rubro());

			// =======================================================
			// LAYOUT CONTROLs

			buildContent();

			// =======================================================
			// KEY EVENTs

			addKeyEvents();

			// =======================================================
			// CARGA DE DATOS

//			loadData(filterBI.getBean());//777

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

		confWinForm("Rubro");
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
		numeroTXT = UtilUI.buildTXTShortPlus(itemBI, "numero", "Número", false, 1, true);

		numeroTXT.addValidator(new AbstractValidator("") {

			@Override
			protected boolean isValidValue(Object value) {

				try {

					Integer original = itemBIOriginal.getBean().getNumero();

					if (COPY_MODE.equals(mode)) {
						original = null;
					}

					Context.getRubrosBO().checkUniqueNumero(numeroTXT.getCaption(), original, (Integer) value);

					return true;

				} catch (Exception e) {
					LogAndNotification.print(e);
					this.setErrorMessage(e.getMessage());
					return false;
				}

			}

			@Override
			public Class getType() {

				return Integer.class;
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

					Context.getRubrosBO().checkUniqueNombre(nombreTXT.getCaption(), original, (String) value);

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
		formVL.addComponents(numeroTXT, nombreTXT);

		return formVL;
	}

	// =================================================================================

	protected void setMaxValues() throws Exception {
		itemBI.getBean().setNumero(maxNumero());
	}

	protected void setBean(Object obj) throws Exception {
		Rubro item = (Rubro) obj;

		itemBIOriginal.setBean(item.clone());
		itemBI.setBean(item);
	}

	// -----------------------------------------------------------------------------------

	protected void validateForm() {
		numeroTXT.validate();
		nombreTXT.validate();
	}

	// =================================================================================
	// SECCION PARA CONSULTAS A LA BASE DE DATOS

	public Integer maxNumero() throws Exception {
		return Context.getRubrosBO().maxNumero();

	}

	// metodo que realiza la consulta a la base de datos
//	protected Rubro queryData() {
//		try {
//
//			Rubro item = Context.getRubrosBO().find(this.filterBI.getBean());
//
//			return item;
//
//		} catch (Exception e) {
//			LogAndNotification.print(e);
//		}
//
//		return new Rubro();
//	}

	protected Object insert() throws Exception {

		try {
			 Context.getRubrosBO().insert(this.itemBI.getBean());
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(this.itemBI.getBean().getNumero(), null);				
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}

	protected Object update() throws Exception {

		try {
			 Context.getRubrosBO().update(this.itemBIOriginal.getBean(),
			 this.itemBI.getBean());
			if (windowListado != null) {
				windowListado.loadDataResetPaged();
				((WCuentasFondo) windowListado).loadDataResetPagedTree(this.itemBI.getBean().getNumero(), null);
			}

			return itemBI.getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
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

	@Override
	protected EntityId queryData() {
		// TODO Auto-generated method stub
		return null;
	}

	// =================================================================================

}
