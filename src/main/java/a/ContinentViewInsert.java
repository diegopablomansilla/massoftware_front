package a;

import a.anotations.Persistent;
import a.anotations.Schema;
import a.anotations.constraints.NotNull;
import a.model.Identifiable;

@Persistent
@Schema(name = "geo")
public interface ContinentViewInsert extends Identifiable {

	@NotNull
	public String getCode();

	public void setCode(String code);

	// public String getName();
	//
	// public void setName(String name);

}
