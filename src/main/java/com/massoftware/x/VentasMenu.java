package com.massoftware.x;

import com.massoftware.AppCX;
import com.massoftware.windows.a.sucursales.WSucursales;
import com.massoftware.windows.a.talonarios.WTalonarios;
import com.massoftware.x.util.windows.LogAndNotification;
import com.vaadin.ui.MenuBar;
import com.vaadin.ui.MenuBar.Command;
import com.vaadin.ui.MenuBar.MenuItem;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.ValoTheme;

public class VentasMenu extends AbstractMenu {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3092383121985372384L;

	public VentasMenu() {
		super("Ventas");
	}

	protected MenuBar getMenuBar() {

		MenuBar menubar = new MenuBar();
		menubar.setWidth("100%");
		menubar.addStyleName(ValoTheme.MENUBAR_BORDERLESS);

		final MenuBar.MenuItem a1 = menubar.addItem("Archivos", null);
		final MenuBar.MenuItem a2 = menubar.addItem("Editar", null);
		final MenuBar.MenuItem a3 = menubar.addItem("Comprobantes", null);
		final MenuBar.MenuItem a4 = menubar.addItem("Procesos", null);
		final MenuBar.MenuItem a5 = menubar.addItem("Informes", null);
		final MenuBar.MenuItem a6 = menubar.addItem("Ventana", null);
		final MenuBar.MenuItem a7 = menubar.addItem("Ayuda", null);

		a2.setEnabled(false);
		a3.setEnabled(false);
		a4.setEnabled(false);
		a5.setEnabled(false);
		a6.setEnabled(false);
		a7.setEnabled(false);

		a1.addItem("Clientes ...", null).setEnabled(false);
		a1.addSeparator();
		a1.addItem("Productos ...", null).setEnabled(false);
		a1.addItem("Lista de precios ...", null).setEnabled(false);
		a1.addSeparator();
		a1.addItem("Cobranzas ...", null).setEnabled(false);
		a1.addItem("condiciones de ventas ...", null).setEnabled(false);
		a1.addItem("Bonificaciones ...", null).setEnabled(false);
		a1.addItem("Vendedores y zonas de ventas ...", null).setEnabled(false);
		a1.addItem("Zonas ...", openZonasCmd());
		a1.addItem("Canales de comercialización ...", null).setEnabled(false);
		MenuBar.MenuItem a12 = a1.addItem("Transportes", null);
		
		a12.addItem("Transportes ...", openTransporteCmd());
		a12.addItem("Tarifas de transportes ...", openTransporteTarifaCmd());
		
		
		a1.addItem("Convenios de elaboración ...", null).setEnabled(false);

		MenuBar.MenuItem a11 = a1.addItem("Ciudades ...", null);

		a11.addItem("Paises ...", openPaisCmd());
		a11.addItem("Provincias ...", openProvinciaCmd());
		a11.addItem("Ciudades ...", openCiudadCmd());
		a11.addItem("Códigos postales ...", openCodigoPostalCmd());			
		 

		a1.addItem("Tipos de clientes ...", openTipoClienteCmd());
		a1.addItem("Sub ctas. ctes. ...", null).setEnabled(false);
		a1.addItem("Clasificación de clientes (cta. cte.) ...", openClasificacionClienteCmd());
		a1.addItem("Bloqueo de clientes ...", openMotivoBloqueoClienteCmd());
		a1.addItem("Alícuotas ...", null).setEnabled(false);
		a1.addItem("Cargas ...",  openCargaCmd());
		
		MenuBar.MenuItem a14 = a1.addItem("Depósitos", null);
		
		a14.addItem("Módulos (depósitos)", openDepositoModuloCmd());
		a14.addItem("Depósitos", openDepositoCmd());
		
		
		MenuBar.MenuItem a13 = a1.addItem("Sucursales", null);
		
		a13.addItem("Tipo de sucursales ...", openTipoSucursalCmd());
		a13.addItem("Sucursales ...", openSucursalCmd());
		a13.addItem("+++++++++Sucursales ...", openSucursalesCmd());
		
		
		a1.addItem("Tipos de documentos AFIP ...", openTipoDocumentoAFIPCmd());		
		a1.addItem("Motivos comentarios", openMotivoComentarioCmd());		
		a1.addItem("Motivos notas de crédito", openNotaCreditoMotivoCmd());
		a1.addItem("Perfil de facturación ...", null).setEnabled(false);
		a1.addItem("Parámetros generales", null).setEnabled(false);
		a1.addItem("AFIP ...", null).setEnabled(false);
		a1.addSeparator();
		a1.addItem("Tipos de comprobante", null).setEnabled(false);
		a1.addItem("+++++++++Talonarios ...", openTalonariosCmd());
		a1.addSeparator();
		a1.addItem("Configurar impresora ...", null).setEnabled(false);

		return menubar;
	}

	protected Command openSucursalesCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				Window window = new WSucursales();
				getUI().addWindow(window);
			}
		};
	}

	protected Command openTalonariosCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				Window window = new WTalonarios();
				getUI().addWindow(window);
			}
		};
	}

	protected Command openZonasCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {				
				
				try {
					Window window = AppCX.widgets().buildWLZona();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}
			}
		};
	}

	protected Command openTipoDocumentoAFIPCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLTipoDocumentoAFIP();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}

	protected Command openPaisCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLPais();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}
			}
		};
	}

	protected Command openProvinciaCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLProvincia();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}
			}
		};
	}

	protected Command openCiudadCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLCiudad();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}
			}
		};
	}

	protected Command openTipoClienteCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLTipoCliente();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}
			}
		};
	}

	protected Command openNotaCreditoMotivoCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLNotaCreditoMotivo();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}

	protected Command openMotivoComentarioCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLMotivoComentario();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openCodigoPostalCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLCodigoPostal();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openClasificacionClienteCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLClasificacionCliente();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openMotivoBloqueoClienteCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLMotivoBloqueoCliente();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openTransporteCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLTransporte();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openCargaCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLCarga();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openTransporteTarifaCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLTransporteTarifa();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openTipoSucursalCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLTipoSucursal();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openSucursalCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLSucursal();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openDepositoModuloCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLDepositoModulo();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}
	
	protected Command openDepositoCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLDeposito();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}

			}
		};
	}

}
