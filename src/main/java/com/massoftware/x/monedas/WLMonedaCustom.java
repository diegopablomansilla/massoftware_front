
package com.massoftware.x.monedas;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.massoftware.dao.monedas.MonedaFiltro;
import com.massoftware.model.monedas.Moneda;
import com.massoftware.windows.UtilUI;
import com.massoftware.windows.WindowForm;
import com.massoftware.x.afip.WFMonedaCustom;
import com.vaadin.data.sort.SortOrder;

//import com.vaadin.data.util.converter.StringToBooleanConverter;
//import com.vaadin.server.FontAwesome;
//import com.vaadin.ui.renderers.DateRenderer;
//import com.vaadin.ui.renderers.HtmlRenderer;

import com.vaadin.data.util.converter.StringToBooleanConverter;
import com.vaadin.server.FontAwesome;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;
import com.vaadin.ui.renderers.DateRenderer;
import com.vaadin.ui.renderers.HtmlRenderer;

@SuppressWarnings("serial")
public class WLMonedaCustom extends WLMoneda {

	// -------------------------------------------------------------

	public WLMonedaCustom() {
		super();
	}

	public WLMonedaCustom(MonedaFiltro filtro) {
		super(filtro);
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(41.5f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "abreviatura", "cotizacion", "cotizacionFecha",
				"controlActualizacion", "monedaAFIP" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("abreviatura"), true, 60);

		UtilUI.confColumn(itemsGRD.getColumn("cotizacion"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("cotizacionFecha"), true, 120);

		UtilUI.confColumn(itemsGRD.getColumn("controlActualizacion"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("monedaAFIP"), true, 200);

		// ------------------------------------------------------------------

		itemsGRD.getColumn("monedaAFIP").setHidden(true);
		itemsGRD.getColumn("controlActualizacion").setHidden(true);

		// ------------------------------------------------------------------

		Moneda dto = new Moneda();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		itemsGRD.getColumn("controlActualizacion").setRenderer(new HtmlRenderer(),
				new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("cotizacionFecha")
				.setRenderer(new DateRenderer(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);

		// ------------------------------------------------------------------
	}
	
	protected WindowForm buildWinddowForm(String mode, String id) {
		return new WFMonedaCustom(mode, id);
	}

} // END CLASS
