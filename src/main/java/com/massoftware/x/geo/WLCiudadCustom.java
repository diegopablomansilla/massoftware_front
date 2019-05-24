
package com.massoftware.x.geo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.PaisDAO;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.ProvinciaDAO;
import com.massoftware.dao.geo.ProvinciaDAOCustom;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.windows.ComboBoxBox;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.TextFieldBox;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.massoftware.windows.WindowListado;
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

		PaisDAO paisDAO = new PaisDAO();

		long paisItems = paisDAO.count();

		if (paisItems < 30000) {

			PaisFiltro paisFiltro = new PaisFiltro();

			paisFiltro.setUnlimited(true);
			
			paisFiltro.setOrderBy("numero");

			List<Pais> paisLista = paisDAO.find(paisFiltro);

			paisCBXB = new ComboBoxBox(this, filterBI, "pais", paisLista);

			// *************************************

			paisCBXB.valueCBX.addValueChangeListener(e -> {
				try {

					// *************************************
					if(provinciaSBX != null) {
						provinciaSBX.setSelectedItem(null);	
					} else if(provinciaCBXB != null) {
						
						ProvinciaDAO provinciaDAO = new ProvinciaDAO();						
						
						ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();
						
						// *************************************
						provinciaFiltro.setPais(this.filterBI.getBean().getPais());
						// *************************************

						provinciaFiltro.setUnlimited(true);
						
						provinciaFiltro.setOrderBy("numero");

						List<Provincia> provinciaLista = provinciaDAO.find(provinciaFiltro);
						
						provinciaCBXB.valueCBX.setValues(provinciaLista, null);
						
						if(provinciaLista.size() == 0) {
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

					PaisDAO dao = new PaisDAO();

					return dao.findByNumeroOrNombre(value);

				}

				protected WindowListado getPopup(boolean filter) {

					PaisFiltro filtro = new PaisFiltro();

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLPais windowPoPup = new WLPais(filtro) {

						protected void setSelectedItem() {

							paisSBX.setSelectedItem(itemsGRD.getSelectedRow());

						}

					};

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
						provinciaSBX.setSelectedItem(null);
					}
					// *************************************
				}

				// *************************************

			};

		}

		// ------------------------------------------------------------------

		ProvinciaDAO provinciaDAO = new ProvinciaDAO();

		long provinciaItems = provinciaDAO.count();

		if (provinciaItems < 300000) {

			ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();

			provinciaFiltro.setUnlimited(true);
			
			provinciaFiltro.setOrderBy("numero");

			List<Provincia> provinciaLista = provinciaDAO.find(provinciaFiltro);

			provinciaCBXB = new ComboBoxBox(this, filterBI, "provincia", provinciaLista);

		} else {

			provinciaSBX = new SelectorBox(filterBI, "provincia") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					// *************************************
					ProvinciaDAOCustom dao = new ProvinciaDAOCustom();

					return dao.findByNumeroOrNombre(filterBI.getBean().getPais(), value);
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

						protected void setSelectedItem() {

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
		// itemsGRD.setWidth(25f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "departamento", "numeroAFIP", "provincia" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("departamento"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("numeroAFIP"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("provincia"), true, -1);

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

	protected WindowForm buildWinddowForm(String mode, String id) {
		return new WFCiudad(mode, id);
	}

	// =================================================================================

} // END CLASS

// GENERATED BY ANTHILL 2019-05-24T16:00:48.592-03:00[America/Buenos_Aires]