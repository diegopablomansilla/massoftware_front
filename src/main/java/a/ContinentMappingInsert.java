package a;

import a.convention1.pg.anotations.constraints.NotNull;
import a.convention1.pg.model.Identifiable;

public interface ContinentMappingInsert extends Identifiable {

	@NotNull
	public String getCode();

	public void setCode(String code);

	// public String getName();
	//
	// public void setName(String name);

}
