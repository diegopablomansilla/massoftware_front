package org.cendra.ex.crud;

public class DeleteForeingObjectConflictException extends
		IllegalArgumentException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7368535778606688979L;

	private static String humanMsg = "Borrado no permitido. No está permitido que usted borre %s %s \"%s\", éste está siendo usado por %s %s %s.";

	private String msg;

//	public DeleteForeingObjectConflictException(String msg) {
//		super(msg);
////		humanMsg = msg;
//	}

	public DeleteForeingObjectConflictException(String pre, String labelValue,
			Object value, Integer cant, String foreingObjects) {
		// super(String.format(humanMsg, pre, labelValue, value));
		
		if(cant > 1) {
			this.msg = String.format(humanMsg, pre, labelValue, value, cant.toString(), "items", foreingObjects);
		} else {
			this.msg = String.format(humanMsg, pre, labelValue, value, cant, "item", foreingObjects);
		}
		
		
	}

	public String getMessage() {
		return msg;
	}


}
