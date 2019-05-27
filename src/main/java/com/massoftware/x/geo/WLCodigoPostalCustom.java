
package com.massoftware.x.geo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.dao.geo.CiudadDAO;
import com.massoftware.dao.geo.CiudadDAOCustom;
import com.massoftware.dao.geo.CiudadFiltro;
import com.massoftware.dao.geo.CodigoPostalFiltro;
import com.massoftware.dao.geo.PaisDAO;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.ProvinciaDAO;
import com.massoftware.dao.geo.ProvinciaDAOCustom;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.model.geo.Ciudad;
import com.massoftware.model.geo.CodigoPostal;
import com.massoftware.model.geo.Pais;
import com.massoftware.model.geo.Provincia;
import com.massoftware.windows.ComboBoxBox;
import com.massoftware.windows.LogAndNotification;
import com.massoftware.windows.SelectorBox;
import com.massoftware.windows.TextFieldBox;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowListado;

//import com.vaadin.data.util.converter.StringToBooleanConverter;
//import com.vaadin.server.FontAwesome;
//import com.vaadin.ui.renderers.DateRenderer;
//import com.vaadin.ui.renderers.HtmlRenderer;

import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Component;
import com.vaadin.ui.Grid.Column;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;

@SuppressWarnings("serial")
public class WLCodigoPostalCustom extends WLCodigoPostal {

	public WLCodigoPostalCustom() {
		super();
	}

	public WLCodigoPostalCustom(CodigoPostalFiltro filtro) {
		super(filtro);
	}

