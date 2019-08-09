package a;

import java.util.ArrayList;
import java.util.List;

import a.convention1.anotations.PersistentMapping;
import a.convention1.anotations.Schema;

@PersistentMapping
@Schema(name = "geo")
public class Continent implements ContinentMappingInsert {

	private String id;
	private String code;
	private String name;
	private List<Country> countries = new ArrayList<Country>();

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

	public List<Country> getCountries() {
		return countries;
	}

	public void setCountries(List<Country> countries) {
		this.countries = countries;
	}

	public boolean addCountry(Country e) {
		e.setContinent(this);
		return countries.add(e);
	}

	@Override
	public String toString() {
		return "Continent [id=" + id + ", code=" + code + ", name=" + name + "]";
	}
	
	

}
