package a;

import a.convention1.anotations.Identifiable;
import a.convention1.anotations.PersistentMapping;
import a.convention1.anotations.Schema;
import a.convention1.constraints.NotNull;

@PersistentMapping
@Schema(name = "geo")
public interface ContinentMappingInsert extends Identifiable {

	@NotNull
	public String getCode();

	public void setCode(String code);

//	public String getName();
//
//	public void setName(String name);

}
