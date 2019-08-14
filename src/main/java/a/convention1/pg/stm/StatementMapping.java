package a.convention1.pg.stm;

public class StatementMapping extends Statement {

	private MappingQuery mappingQuery = new MappingQuery();

	public MappingQuery getMappingQuery() {
		return mappingQuery;
	}

	public void setMappingQuery(MappingQuery mappingQuery) {
		this.mappingQuery = mappingQuery;
	}

	public String[] getPathMapping() {
		return mappingQuery.getPathMapping();
	}

}
