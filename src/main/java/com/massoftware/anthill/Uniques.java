package com.massoftware.anthill;

import java.util.ArrayList;
import java.util.List;

public class Uniques {

	private List<Unique> uniques = new ArrayList<Unique>();

	public Uniques(Unique... args) {
		if (args != null) {
			for (Unique unique : args) {
				uniques.add(unique);
			}
		}
	}
	
	public Uniques(Att... args) {
		if (args != null) {
			for (Att att : args) {
				uniques.add(new Unique(att));
			}
		}
	}

	public List<Unique> getUniques() {
		return uniques;
	}

	public void setUniques(List<Unique> uniques) {
		this.uniques = uniques;
	}

}
