package a;

import a.convention1.anotations.Identifiable;
import a.convention1.constraints.NotNull;

public interface ContinentMappingInsert extends Identifiable {

	@NotNull
	public String getCode();

	public void setCode(String code);

	// public String getName();
	//
	// public void setName(String name);

}
