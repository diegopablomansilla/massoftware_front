 
package com.massoftware.x.clientes;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.clientes.MotivoComentario;
import com.massoftware.service.clientes.MotivoComentarioFiltro;
import com.massoftware.x.util.UtilUI;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLMotivoComentarioCustom extends WLMotivoComentario {

	// -------------------------------------------------------------

	public WLMotivoComentarioCustom() {
		super();
	}

	public WLMotivoComentarioCustom(MotivoComentarioFiltro filtro) {
		super(filtro);
	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(37f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 470);

		// ------------------------------------------------------------------

		MotivoComentario dto = new MotivoComentario();
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
