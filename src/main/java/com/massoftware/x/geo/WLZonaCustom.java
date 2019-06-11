
package com.massoftware.x.geo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.geo.Zona;
import com.massoftware.service.geo.ZonaFiltro;
import com.massoftware.windows.UtilUI;

import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLZonaCustom extends WLZona {

	// -------------------------------------------------------------

	public WLZonaCustom() {
		super();
	}

	public WLZonaCustom(ZonaFiltro filtro) {
		super(filtro);
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(36f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "codigo", "nombre", "bonificacion", "recargo" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("codigo"), true, 72);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("bonificacion"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("recargo"), true, 120);

		// ------------------------------------------------------------------

		Zona dto = new Zona();
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
