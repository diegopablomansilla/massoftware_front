package a;

import a.anotations.Persistent;
import a.anotations.Schema;
import a.model.Identifiable;

@Persistent
@Schema(name = "geo")
public class Country implements Identifiable {

	private String id;
	private String code;
	private String name;
	private Continent continent;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Continent getContinent() {
		return continent;
	}

	public void setContinent(Continent continent) {
		this.continent = continent;
	}

}
