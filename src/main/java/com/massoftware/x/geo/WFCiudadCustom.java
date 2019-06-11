
package com.massoftware.x.geo;

import java.util.List;

import com.massoftware.AppCX;
import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.service.geo.ProvinciaFiltro;
import com.massoftware.service.geo.ProvinciaService;
import com.massoftware.service.geo.ProvinciaServiceCustom;
import com.massoftware.windows.ComboBoxEntity;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.TextFieldEntity;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowListado;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WFCiudadCustom extends WFCiudad {

	private Pais pais;

	private Label paisLBL;

	// -------------------------------------------------------------

	// -------------------------------------------------------------

	// -------------------------------------------------------------

	public WFCiudadCustom(String mode, String id, Pais pais) throws Exception {
		super(mode, id);

		if (this.getItemBIC().getBean().getProvincia() != null) {
			this.pais = this.getItemBIC().getBean().getProvincia().getPais();
		} else {
			this.pais = pais;
		}

		setValuePais();
	}

	protected Component buildCuerpo() throws Exception {

		// ------------------------------------------------------------------

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsNumero((Integer) arg);
			}
		};

		numeroTXT.focus();

		// ------------------------------------------------------------------

		nombreTXT = new TextFieldEntity(itemBI, "nombre", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsNombre((String) arg);
			}
		};

		// ------------------------------------------------------------------

		departamentoTXT = new TextFieldEntity(itemBI, "departamento", this.mode);

		// ------------------------------------------------------------------

		numeroAFIPTXT = new TextFieldEntity(itemBI, "numeroAFIP", this.mode);

		ProvinciaService provinciaDAO = AppCX.services().buildProvinciaService();

		long items = provinciaDAO.count();

		if (items < this.MAX_ROWS_FOR_CBX) {

			ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();

			provinciaFiltro.setUnlimited(true);

			provinciaFiltro.setOrderBy(1);

			List<Provincia> provinciaLista = provinciaDAO.find(provinciaFiltro);

			provinciaCBX = new ComboBoxEntity(itemBI, "provincia", this.mode, provinciaLista);

			// *************************************

			provinciaCBX.addValueChangeListener(e -> {
				try {

					// *************************************
					changePais();
					// *************************************

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			// *************************************

		} else {

			provinciaSBX = new SelectorBox(itemBI, "provincia") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					// *************************************
					ProvinciaServiceCustom dao = (ProvinciaServiceCustom) AppCX.services().buildProvinciaService();

					return dao.findByNumeroOrNombre(pais, value);
					// *************************************

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					ProvinciaFiltro filtro = new ProvinciaFiltro();

					// *************************************
					filtro.setPais(pais);
					// *************************************

					if (filter) {

						filtro.setNombre(getValue());

					}

					return new WLProvincia(filtro);

				}

				// *************************************

				public void setSelectedItem(Object item) throws Exception {

					if (item != null) {
						valueTXT.setValue(item.toString());
					} else {
						valueTXT.setValue(null);
					}

					setSelectedItemBean(item);

					sourceLoadDataResetPaged();

					// *************************************
					if (item != null) {
						changePais();
						setValuePais();	
					} 
					
					// *************************************
				}

				// *************************************

			};

		}

		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}

	protected Component buildCuerpoLayout() throws Exception {

		String paisValue = null;
		if (pais != null) {
			paisValue = pais.toString();
		}
		paisLBL = UtilUI.buildLbl("País", paisValue);

		this.setWidth(25f, Unit.EM);

		VerticalLayout generalVL = UtilUI.buildVL();

		HorizontalLayout aHL = UtilUI.buildHL();
		aHL.setMargin(false);
		HorizontalLayout bHL = UtilUI.buildHL();
		bHL.setMargin(false);
		HorizontalLayout cHL = UtilUI.buildHL();
		cHL.setMargin(false);
		HorizontalLayout dHL = UtilUI.buildHL();
		dHL.setMargin(false);

		// ------------------------------------------------------------------

		aHL.addComponent(numeroTXT);
		aHL.addComponent(nombreTXT);

		generalVL.addComponent(aHL);

		bHL.addComponent(numeroAFIPTXT);
		bHL.addComponent(departamentoTXT);

		generalVL.addComponent(bHL);

		cHL.addComponent(paisLBL);

		generalVL.addComponent(cHL);

		if (provinciaCBX != null) {
			dHL.addComponent(provinciaCBX);
		}
		if (provinciaSBX != null) {
			dHL.addComponent(provinciaSBX);
		}

		generalVL.addComponent(dHL);

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

	private void changePais() throws Exception {

		if (this.getItemBIC().getBean().getProvincia() != null) {
			this.pais = this.getItemBIC().getBean().getProvincia().getPais();
		} else {
			this.pais = null;
		}
	}

	private void setValuePais() throws Exception {

		String paisValue = null;
		if (pais != null) {
			paisValue = pais.toString();
		}
		paisLBL.setValue(paisValue);
	}

}