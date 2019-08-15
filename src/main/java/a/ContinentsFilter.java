package a;

import com.massoftware.service.AbstractFilter;

public class ContinentsFilter extends AbstractFilter {

	private String name;

	public String getName() {
		this.name = (name != null && name.trim().length() > 0) ? name.trim() : null;
		return name;
	}

	public void setName(String name) {
		this.name = (name != null && name.trim().length() > 0) ? name.trim() : null;		
	}

	public boolean equals(Object obj) {

		if (super.equals(obj) == false) {
			return false;
		}

		if (obj == this) {
			return true;
		}

		ContinentsFilter other = (ContinentsFilter) obj;

		// -------------------------------------------------------------------

		if (other.getName() == null && this.getName() != null) {
			return false;
		}

		if (other.getName() != null && this.getName() == null) {
			return false;
		}

		if (other.getName() != null && this.getName() != null) {

			if (other.getName().equals(this.getName()) == false) {
				return false;
			}

		}

		// -------------------------------------------------------------------

		return true;

		// -------------------------------------------------------------------
	}

}
