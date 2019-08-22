package com.anthill.model;

public abstract class DataType {
	
	private String name;

	public DataType(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	abstract public String getNameSQL();		
	
	abstract public String getNameJava();

	abstract public boolean isSimple();

	public boolean isString() {

		return this.getClass() == DataTypeString.class;
	}

	public boolean isNumber() {

		return isInteger() || isLong() || isDouble() || isBigDecimal();
	}
	
	public boolean isNumberDecimal() {

		return isDouble() || isBigDecimal();
	}

	public boolean isInteger() {

		return this.getClass() == DataTypeInteger.class;
	}

	public boolean isLong() {

		return this.getClass() == DataTypeLong.class;
	}

	public boolean isBoolean() {

		return this.getClass() == DataTypeBoolean.class;
	}

	public boolean isDouble() {

		return this.getClass() == DataTypeDouble.class;
	}

	public boolean isBigDecimal() {

		return this.getClass() == DataTypeBigDecimal.class;
	}

	public boolean isTimestamp() {

		return this.getClass() == DataTypeTimestamp.class;
	}
	
	public boolean isDate() {

		return this.getClass() == DataTypeDate.class;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DataType other = (DataType) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

}
