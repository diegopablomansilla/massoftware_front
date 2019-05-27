
package com.massoftware.x.clientes;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.dao.clientes.MotivoBloqueoClienteFiltro;
import com.massoftware.model.clientes.MotivoBloqueoCliente;
import com.massoftware.windows.UtilUI;
import com.vaadin.data.sort.SortOrder;
import com.vaadin.shared.data.sort.SortDirection;
import com.vaadin.ui.Grid.Column;

@SuppressWarnings("serial")
public class WLMotivoBloqueoClienteCustom extends WLMotivoBloqueoCliente {

	// -------------------------------------------------------------

	public WLMotivoBloqueoClienteCustom() {
		super();
	}

	public WLMotivoBloqueoClienteCustom(MotivoBloqueoClienteFiltro filtro) {
		super(filtro);

	}

	protected void buildItemsGRDLayout() throws Exception {

		// ------------------------------------------------------------------

		itemsGRD.setWidth("100%");
		itemsGRD.setWidth(55.3f, Unit.EM);
		itemsGRD.setHeight(20.5f, Unit.EM);

		itemsGRD.setColumns(new Object[] { "id", "numero", "nombre", "clasificacionCliente" });

		// ------------------------------------------------------------------

		UtilUI.confColumn(itemsGRD.getColumn("id"), true, true, true, -1);

		UtilUI.confColumn(itemsGRD.getColumn("numero"), true, 100);

		UtilUI.confColumn(itemsGRD.getColumn("nombre"), true, 380);

		UtilUI.confColumn(itemsGRD.getColumn("clasificacionCliente"), true, 380);

		// ------------------------------------------------------------------

		MotivoBloqueoCliente dto = new MotivoBloqueoCliente();
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
