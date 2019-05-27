
package com.massoftware.x.afip.monedas;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.dao.afip.monedas.MonedaAFIPFiltro;
import com.massoftware.model.afip.monedas.MonedaAFIP;
import com.massoftware.windows.UtilUI;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLMonedaAFIPCustom extends WLMonedaAFIP {

	public WLMonedaAFIPCustom() {
		super();

	}

	public WLMonedaAFIPCustom(MonedaAFIPFiltro filtro) {
		super(filtro);

	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(21.0f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "codigo", "nombre" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("codigo"), true, 72);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		// ------------------------------------------------------------------

		MonedaAFIP dto = new MonedaAFIP();
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
