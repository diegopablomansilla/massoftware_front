package a;

import java.util.ArrayList;
import java.util.List;

import com.massoftware.model.EntityId;

public class Continent extends EntityId implements ContinentMappingInsert {

	private String id;
	private String code;
	private String name;
	private List<Country> countries = new ArrayList<Country>();

	public String getId() {
		this.id = (id != null && id.trim().length() == 0) ? null : id.trim();
		return id;
	}

	public void setId(String id) {
		this.id = (id != null && id.trim().length() == 0) ? null : id.trim();		
	}

	public String getCode() {
		this.code = (code != null && code.trim().length() == 0) ? null : code.trim();
		return code;
	}

	public void setCode(String code) {
		this.code = (code != null && code.trim().length() == 0) ? null : code.trim();
		this.code = code;
	}

	public String getName() {
		this.name = (name != null && name.trim().length() == 0) ? null : name.trim();
		return name;
	}

	public void setName(String name) {
		this.name = (name != null && name.trim().length() == 0) ? null : name.trim();
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
