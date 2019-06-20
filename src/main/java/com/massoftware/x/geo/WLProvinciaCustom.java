
package com.massoftware.x.geo;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.geo.Provincia;
import com.massoftware.service.geo.ProvinciaFiltro;
import com.massoftware.x.util.UtilUI;
import com.massoftware.x.util.windows.WindowForm;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLProvinciaCustom extends WLProvincia {

	public WLProvinciaCustom() {
		super();
	}

	public WLProvinciaCustom(ProvinciaFiltro filtro) {
		super(filtro);
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(59.5f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "pais", "numero", "nombre", "abreviatura", "numeroAFIP",
				"numeroIngresosBrutos", "numeroRENATEA" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("pais"), true, 224);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 224);

		UtilUI.confColumn(itemsGRD.getColumn("abreviatura"), true, 80);

		// UtilUI.confColumn(itemsGRD.getColumn("numeroAFIP"), true, true, true, -1);
		//
		// UtilUI.confColumn(itemsGRD.getColumn("numeroIngresosBrutos"), true, true,
		// true, -1);
		//
		// UtilUI.confColumn(itemsGRD.getColumn("numeroRENATEA"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numeroAFIP"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("numeroIngresosBrutos"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("numeroRENATEA"), true, 100);

		// ------------------------------------------------------------------

		Provincia dto = new Provincia();
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

	protected WindowForm buildWinddowForm(String mode, String id) {
		return new WFProvinciaCustom(mode, id);
	}

} // END CLASS
