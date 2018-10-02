package com.massoftware;

import javax.servlet.annotation.WebServlet;

import com.vaadin.annotations.Theme;
import com.vaadin.annotations.VaadinServletConfiguration;
import com.vaadin.server.VaadinRequest;
import com.vaadin.server.VaadinServlet;
import com.vaadin.ui.UI;

/**
 * This UI is the application entry point. A UI may either represent a browser
 * window (or tab) or some part of a html page where a Vaadin application is
 * embedded.
 * <p>
 * The UI is initialized using {@link #init(VaadinRequest)}. This method is
 * intended to be overridden to add component to the user interface and
 * initialize non-component functionality.
 */
@Theme("mytheme")
// @Theme("material")
public class MasSoftware extends UI {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2467123584653780193L;

	@WebServlet(urlPatterns = "/*", name = "MasSoftwareServlet", asyncSupported = true)
	@VaadinServletConfiguration(ui = MasSoftware.class, productionMode = false)
	public static class MasSoftwareServlet extends VaadinServlet {

		/**
		 * 
		 */
		private static final long serialVersionUID = 3384068185250400739L;
	}

	// ===================================================================================================

	@Override
	protected void init(VaadinRequest request) {

		// ----------------------------------------

		this.setContent(new SuperMenu());

		// ----------------------------------------

	}

} // END CLASS
