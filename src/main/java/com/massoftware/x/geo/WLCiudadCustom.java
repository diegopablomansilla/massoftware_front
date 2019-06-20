
package com.massoftware.x.geo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.AppCX;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.service.geo.CiudadFiltro;
import com.massoftware.service.geo.PaisFiltro;
import com.massoftware.service.geo.PaisService;
import com.massoftware.service.geo.ProvinciaFiltro;
import com.massoftware.service.geo.ProvinciaService;
import com.massoftware.service.geo.ProvinciaServiceCustom;
import com.massoftware.x.util.UtilUI;
import com.massoftware.x.util.controls.ComboBoxBox;
import com.massoftware.x.util.controls.SelectorBox;
import com.massoftware.x.util.controls.TextFieldBox;
import com.massoftware.x.util.windows.LogAndNotification;
import com.massoftware.x.util.windows.WindowForm;
import com.massoftware.x.util.windows.WindowListado;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Component;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLCiudadCustom extends WLCiudad {

	// -------------------------------------------------------------

	public WLCiudadCustom() {
		super();
	}

	public WLCiudadCustom(CiudadFiltro filtro) {
		super(filtro);
	}

	protected Component buildFiltros() throws Exception {

		// ------------------------------------------------------------------

		numeroFromTXTB = new TextFieldBox(this, filterBI, "numeroFrom");

		// ------------------------------------------------------------------

		numeroToTXTB = new TextFieldBox(this, filterBI, "numeroTo");

		// ------------------------------------------------------------------

		nombreTXTB = new TextFieldBox(this, filterBI, "nombre", "contiene las palabras ..");

		// ------------------------------------------------------------------

		PaisService paisService = AppCX.services().buildPaisService();

		long paisItems = paisService.count();

		if (paisItems < MAX_ROWS_FOR_CBX) {

			PaisFiltro paisFiltro = new PaisFiltro();

			paisFiltro.setUnlimited(true);

			paisFiltro.setOrderBy(1);

			List<Pais> paisLista = paisService.find(paisFiltro);

			paisCBXB = new ComboBoxBox(this, filterBI, "pais", paisLista, filterBI.getBean().getPais());

			// *************************************

			paisCBXB.valueCBX.addValueChangeListener(e -> {
				try {

					// *************************************
					if (provinciaSBX != null) {
						provinciaSBX.setSelectedItem(null);
					} else if (provinciaCBXB != null) {

						ProvinciaService provinciaService = AppCX.services().buildProvinciaService();

						ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();

						// *************************************
						provinciaFiltro.setPais(this.filterBI.getBean().getPais());
						// *************************************

						provinciaFiltro.setUnlimited(true);

						provinciaFiltro.setOrderBy(1);

						List<Provincia> provinciaLista = provinciaService.find(provinciaFiltro);

						provinciaCBXB.valueCBX.setValues(provinciaLista, null);

						if (provinciaLista.size() == 0) {
							provinciaCBXB.valueCBX.setValue(null);
						}

					}
					// *************************************

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			// *************************************

		} else {

			paisSBX = new SelectorBox(filterBI, "pais") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					PaisService service = AppCX.services().buildPaisService();

					return service.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) {

					PaisFiltro filtro = new PaisFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLPais windowPoPup = new WLPais(filtro) {

						protected void setSelectedItem() throws Exception {

							paisSBX.setSelectedItem(itemsGRD.getSelectedRow());

						}

					};

					return windowPoPup;

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
					if (provinciaSBX != null) {
						provinciaSBX.setSelectedItem(null);
					}
					// *************************************
				}

				// *************************************

			};

		}

		// ------------------------------------------------------------------

		ProvinciaService provinciaService = AppCX.services().buildProvinciaService();

		long provinciaItems = provinciaService.count();

		if (provinciaItems < MAX_ROWS_FOR_CBX) {

			ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();

			provinciaFiltro.setUnlimited(true);

			provinciaFiltro.setOrderBy(1);

			List<Provincia> provinciaLista = provinciaService.find(provinciaFiltro);

			provinciaCBXB = new ComboBoxBox(this, filterBI, "provincia", provinciaLista,
					filterBI.getBean().getProvincia());

		} else {

			provinciaSBX = new SelectorBox(filterBI, "provincia") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					// *************************************
					ProvinciaServiceCustom service = (ProvinciaServiceCustom) AppCX.services().buildProvinciaService();

					return service.findByNumeroOrNombre(filterBI.getBean().getPais(), value);
					// *************************************

				}

				protected WindowListado getPopup(boolean filter) {

					ProvinciaFiltro filtro = new ProvinciaFiltro();

					// *************************************
					filtro.setPais(filterBI.getBean().getPais());
					// *************************************

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLProvinciaCustom windowPoPup = new WLProvinciaCustom(filtro) {

						protected void setSelectedItem() throws Exception {

							provinciaSBX.setSelectedItem(itemsGRD.getSelectedRow());

						}

					};

					// *************************************
					if (windowPoPup.paisSBX != null) {
						windowPoPup.paisSBX.setEnabled(false);
					} else if (windowPoPup.paisCBXB != null) {
						windowPoPup.paisCBXB.setEnabled(false);
					}
					// *************************************

					return windowPoPup;

				}

				// *************************************

				public void setSelectedItem(Object item) {

					if (item != null) {
						valueTXT.setValue(item.toString());
					} else {
						valueTXT.setValue(null);
					}

					setSelectedItemBean(item);

					sourceLoadDataResetPaged();

					// *************************************
					if (provinciaSBX != null) {
						provinciaSBX.setEnabled(filterBI.getBean().getPais() != null);
					}
					// *************************************
				}

				// *************************************

			};

			provinciaSBX.setEnabled(this.filterBI.getBean().getPais() != null);

		}

		// ------------------------------------------------------------------

		return buildFiltrosLayout();
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(70f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "departamento", "numeroAFIP", "provincia" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 300);

		UtilUI.confColumn(itemsGRD.getColumn("departamento"), true, 300);

		UtilUI.confColumn(itemsGRD.getColumn("numeroAFIP"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("provincia"), true, 300);

		// ------------------------------------------------------------------

		Ciudad dto = new Ciudad();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);

		// ------------------------------------------------------------------
	}

	// =================================================================================

	protected WindowForm buildWinddowForm(String mode, String id) throws Exception {
		return AppCX.widgets().buildWFCiudad(mode, id, this.filterBI.getBean().getPais());
//		return new WFCiudadCustom(mode, id, this.filterBI.getBean().getPais());
	}

	// =================================================================================

} // END CLASS

// GENERATED BY ANTHILL 2019-05-24T16:00:48.592-03:00[America/Buenos_Aires]