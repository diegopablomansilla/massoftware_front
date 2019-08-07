package a;

import a.dao.convention1.anotations.Identifiable;
import a.dao.convention1.anotations.PersistentMapping;
import a.dao.convention1.anotations.Schema;
import a.dao.convention1.constraints.NotNull;

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
