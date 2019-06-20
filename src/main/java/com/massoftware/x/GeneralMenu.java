package com.massoftware.x;

import com.massoftware.AppCX;
import com.massoftware.windows.a.seguridad_puertas.WSeguridadPuertas;
import com.massoftware.x.util.windows.LogAndNotification;
import com.vaadin.ui.MenuBar;
import com.vaadin.ui.MenuBar.Command;
import com.vaadin.ui.MenuBar.MenuItem;
import com.vaadin.ui.Window;
import com.vaadin.ui.themes.ValoTheme;

public class GeneralMenu extends AbstractMenu {

	public GeneralMenu() {
		super("General");
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = -4876972158472186088L;

	protected MenuBar getMenuBar() {

		MenuBar menubar = new MenuBar();
		menubar.setWidth("100%");
		menubar.addStyleName(ValoTheme.MENUBAR_BORDERLESS);

		final MenuBar.MenuItem a1 = menubar.addItem("Archivos", null);
		final MenuBar.MenuItem a2 = menubar.addItem("Editar", null);
		final MenuBar.MenuItem a3 = menubar.addItem("Ventana", null);
		final MenuBar.MenuItem a4 = menubar.addItem("Ayuda", null);

		a2.setEnabled(false);
		a3.setEnabled(false);
		a4.setEnabled(false);

		a1.addItem("Módulos", null).setEnabled(false);
		a1.addItem("Activa controlador fizcal ...           Ctrl F", null).setEnabled(false);
		a1.addItem("Activa módulos", null).setEnabled(false);
		a1.addItem("File manager", null).setEnabled(false);
		a1.addSeparator();
		a1.addItem("Logon", null).setEnabled(false);
		a1.addSeparator();
		
		MenuBar.MenuItem a11 = a1.addItem("Seguridad", null);
		a11.addItem("Usuarios ...", openSeguridadUsuarioCmd());
		a11.addItem("Módulos", openSeguridadModuloCmd());
		a11.addItem("Puertas", openSeguridadPuertaCmd());
		a11.addItem("++++++++++Puertas ...", openSeguridadPuertasCmd());
		
		a1.addSeparator();
		a1.addItem("Configurar impresora ...", null).setEnabled(false);
		a1.addSeparator();
		a1.addItem("salir", null).setEnabled(false);

		return menubar;
	}

	protected Command openSeguridadPuertasCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				Window window = new WSeguridadPuertas();
				getUI().addWindow(window);
			}
		};
	}
	
	protected Command openSeguridadUsuarioCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLUsuario();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}			
			}
		};
	}
	
	protected Command openSeguridadModuloCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLSeguridadModulo();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}			
			}
		};
	}

	protected Command openSeguridadPuertaCmd() {

		return new Command() {
			/**
			 * 
			 */
			private static final long serialVersionUID = 4645387020070455569L;

			@Override
			public void menuSelected(MenuItem selectedItem) {

				try {
					Window window = AppCX.widgets().buildWLSeguridadPuerta();
					getUI().addWindow(window);
				} catch (Exception e) {
					LogAndNotification.print(e);
				}			
			}
		};
	}

}
