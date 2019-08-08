package a;

import a.convention1.anotations.Identifiable;
import a.convention1.anotations.PersistentMapping;
import a.convention1.anotations.Schema;

@PersistentMapping
@Schema(name = "geo")
public class Admin1 implements Identifiable {

	private String id;
	private String code;
	private String name;
	private Country pais;

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

	public Country getPais() {
		return pais;
	}

	public void setPais(Country pais) {
		this.pais = pais;
	}

}
