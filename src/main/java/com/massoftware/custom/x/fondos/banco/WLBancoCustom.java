
package com.massoftware.custom.x.fondos.banco;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.fondos.banco.Banco;
import com.massoftware.service.fondos.banco.BancoFiltro;
import com.massoftware.x.fondos.banco.WLBanco;
import com.massoftware.x.util.UtilUI;
import com.vaadin.data.sort.SortOrder;

//import com.vaadin.data.util.converter.StringToBooleanConverter;
//import com.vaadin.server.FontAwesome;
//import com.vaadin.ui.renderers.DateRenderer;
//import com.vaadin.ui.renderers.HtmlRenderer;

import com.vaadin.data.util.converter.StringToBooleanConverter;
import com.vaadin.server.FontAwesome;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Alignment;
import com.vaadin.ui.Button;
import com.vaadin.ui.Component;
import com.vaadin.ui.Grid.Column;
import com.vaadin.ui.HorizontalLayout;
import com.vaadin.ui.VerticalLayout;
import com.vaadin.ui.renderers.HtmlRenderer;

@SuppressWarnings("serial")
public class WLBancoCustom extends WLBanco {

	// -------------------------------------------------------------

	public WLBancoCustom() {
		super();
	}

	public WLBancoCustom(BancoFiltro filtro) {
		super(filtro);
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		// itemsGRD.setWidth(25f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "cuit", "bloqueado", "hoja", "primeraFila",
				"ultimaFila", "fecha", "descripcion", "referencia1", "importe", "referencia2", "saldo" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 240);

		UtilUI.confColumn(itemsGRD.getColumn("cuit"), true, 132);

		UtilUI.confColumn(itemsGRD.getColumn("bloqueado"), true, 70);

		UtilUI.confColumn(itemsGRD.getColumn("hoja"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("primeraFila"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("ultimaFila"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("fecha"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("descripcion"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("referencia1"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("importe"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("referencia2"), true, true, true, -1);
		UtilUI.confColumn(itemsGRD.getColumn("saldo"), true, true, true, -1);

		// ------------------------------------------------------------------

		Banco dto = new Banco();
		for (Column column : itemsGRD.getColumns()) {
			column.setHeaderCaption(dto.label(column.getPropertyId().toString()));
		}

		itemsGRD.setContainerDataSource(getItemsBIC());

		// ------------------------------------------------------------------

		// SI UNA COLUMNA ES DE TIPO BOOLEAN HACER LO QUE SIGUE
		// itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(), new
		// StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(),
		// FontAwesome.SQUARE_O.getHtml()));

		itemsGRD.getColumn("bloqueado").setRenderer(new HtmlRenderer(),
				new StringToBooleanConverter(FontAwesome.CHECK_SQUARE_O.getHtml(), FontAwesome.SQUARE_O.getHtml()));

		// SI UNA COLUMNA ES DE TIPO DATE HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new
		// SimpleDateFormat("dd/MM/yyyy")));

		// SI UNA COLUMNA ES DE TIPO TIMESTAMP HACER LO QUE SIGUE
		// itemsGRD.getColumn("attName").setRenderer(new DateRenderer(new
		// SimpleDateFormat("dd/MM/yyyy HH:mm:ss")));

		// ------------------------------------------------------------------

		List<SortOrder> order = new ArrayList<SortOrder>();

		order.add(new SortOrder("numero", SortDirection.DESCENDING));

		itemsGRD.setSortOrder(order);

		// ------------------------------------------------------------------

	}
	
	protected Component buildFiltrosLayout() throws Exception {	
		
		bloqueadoOPT.setCaption(null);
		bloqueadoOPT.setRequired(false);
		
		VerticalLayout vl = new VerticalLayout();
		vl.setSpacing(false);
		vl.setMargin(true);
		
		HorizontalLayout hl1 = new HorizontalLayout();
		hl1.setSpacing(true);
		hl1.setMargin(false);
		
		HorizontalLayout hl2 = new HorizontalLayout();
		hl1.setSpacing(true);
		hl2.setMargin(false);
		
		vl.addComponents(hl1, hl2);
		
		// ------------------------------------------------------------------
		
		Button buscarBTN = buildButtonBuscar();		

		
		if (numeroFromTXTB != null) {
			hl1.addComponent(numeroFromTXTB);
		}
		if (numeroToTXTB != null) {
			hl1.addComponent(numeroToTXTB);
		}
		if (nombreTXTB != null) {
			hl1.addComponent(nombreTXTB);
		}
		if (bloqueadoOPT != null) {
			hl2.addComponent(bloqueadoOPT);
		}
		
		hl1.addComponent(buscarBTN);
		hl1.setComponentAlignment(buscarBTN, Alignment.MIDDLE_RIGHT);

		// ------------------------------------------------------------------

		return vl;
		
		// ------------------------------------------------------------------
	}

	// =================================================================================

} // END CLASS
