package a;

import java.util.ArrayList;
import java.util.List;

import a.convention1.anotations.Identifiable;
import a.convention1.anotations.PersistentMapping;
import a.convention1.anotations.Schema;

@PersistentMapping
@Schema(name = "geo")
public class Country implements Identifiable {

	private String id;
	private String code;
	private String name;
	private Continent continent;
	private List<Admin1> admins = new ArrayList<Admin1>();

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

	public List<Admin1> getAdmins() {
		return admins;
	}

	public void setAdmins(List<Admin1> admins) {
		this.admins = admins;
	}

	public boolean addAdmin(Admin1 e) {
		e.setPais(this);
		return admins.add(e);
	}
	
	

}