	protected Component buildFiltros() throws Exception {

		// ------------------------------------------------------------------

		codigoTXTB = new TextFieldBox(this, filterBI, "codigo", "igual a ..");

		// ------------------------------------------------------------------

		numeroFromTXTB = new TextFieldBox(this, filterBI, "numeroFrom");

		// ------------------------------------------------------------------

		numeroToTXTB = new TextFieldBox(this, filterBI, "numeroTo");

		// ------------------------------------------------------------------

		PaisDAO paisDAO = new PaisDAO();

		long paisItems = paisDAO.count();

		if (paisItems < 300000) {

			PaisFiltro paisFiltro = new PaisFiltro();

			paisFiltro.setUnlimited(true);

			paisFiltro.setOrderBy("numero");

			List<Pais> paisLista = paisDAO.find(paisFiltro);

			paisCBXB = new ComboBoxBox(this, filterBI, "pais", paisLista, filterBI.getBean().getPais());

			// *************************************

			paisCBXB.valueCBX.addValueChangeListener(e -> {
				try {

					this.filterBI.getBean().setProvincia(null);
					this.filterBI.getBean().setCiudad(null);
					
					// *************************************

					if (provinciaSBX != null) {
						provinciaSBX.setSelectedItem(null);
					} else if (provinciaCBXB != null) {

						if(this.filterBI.getBean().getPais() != null) {
							
							ProvinciaDAO provinciaDAO = new ProvinciaDAO();

							ProvinciaFiltro provinciaFiltro = new ProvinciaFiltro();

							// *************************************
							provinciaFiltro.setPais(this.filterBI.getBean().getPais());
							// *************************************

							provinciaFiltro.setUnlimited(true);

							provinciaFiltro.setOrderBy("numero");

							List<Provincia> provinciaLista = provinciaDAO.find(provinciaFiltro);

							provinciaCBXB.valueCBX.setValues(provinciaLista, null);

							if (provinciaLista.size() == 0) {
								provinciaCBXB.valueCBX.setValue(null);
							}
						} else {							
							provinciaCBXB.valueCBX.setValues(new ArrayList<Provincia>(), null);
							provinciaCBXB.valueCBX.setValue(null);
							this.filterBI.getBean().setProvincia(null);
						}

					}

					if (ciudadSBX != null) {
						ciudadSBX.setSelectedItem(null);
					} else if (ciudadCBXB != null) {								
						ciudadCBXB.valueCBX.setValue(null);
						ciudadCBXB.valueCBX.setValues(new ArrayList<Ciudad>(), null);
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

				protected WindowListado getPopup(boolean filter) throws Exception {

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
					if (ciudadSBX != null) {
						ciudadSBX.setSelectedItem(null);
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

			provinciaCBXB = new ComboBoxBox(this, filterBI, "provincia", provinciaLista,
					filterBI.getBean().getProvincia());

			// *************************************

			provinciaCBXB.valueCBX.addValueChangeListener(e -> {
				try {

					// *************************************
					if (ciudadSBX != null) {
						ciudadSBX.setSelectedItem(null);
					} else if (ciudadCBXB != null) {
						
						if(this.filterBI.getBean().getProvincia() != null) {
							
							ciudadCBXB.valueCBX.setValues(new ArrayList<Ciudad>(), null);
							ciudadCBXB.valueCBX.setValue(null);

							CiudadDAO ciudadDAO = new CiudadDAO();

							CiudadFiltro ciudadFiltro = new CiudadFiltro();

							// *************************************
							ciudadFiltro.setProvincia(this.filterBI.getBean().getProvincia());
							// *************************************

							ciudadFiltro.setUnlimited(true);

							ciudadFiltro.setOrderBy("numero");

							List<Ciudad> ciudadLista = ciudadDAO.find(ciudadFiltro);

							ciudadCBXB.valueCBX.setValues(ciudadLista, null);

							if (ciudadLista.size() == 0) {
								ciudadCBXB.valueCBX.setValue(null);
							}
						} else {							
							ciudadCBXB.valueCBX.setValues(new ArrayList<Ciudad>(), null);
							ciudadCBXB.valueCBX.setValue(null);
							this.filterBI.getBean().setCiudad(null);
						}												

					}
					// *************************************

				} catch (Exception ex) {
					LogAndNotification.print(ex);
				}
			});

			// *************************************

		} else {

			provinciaSBX = new SelectorBox(filterBI, "provincia") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

					// ProvinciaDAO dao = new ProvinciaDAO();
					//
					// return dao.findByNumeroOrNombre(value);

					// *************************************
					ProvinciaDAOCustom dao = new ProvinciaDAOCustom();

					return dao.findByNumeroOrNombre(filterBI.getBean().getPais(), value);
					// *************************************

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					ProvinciaFiltro filtro = new ProvinciaFiltro();

					// *************************************
					filtro.setPais(filterBI.getBean().getPais());
					// *************************************

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLProvincia windowPoPup = new WLProvincia(filtro) {

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
						provinciaSBX.setEnabled(filterBI.getBean().getPais() != null);
					}
					if (ciudadSBX != null) {
						ciudadSBX.setSelectedItem(null);
					}
					// *************************************
				}

				// *************************************

			};

		}

		// ------------------------------------------------------------------

		CiudadDAO ciudadDAO = new CiudadDAO();

		long ciudadItems = ciudadDAO.count();

		if (ciudadItems < 300000) {

			CiudadFiltro ciudadFiltro = new CiudadFiltro();

			ciudadFiltro.setUnlimited(true);

			ciudadFiltro.setOrderBy("numero");

			List<Ciudad> ciudadLista = ciudadDAO.find(ciudadFiltro);

			ciudadCBXB = new ComboBoxBox(this, filterBI, "ciudad", ciudadLista, filterBI.getBean().getCiudad());

		} else {

			ciudadSBX = new SelectorBox(filterBI, "ciudad") {

				protected void sourceLoadDataResetPaged() {

					loadDataResetPaged();

				}

				@SuppressWarnings("rawtypes")
				protected List findBean(String value) throws Exception {

//					CiudadDAO dao = new CiudadDAO();
//
//					return dao.findByNumeroOrNombre(value);
					
					// *************************************
					CiudadDAOCustom dao = new CiudadDAOCustom();

					return dao.findByNumeroOrNombre(filterBI.getBean().getProvincia(),value);
					// *************************************

				}

				protected WindowListado getPopup(boolean filter) throws Exception {

					CiudadFiltro filtro = new CiudadFiltro();
					
					// *************************************
					filtro.setPais(filterBI.getBean().getPais());
					filtro.setProvincia(filterBI.getBean().getProvincia());
					// *************************************

					if (filter) {

						filtro.setNombre(getValue());

					}

					WLCiudad windowPoPup = new WLCiudad(filtro) {

						protected void setSelectedItem() throws Exception {

							ciudadSBX.setSelectedItem(itemsGRD.getSelectedRow());

						}

					};
					
					// *************************************
					if (windowPoPup.paisSBX != null) {
						windowPoPup.paisSBX.setEnabled(false);
					} else if (windowPoPup.paisCBXB != null) {
						windowPoPup.paisCBXB.setEnabled(false);
					}
					if (windowPoPup.provinciaSBX != null) {
						windowPoPup.provinciaSBX.setEnabled(false);
					} else if (windowPoPup.provinciaCBXB != null) {
						windowPoPup.provinciaCBXB.setEnabled(false);
					}
					// *************************************

					return windowPoPup;

				}

			};

		}

		// ------------------------------------------------------------------

		return buildFiltrosLayout();
	}

	protected Component buildFiltrosLayout() throws Exception {

		VerticalLayout generalVL = UtilUI.buildVL();
		generalVL.setMargin(false);

		HorizontalLayout aHL = UtilUI.buildHL();
		aHL.setMargin(false);
		HorizontalLayout bHL = UtilUI.buildHL();
		bHL.setMargin(false);

		// ------------------------------------------------------------------

		Button buscarBTN = buildButtonBuscar();

		if (codigoTXTB != null) {
			aHL.addComponent(codigoTXTB);
		}
		if (numeroFromTXTB != null) {
			aHL.addComponent(numeroFromTXTB);
		}
		if (numeroToTXTB != null) {
			aHL.addComponent(numeroToTXTB);
		}
		if (paisCBXB != null) {
			bHL.addComponent(paisCBXB);
		}
		if (paisSBX != null) {
			bHL.addComponent(paisSBX);
		}
		if (provinciaCBXB != null) {
			bHL.addComponent(provinciaCBXB);
		}
		if (provinciaSBX != null) {
			bHL.addComponent(provinciaSBX);
		}
		if (ciudadCBXB != null) {
			bHL.addComponent(ciudadCBXB);
		}
		if (ciudadSBX != null) {
			bHL.addComponent(ciudadSBX);
		}

		aHL.addComponent(buscarBTN);
		aHL.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		generalVL.addComponent(aHL);
		generalVL.addComponent(bHL);

		// ------------------------------------------------------------------

		return generalVL;

		// ------------------------------------------------------------------
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		// itemsGRD.setWidth(25f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "codigo", "numero", "nombreCalle", "numeroCalle", "ciudad" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("codigo"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombreCalle"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("numeroCalle"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("ciudad"), true, -1);

		// ------------------------------------------------------------------

		CodigoPostal dto = new CodigoPostal();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("codigo", SortDirection.ASCENDING));

		itemsGRD.setSortOrder(order);

		// ------------------------------------------------------------------
	}

} // END CLASS
