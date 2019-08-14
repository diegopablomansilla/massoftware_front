package a.convention1.pg.stm;

import java.util.ArrayList;
import java.util.List;

public class MappingQuery {

	private List<MappingQueryItem> items = new ArrayList<MappingQueryItem>();

	public List<MappingQueryItem> getItems() {
		return items;
	}

	public void setItems(List<MappingQueryItem> items) {
		this.items = items;
	}

	public boolean addItem(MappingQueryItem arg1) {
		return items.add(arg1);
	}

	public String[] getPathMapping() {
		String[] pathMapping = new String[items.size()];

		for (int i = 0; i < items.size(); i++) {
			pathMapping[i] = items.get(i).getPath();
		}

		return pathMapping;
	}

	@Override
	public String toString() {
		String s = "";

		for (MappingQueryItem item : items) {
			s += "\n" + item;
		}

		return s;
	}

}
