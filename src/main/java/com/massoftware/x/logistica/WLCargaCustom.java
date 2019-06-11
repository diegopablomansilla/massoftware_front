
package com.massoftware.x.logistica;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.logistica.Carga;
import com.massoftware.service.logistica.CargaFiltro;
import com.massoftware.windows.UtilUI;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLCargaCustom extends WLCarga {

	// -------------------------------------------------------------

	public WLCargaCustom() {
		super();
	}

	public WLCargaCustom(CargaFiltro filtro) {
		super(filtro);
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(37.7f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "transporte" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("transporte"), true, 240);

		// ------------------------------------------------------------------

		Carga dto = new Carga();
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

} // END CLASS
