
package com.massoftware.x.clientes;

import com.vaadin.data.util.BeanItem;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

import com.massoftware.windows.*;

import com.massoftware.model.EntityId;


import java.util.List;
import com.massoftware.model.clientes.ClasificacionCliente;
import com.massoftware.dao.clientes.ClasificacionClienteFiltro;
import com.massoftware.dao.clientes.ClasificacionClienteDAO;

import com.massoftware.model.clientes.MotivoBloqueoCliente;
import com.massoftware.dao.clientes.MotivoBloqueoClienteDAO;

@SuppressWarnings("serial")
public class WFMotivoBloqueoCliente extends WindowForm {


	// -------------------------------------------------------------

	protected BeanItem<MotivoBloqueoCliente> itemBI;
	
	private MotivoBloqueoClienteDAO dao;

	// -------------------------------------------------------------

	
	protected TextFieldEntity numeroTXT;
	protected TextFieldEntity nombreTXT;
	protected ComboBoxEntity clasificacionClienteCBX;
	protected SelectorBox clasificacionClienteSBX;


	// -------------------------------------------------------------

	public WFMotivoBloqueoCliente(String mode, String id) {
		super(mode, id);					
	}

	protected MotivoBloqueoClienteDAO getDAO() {
		if(dao == null){
			dao = new MotivoBloqueoClienteDAO();
		}
		
		return dao;
	}

	protected void buildContent() throws Exception {

		confWinForm(this.itemBI.getBean().labelSingular());
		this.setWidth(28f, Unit.EM);

		// =======================================================
		// CUERPO

		Component cuerpo = buildCuerpo();

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

	protected Component buildCuerpo() throws Exception {

		

		// ------------------------------------------------------------------

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsNumero((Integer)arg);
			}
		};

		numeroTXT.focus();

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getDAO().isExistsNombre((String)arg);
			}
		};

		ClasificacionClienteDAO clasificacionClienteDAO = new ClasificacionClienteDAO();

		long clasificacionClienteItems = clasificacionClienteDAO.count();

		if (clasificacionClienteItems < MAX_ROWS_FOR_CBX) {

			ClasificacionClienteFiltro clasificacionClienteFiltro = new ClasificacionClienteFiltro();

			clasificacionClienteFiltro.setUnlimited(true);

			clasificacionClienteFiltro.setOrderBy("numero");

			List<ClasificacionCliente> clasificacionClienteLista = clasificacionClienteDAO.find(clasificacionClienteFiltro);

			clasificacionClienteCBX = new ComboBoxEntity(itemBI, "clasificacionCliente", this.mode, clasificacionClienteLista);

		} else {

			clasificacionClienteSBX = new SelectorBox(itemBI, "clasificacionCliente") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					ClasificacionClienteDAO dao = new ClasificacionClienteDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					ClasificacionClienteFiltro filtro = new ClasificacionClienteFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return windowBuilder.buildWLClasificacionCliente(filtro);

				}

			};

		}

		
		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}
	
	protected Component buildCuerpoLayout() throws Exception {		

		VerticalLayout generalVL = UtilUI.buildVL();

		// ------------------------------------------------------------------		
		
		
		if (numeroTXT != null) {
			generalVL.addComponent(numeroTXT);
		}
		if (nombreTXT != null) {
			generalVL.addComponent(nombreTXT);
		}
		if (clasificacionClienteCBX != null) {
			generalVL.addComponent(clasificacionClienteCBX);
		}
		if (clasificacionClienteSBX != null) {
			generalVL.addComponent(clasificacionClienteSBX);
		}

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

	// =================================================================================

	protected void setMaxValues(EntityId item) throws Exception {
		// Al momento de insertar o copiar a veces se necesita el maximo valor de ese
		// atributo, + 1, esto es asi para hacer una especie de numero incremental de
		// ese atributo
		// Este metodo se ejecuta despues de consultar a la base de datos el bean en
		// base a su id

		// item.setNumero(this.itemBI.getBean().maxValueInteger("numero"));		
		
		
		((MotivoBloqueoCliente) item).setNumero(getDAO().nextValueNumero());

	}

	protected void setBean(EntityId obj) throws Exception {

		// se utiliza para asignarle o cambiar el bean al contenedor del formulario

		itemBI.setBean((MotivoBloqueoCliente) obj);
	}

	protected BeanItem<MotivoBloqueoCliente> getItemBIC() throws Exception {

		// -----------------------------------------------------------------
		// Crea el Container del form, en base a al bean que queremos usar, y ademas
		// carga el form con un bean vacio
		// como este metodo se llama muchas veces, inicializar el contenedor una sola
		// vez

		if (itemBI == null) {
			itemBI = new BeanItem<MotivoBloqueoCliente>(new MotivoBloqueoCliente());
		}
		return itemBI;
	}

	protected Object insert() throws Exception {

		try {
			
			getDAO().insert(getItemBIC().getBean());
			// ((EntityId) getItemBIC().getBean()).insert();
			if (windowListado != null) {
				windowListado.loadDataResetPagedFull();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	protected Object update() throws Exception {

		try {


			getDAO().update(getItemBIC().getBean());
//			((EntityId) getItemBIC().getBean()).update();
			if (windowListado != null) {
				windowListado.loadDataResetPagedFull();
			}

			return getItemBIC().getBean();

		} catch (Exception e) {
			LogAndNotification.print(e);
			return null;
		}
	}
	
	// metodo que realiza la consulta a la base de datos
	protected EntityId queryData() throws Exception {
		try {

			//EntityId item = (EntityId) getItemBIC().getBean();
			//item.loadById(id); // consulta a DB						
			MotivoBloqueoCliente item = getDAO().findById(id);
			getItemBIC().setBean(item);

			return item;

		} catch (Exception e) {
			LogAndNotification.print(e);
		}

		return (EntityId) getItemBIC().getBean();
	}

	// =================================================================================

}