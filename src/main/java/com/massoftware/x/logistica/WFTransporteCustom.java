
package com.massoftware.x.logistica;

import java.util.List;

import com.massoftware.AppCX;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.service.geo.CodigoPostalFiltro;
import com.massoftware.service.geo.CodigoPostalService;
import com.massoftware.windows.ComboBoxEntity;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.TextAreaEntity;
import com.massoftware.windows.TextFieldEntity;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowListado;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WFTransporteCustom extends WFTransporte {

	protected Label paisLBL;
	protected Label provinciaLBL;
	protected Label ciudadLBL;

	// -------------------------------------------------------------

	public WFTransporteCustom(String mode, String id) throws Exception {
		super(mode, id);

		CodigoPostalService codigoPostalService = AppCX.services().buildCodigoPostalService();

		long items = codigoPostalService.count();

		if (items < this.MAX_ROWS_FOR_CBX) {

			CodigoPostalFiltro codigoPostalFiltro = new CodigoPostalFiltro();

			codigoPostalFiltro.setUnlimited(true);

			codigoPostalFiltro.setOrderBy(1);

			List<CodigoPostal> codigoPostalLista = codigoPostalService.find(codigoPostalFiltro);
			codigoPostalCBX.setValues(codigoPostalLista, null);

		} else {

			codigoPostalSBX.blur();
		}

		setValueLBLPaisProvinciaCiudad();

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

		cuitTXT = new TextFieldEntity(itemBI, "cuit", this.mode) {
			protected boolean ifExists(Object arg) throws Exception {
				return getService().isExistsCuit((Long) arg);
			}
		};

		// ------------------------------------------------------------------

		ingresosBrutosTXT = new TextFieldEntity(itemBI, "ingresosBrutos", this.mode);

		// ------------------------------------------------------------------

		telefonoTXT = new TextFieldEntity(itemBI, "telefono", this.mode);

		// ------------------------------------------------------------------

		faxTXT = new TextFieldEntity(itemBI, "fax", this.mode);

		CodigoPostalService codigoPostalService = AppCX.services().buildCodigoPostalService();

		long items = codigoPostalService.count();

		if (items < this.MAX_ROWS_FOR_CBX) {

			CodigoPostalFiltro codigoPostalFiltro = new CodigoPostalFiltro();

			codigoPostalFiltro.setUnlimited(true);

			codigoPostalFiltro.setOrderBy(1);

			List<CodigoPostal> codigoPostalLista = codigoPostalService.find(codigoPostalFiltro);

			codigoPostalCBX = new ComboBoxEntity(itemBI, "codigoPostal", this.mode, codigoPostalLista);

			// *************************************

			codigoPostalCBX.addValueChangeListener(e -> {
				try {

					// *************************************
					setValueLBLPaisProvinciaCiudad();
					// *************************************

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			// *************************************

		} else {

			codigoPostalSBX = new SelectorBox(itemBI, "codigoPostal") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CodigoPostalService service = AppCX.services().buildCodigoPostalService();

					return service.findByCodigoOrNumero(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CodigoPostalFiltro filtro = new CodigoPostalFiltro();

					if (filter) {

						filtro.setCodigo(getValue());

					}

					return AppCX.widgets().buildWLCodigoPostal(filtro);

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
						setValueLBLPaisProvinciaCiudad();
					}

					// *************************************
				}

				// *************************************

			};

		}

		// ------------------------------------------------------------------

		domicilioTXT = new TextFieldEntity(itemBI, "domicilio", this.mode);

		// ------------------------------------------------------------------

		comentarioTXA = new TextAreaEntity(itemBI, "comentario", this.mode);

		// ---------------------------------------------------------------------------------------------------------

		ciudadLBL = UtilUI.buildLbl("Ciudad", null);

		// ---------------------------------------------------------------------------------------------------------

		provinciaLBL = UtilUI.buildLbl("Provincia", null);

		// ---------------------------------------------------------------------------------------------------------

		paisLBL = UtilUI.buildLbl("País", null);

		// ---------------------------------------------------------------------------------------------------------

		return buildCuerpoLayout();

		// ---------------------------------------------------------------------------------------------------------
	}

	protected Component buildCuerpoLayout() throws Exception {

		this.setWidth(45f, Unit.EM);
		// this.setHeight(30.5f, Unit.EM);

		VerticalLayout generalVL = UtilUI.buildVL();

		HorizontalLayout aHL = UtilUI.buildHL();
		aHL.setMargin(false);

		HorizontalLayout bHL = UtilUI.buildHL();
		bHL.setMargin(false);

		HorizontalLayout cHL = UtilUI.buildHL();
		cHL.setMargin(false);

		HorizontalLayout dHL = UtilUI.buildHL();
		dHL.setMargin(false);

		HorizontalLayout eHL = UtilUI.buildHL();
		eHL.setMargin(false);

		HorizontalLayout fHL = UtilUI.buildHL();
		fHL.setMargin(false);

		HorizontalLayout gHL = UtilUI.buildHL();
		gHL.setMargin(false);

		HorizontalLayout hHL = UtilUI.buildHL();
		hHL.setMargin(false);

		// ------------------------------------------------------------------

		generalVL.addComponent(aHL);
		generalVL.addComponent(bHL);
		generalVL.addComponent(cHL);
		generalVL.addComponent(dHL);
		generalVL.addComponent(eHL);
		generalVL.addComponent(fHL);
		// generalVL.addComponent(gHL);
		// generalVL.addComponent(hHL);

		if (numeroTXT != null) {
			aHL.addComponent(numeroTXT);
		}
		if (cuitTXT != null) {
			aHL.addComponent(cuitTXT);
		}
		if (nombreTXT != null) {
			aHL.addComponent(nombreTXT);
		}

		if (ingresosBrutosTXT != null) {
			bHL.addComponent(ingresosBrutosTXT);
		}
		if (telefonoTXT != null) {
			bHL.addComponent(telefonoTXT);
		}
		if (faxTXT != null) {
			bHL.addComponent(faxTXT);
		}
		if (domicilioTXT != null) {
			cHL.setWidth("100%");
			domicilioTXT.setWidth("100%");
			cHL.addComponent(domicilioTXT);
		}

		if (codigoPostalCBX != null) {
			dHL.addComponent(codigoPostalCBX);
		}
		if (codigoPostalSBX != null) {
			dHL.addComponent(codigoPostalSBX);
		}
		dHL.addComponent(ciudadLBL);

		eHL.addComponent(provinciaLBL);
		eHL.addComponent(paisLBL);

		if (comentarioTXA != null) {
			fHL.setWidth("100%");
			fHL.setWidth(42f, Unit.EM);
			comentarioTXA.setWidth("100%");
			fHL.addComponent(comentarioTXA);
		}

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

	private void setValueLBLPaisProvinciaCiudad() throws Exception {

		ciudadLBL.setValue(null);
		provinciaLBL.setValue(null);
		paisLBL.setValue(null);

		CodigoPostal codigoPostal = this.getItemBIC().getBean().getCodigoPostal();

		if (codigoPostal != null) {
			Ciudad ciudad = codigoPostal.getCiudad();

			if (ciudad != null) {

				ciudadLBL.setValue(ciudad.toString());

				Provincia provincia = ciudad.getProvincia();

				if (provincia != null) {

					provinciaLBL.setValue(provincia.toString());

					Pais pais = provincia.getPais();

					if (pais != null) {
						paisLBL.setValue(pais.toString());
					}
				}
			}
		}

	}

}