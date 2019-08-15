package a;

public class Continents {

	private String id;
	private String code;
	private String name;
	private Long countries;

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

	public Long getCountries() {
		return countries;
	}

	public void setCountries(Long countries) {
		this.countries = countries;
	}

	@Override
	public String toString() {
		return name;
	}

}
