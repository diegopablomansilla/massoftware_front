package com.massoftware;

import com.massoftware.service.FactoryServiceImpl;
import com.massoftware.x.FactoryWidgetImpl;

// ApplicationContext
public class AppCX {

	private static AppCX appCXInstance;

	private FactoryServiceImpl factoryService;
	private FactoryWidgetImpl factoryWidget;

	private AppCX() {
		factoryService = new FactoryServiceImpl();
		factoryWidget = new FactoryWidgetImpl();
	}

	public static synchronized AppCX inst() {
		if (appCXInstance == null) {
			appCXInstance = new AppCX();
		}

		return appCXInstance;
	}

	public static synchronized FactoryServiceImpl services() {
		return inst().factoryService;
	}

	public static synchronized FactoryWidgetImpl widgets() {
		return inst().factoryWidget;
	}

}
