
package com.massoftware.x.logistica;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.dao.logistica.TransporteFiltro;
import com.massoftware.model.logistica.Transporte;
import com.massoftware.windows.UtilUI;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLTransporteCustom extends WLTransporte {

	// -------------------------------------------------------------

	public WLTransporteCustom() {
		super();
	}

	public WLTransporteCustom(TransporteFiltro filtro) {
		super(filtro);
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(55.9f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "cuit", "ingresosBrutos", "telefono", "fax",
				"domicilio", "codigoPostal", "comentario" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 80);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuit"), true, 90);

		UtilUI.confColumn(itemsGRD.getColumn("ingresosBrutos"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("telefono"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("fax"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("codigoPostal"), true, 230);

		UtilUI.confColumn(itemsGRD.getColumn("domicilio"), true, 230);

		UtilUI.confColumn(itemsGRD.getColumn("comentario"), true, true, true, -1);

		// ------------------------------------------------------------------

		Transporte dto = new Transporte();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.ASCENDING));

		itemsGRD.setSortOrder(order);

		// ------------------------------------------------------------------
	}

} // END CLASS
