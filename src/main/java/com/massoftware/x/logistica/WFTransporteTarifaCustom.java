
package com.massoftware.x.logistica;

import java.util.List;

import com.massoftware.AppCX;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.model.logistica.Carga;
import com.massoftware.model.logistica.Transporte;
import com.massoftware.service.geo.CiudadFiltro;
import com.massoftware.service.geo.CiudadService;
import com.massoftware.service.logistica.CargaFiltro;
import com.massoftware.service.logistica.CargaService;
import com.massoftware.x.util.UtilUI;
import com.massoftware.x.util.controls.ComboBoxEntity;
import com.massoftware.x.util.controls.SelectorBox;
import com.massoftware.x.util.controls.TextFieldEntity;
import com.massoftware.x.util.windows.LogAndNotification;
import com.massoftware.x.util.windows.WindowListado;
import com.vaadin.ui.Component;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.Label;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WFTransporteTarifaCustom extends WFTransporteTarifa {

	protected Label paisLBL;
	protected Label provinciaLBL;

	protected Label transporteLBL;

	// -------------------------------------------------------------

	public WFTransporteTarifaCustom(String mode, String id) throws Exception {
		super(mode, id);
		setValueLBLPaisProvinciaTransporte();
	}

	protected Component buildCuerpo() throws Exception {

		// ------------------------------------------------------------------

		numeroTXT = new TextFieldEntity(itemBI, "numero", this.mode);

		numeroTXT.focus();

		CargaService cargaService = AppCX.services().buildCargaService();

		long cargaItems = cargaService.count();

		if (cargaItems < MAX_ROWS_FOR_CBX) {

			CargaFiltro cargaFiltro = new CargaFiltro();

			cargaFiltro.setUnlimited(true);

			cargaFiltro.setOrderBy(1);

			List<Carga> cargaLista = cargaService.find(cargaFiltro);

			cargaCBX = new ComboBoxEntity(itemBI, "carga", this.mode, cargaLista);

			// *************************************

			cargaCBX.addValueChangeListener(e -> {
				try {

					// *************************************
					setValueLBLPaisProvinciaTransporte();
					// *************************************

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			// *************************************

		} else {

			cargaSBX = new SelectorBox(itemBI, "carga") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CargaService service = AppCX.services().buildCargaService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CargaFiltro filtro = new CargaFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCarga(filtro);

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
						setValueLBLPaisProvinciaTransporte();
					}

					// *************************************
				}

				// *************************************

			};

		}

		CiudadService ciudadService = AppCX.services().buildCiudadService();

		long ciudadItems = ciudadService.count();

		if (ciudadItems < MAX_ROWS_FOR_CBX) {

			CiudadFiltro ciudadFiltro = new CiudadFiltro();

			ciudadFiltro.setUnlimited(true);

			ciudadFiltro.setOrderBy(1);

			List<Ciudad> ciudadLista = ciudadService.find(ciudadFiltro);

			ciudadCBX = new ComboBoxEntity(itemBI, "ciudad", this.mode, ciudadLista);

			// *************************************

			ciudadCBX.addValueChangeListener(e -> {
				try {

					// *************************************
					setValueLBLPaisProvinciaTransporte();
					// *************************************

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			// *************************************

		} else {

			ciudadSBX = new SelectorBox(itemBI, "ciudad") {

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					CiudadService service = AppCX.services().buildCiudadService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CiudadFiltro filtro = new CiudadFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					return AppCX.widgets().buildWLCiudad(filtro);

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
						setValueLBLPaisProvinciaTransporte();
					}

					// *************************************
				}

				// *************************************

			};

		}

		// ------------------------------------------------------------------

		precioFleteTXT = new TextFieldEntity(itemBI, "precioFlete", this.mode);

		// ------------------------------------------------------------------

		precioUnidadFacturacionTXT = new TextFieldEntity(itemBI, "precioUnidadFacturacion", this.mode);

		// ------------------------------------------------------------------

		precioUnidadStockTXT = new TextFieldEntity(itemBI, "precioUnidadStock", this.mode);

		// ------------------------------------------------------------------

		precioBultosTXT = new TextFieldEntity(itemBI, "precioBultos", this.mode);

		// ------------------------------------------------------------------

		importeMinimoEntregaTXT = new TextFieldEntity(itemBI, "importeMinimoEntrega", this.mode);

		// ------------------------------------------------------------------

		importeMinimoCargaTXT = new TextFieldEntity(itemBI, "importeMinimoCarga", this.mode);

		// ---------------------------------------------------------------------------------------------------------

		transporteLBL = UtilUI.buildLbl("Transporte", null);

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

		VerticalLayout generalVL = UtilUI.buildVL();

		HorizontalLayout aHL = UtilUI.buildHL();
		aHL.setMargin(false);

		VerticalLayout aaVL = UtilUI.buildVL();
		aaVL.setMargin(false);

		VerticalLayout abVL = UtilUI.buildVL();
		abVL.setMargin(false);

		// -------------------------------------------------

		HorizontalLayout bHL = UtilUI.buildHL();
		bHL.setMargin(false);

		VerticalLayout baVL = UtilUI.buildVL();
		baVL.setMargin(false);

		VerticalLayout bbVL = UtilUI.buildVL();
		bbVL.setMargin(false);

		VerticalLayout bcVL = UtilUI.buildVL();
		bcVL.setMargin(false);

		// ------------------------------------------------------------------

		generalVL.addComponent(aHL);
		generalVL.addComponent(bHL);

		// -------------------------------------------------
		aHL.addComponent(aaVL);
		aHL.addComponent(abVL);

		aaVL.addComponent(numeroTXT);
		if (ciudadCBX != null) {
			aaVL.addComponent(ciudadCBX);
		}
		if (ciudadSBX != null) {
			aaVL.addComponent(ciudadSBX);
		}
		aaVL.addComponent(provinciaLBL);

		if (cargaCBX != null) {
			abVL.addComponent(cargaCBX);
		}
		if (cargaSBX != null) {
			abVL.addComponent(cargaSBX);
		}
		abVL.addComponent(transporteLBL);
		abVL.addComponent(paisLBL);

		// -------------------------------------------------
		bHL.addComponent(baVL);
		bHL.addComponent(bbVL);
		bHL.addComponent(bcVL);

		baVL.addComponent(precioFleteTXT);
		baVL.addComponent(precioUnidadFacturacionTXT);

		bbVL.addComponent(precioUnidadStockTXT);
		bbVL.addComponent(precioBultosTXT);

		bcVL.addComponent(importeMinimoEntregaTXT);
		bcVL.addComponent(importeMinimoCargaTXT);
		// -------------------------------------------------

		// ---------------------------------------------------------------------------------------------------------

		return generalVL;

		// ---------------------------------------------------------------------------------------------------------
	}

	private void setValueLBLPaisProvinciaTransporte() throws Exception {

		transporteLBL.setValue(null);
		provinciaLBL.setValue(null);
		paisLBL.setValue(null);

		Carga carga = this.getItemBIC().getBean().getCarga();

		if (carga != null) {

			Transporte transporte = carga.getTransporte();

			if (transporte != null) {

				transporteLBL.setValue(transporte.toString());

			}

		}

		Ciudad ciudad = this.getItemBIC().getBean().getCiudad();

		if (ciudad != null) {

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