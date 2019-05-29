
package com.massoftware.x.logistica;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.dao.logistica.TransporteTarifaFiltro;
import com.massoftware.model.logistica.TransporteTarifa;
import com.massoftware.windows.UtilUI;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLTransporteTarifaCustom extends WLTransporteTarifa {

	// -------------------------------------------------------------

	public WLTransporteTarifaCustom() {
		super();
	}

	public WLTransporteTarifaCustom(TransporteTarifaFiltro filtro) {
		super(filtro);

	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(65.8f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "carga", "ciudad", "precioFlete", "precioUnidadFacturacion",
				"precioUnidadStock", "precioBultos", "importeMinimoEntrega", "importeMinimoCarga" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("carga"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("ciudad"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("precioFlete"), true, 90);

		UtilUI.confColumn(itemsGRD.getColumn("precioUnidadFacturacion"), true, 90);

		UtilUI.confColumn(itemsGRD.getColumn("precioUnidadStock"), true, 90);

		UtilUI.confColumn(itemsGRD.getColumn("precioBultos"), true, 90);

		UtilUI.confColumn(itemsGRD.getColumn("importeMinimoEntrega"), true, 90);

		UtilUI.confColumn(itemsGRD.getColumn("importeMinimoCarga"), true, true, true, -1);

		// ------------------------------------------------------------------

		TransporteTarifa dto = new TransporteTarifa();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.getColumn("precioFlete").setHeaderCaption("$ P/Flete");
		itemsGRD.getColumn("precioUnidadFacturacion").setHeaderCaption("$ P/UF");
		itemsGRD.getColumn("precioUnidadStock").setHeaderCaption("$ P/U Stock");
		itemsGRD.getColumn("precioBultos").setHeaderCaption("$ P/Bultos");
		itemsGRD.getColumn("importeMinimoEntrega").setHeaderCaption("Minimo P/Entrega");
		itemsGRD.getColumn("importeMinimoCarga").setHeaderCaption("Minimo P/Carga");

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);

		// ------------------------------------------------------------------
	}

} // END CLASS
