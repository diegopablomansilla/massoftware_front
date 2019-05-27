package com.massoftware.anthill;

public abstract class Ant {

	private Anthill anthill;

	public Ant(Anthill anthill) {
		this.anthill = anthill;

		this.anthill.add(this);
	}

	public abstract Clazz build() throws Exception;

}
