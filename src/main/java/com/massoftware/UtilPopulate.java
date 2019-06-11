package com.massoftware;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Random;

public class UtilPopulate {

	private static String getName(int minLength) {

		for (int i = 0; i < 1000; i++) {

			int index = getIntegerRandom(0, names.length - 1);

			String name = names[index];

			if (name.length() >= minLength) {
				return name;
			}

		}

		return "";
	}

	// private static String getName() {
	//
	// int i = getIntegerRandom(0, names.length - 1);
	//
	// return names[i];
	// }

	public static String getStringRandom(Integer min, Integer max, boolean required) {

		if (max != null && max < 10) {
			return getStringRandomABC(min, max, required);
		}

		if (min == null) {
			min = 0;
		}
		if (required) {
			min = 1;
		}

		if (max == null) {
			max = 50;
		}

		max = getIntegerRandom(min, max, true);

		Random r = new Random();

		String word = "";

		for (int i = 0; i < 1000; i++) {

			String name = getName(min);

			if (name.trim().length() > 0) {

				if ((word + " " + name).length() <= max) {
					word += " " + name;
				}

			}
		}

		String value = word.toString();

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;
	}

	// public static String getStringRandomFull(Integer min, Integer max, boolean
	// required) {
	//
	// int leftLimit = 97; // letter 'a'
	// int rightLimit = 122; // letter 'z'
	// int targetStringLength = 30;
	//
	// if (min != null && max != null) {
	// targetStringLength = max;
	// } else if (min != null && max == null) {
	// targetStringLength = min;
	// } else if (min == null && max != null) {
	// targetStringLength = max;
	// }
	//
	// Random r = new Random();
	//
	// StringBuilder buffer = new StringBuilder(targetStringLength);
	//
	// for (int i = 0; i < targetStringLength; i++) {
	//
	// int randomLimitedInt = leftLimit + (int) (r.nextFloat() * (rightLimit -
	// leftLimit + 1));
	// buffer.append((char) randomLimitedInt);
	//
	// }
	//
	// String value = buffer.toString();
	//
	// if (required == false) {
	// value = (r.nextBoolean()) ? value : null;
	// }
	//
	// return value;
	// }

	public static String getStringRandomABC(Integer min, Integer max, boolean required) {

		String[] letters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "L", "O", "P", "Q",
				"R", "S", "T", "U", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "@", "#", "$",
				"%", "&", "?", "¿", ">", "<", "¡", "Ç", " ", "ξ", "ο", "π", "ρ", "ς", "τ", "υ", "φ", "χ", "ψ", "ω", "Ξ",
				"Ο", "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω", " " };

		if (min == null) {
			min = 0;
		}
		if (required) {
			min = 1;
		}

		if (max == null) {
			max = 50;
		}

		if (max > 4) {
			max = getIntegerRandom(1, max, true);
		}

		Random r = new Random();

		String word = new String();

		for (int i = 0; i < max; i++) {

			int index = getIntegerRandom(0, letters.length - 1);

			String letter = letters[index];
			word += letter;

			System.out.println(letter);

		}

		String value = word;

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;
	}

	public static Integer getIntegerRandom(Integer min, Integer max) {

		return getIntegerRandom(min, max, true);

	}

	public static Integer getIntegerRandom(Integer min, Integer max, boolean required) {

		Random r = new Random();

		Integer value = null;

		if (max != null && min != null) {
			value = r.nextInt((max - min) + 1) + min;
		} else if (max != null && min == null) {
			value = r.nextInt((max - Integer.MIN_VALUE) + 1) + Integer.MIN_VALUE;
		} else if (max == null && min != null) {
			value = r.nextInt((Integer.MAX_VALUE - min) + 1) + min;
		} else if (max == null && min == null) {
			value = r.nextInt((Integer.MAX_VALUE - Integer.MIN_VALUE) + 1) + Integer.MIN_VALUE;
		}

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

	public static Long getLongRandom(Long min, Long max) {
		return getLongRandom(min, max, true);
	}

	public static Long getLongRandom(Long min, Long max, boolean required) {

		Random r = new Random();

		Long value = null;

		if (max != null && min != null) {
			value = min + (long) (Math.random() * (max - min));
		} else if (max != null && min == null) {
			value = Long.MIN_VALUE + (long) (Math.random() * (max - Long.MIN_VALUE));
		} else if (max == null && min != null) {
			value = min + (long) (Math.random() * (Long.MAX_VALUE - min));
		} else if (max == null && min == null) {
			value = Long.MIN_VALUE + (long) (Math.random() * (Long.MAX_VALUE - Long.MIN_VALUE));
		}

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

	public static Double getDoubleRandom(Double min, Double max, boolean required) {

		Random r = new Random();

		Double value = null;

		if (max != null && min != null) {
			value = min + (max - min) * r.nextDouble();
		} else if (max != null && min == null) {
			value = Double.MIN_VALUE + (max - Double.MIN_VALUE) * r.nextDouble();
		} else if (max == null && min != null) {
			value = min + (Double.MAX_VALUE - min) * r.nextDouble();
		} else if (max == null && min == null) {
			value = Double.MIN_VALUE + (Double.MAX_VALUE - Double.MIN_VALUE) * r.nextDouble();
		}

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

	public static Long getDateRandom(Integer min, Integer max, boolean required) {

		long offset = Timestamp.valueOf(min + "-01-01 00:00:00").getTime();
		long end = Timestamp.valueOf(max + "-01-01 00:00:00").getTime();
		long diff = end - offset + 1;
		long value = offset + (long) (Math.random() * diff);

		if (required == false) {
			value = (new Random().nextBoolean()) ? value : null;
		}

		return value;

	}

	public static BigDecimal getBigDecimalRandom(BigDecimal min, BigDecimal max, boolean required, Integer precision,
			Integer scale) {

		Random r = new Random();

		BigDecimal value = null;

		boolean b = false;

		do {

			String stringScale = "";
			String stringPrecision = "";

			int length = getIntegerRandom(1, scale - 1);

			for (int i = 0; i < length; i++) {
				stringScale += getIntegerRandom(0, 9);
			}

			length = getIntegerRandom(1, precision - scale - 1);

			for (int i = 0; i < length; i++) {
				stringPrecision += getIntegerRandom(0, 9);
			}

			value = new BigDecimal(stringPrecision + "." + stringScale);

			b = value.compareTo(min) > 0 && value.compareTo(max) < 0;

		} while (!b);

		if (required == false) {
			value = (r.nextBoolean()) ? value : null;
		}

		return value;

	}

	private static String[] names = { "San Luis", "Herrero", "Mara", "Natalia", "rey", "Frambuesa", "Silva",
			"Verde musgo​", "Marcos", "Rosario", "Los Polvorines", "Junín", "Wengué", "Cipolletti", "Santamaría",
			"República Dominicana", "Sulfán oscuro", "Santa Rosa", "Nadia", "Pereira", "Verde", "feldespato",
			"provincia", "beige", "Clara", "grado", "Pablo", "Noah", "Villanueva", "Vega", "revólver", "Carla", "Vera",
			"Cabrera", "instituto", "Mercedes", "Gris oscuro", "Lila intenso", "Gris", "Francisco", "escudo", "Martín",
			"Ian", "pirata", "Ecuador", "Isabel", "Magenta pálido", "Violeta oscuro", "Ocre dorado", "Río Cuarto",
			"Ainhoa", "Violeta claro", "Bravo", "Violeto medio", "hidrógeno", "Castillo", "inglés", "Parra", "Romeo",
			"Carlota", "Gabriel", "Blanco", "granito", "Lavanda", "Siena tostado", "bronce", "Gato", "Juan", "Tabaco",
			"Maipú", "Fucsia", "Gala", "Fernández", "Luis", "metro", "Trelew", "Triana", "San Justo", "Irene", "Cortés",
			"Lila", "Cromato", "cuadro", "Negro de humo", "Guayana Francesa", "sal", "Ángela", "programa", "mineral",
			"del", "Jorge", "Azahara", "Ciruela", "Nahia", "theta", "Ocre dorado tostado", "Franco",
			"Bermellón de Holanda", "Azabache", "Puerto Madryn", "San Ramón de la Nueva Orán", "Escudero", "Suárez",
			"Paraguay", "Villa Krause", "Aurora", "Tigre", "Lozano", "Ortiz", "San Miguel de Tucumán",
			"Concepcion del Uruguay", "Cristina", "Jaime", "general", "La Plata", "romano", "terreno", "Amarillo indio",
			"Verde amarillo", "Catamarca", "Goya", "Ensenada", "lambda", "Naranja rojizo", "Junquillo", "Castaño",
			"Saúl", "Rosa mexicano", "Esmeralda claro", "Plomo", "Belén de Escobar", "General Rodríguez", "Nieve",
			"Púrpura de Tiro", "Violeta", "San Carlos de Bariloche", "cromo", "Verde ceniza", "Alonso", "Emma", "llave",
			"Café", "Montaña", "Vila", "Mateos", "Gabriela", "Pol", "Patriarca", "Marín", "Surinam", "Azul claro",
			"astronauta", "Simón", "político", "Héctor", "Turquesa medio", "Napoleto", "Rojas", "noviembre", "Carmen",
			"Iglesias", "Índigo", "Cayetana", "Ocre rojo", "kappa", "Soler", "martes", "Elisa", "Pardo", "Azul cerúleo",
			"Olavarría", "sargento", "Romero", "Blanca", "balcón", "país", "Oro", "Roldán", "Pascual", "castillo",
			"Elena", "cabo", "Luque", "Tartagal", "cordillera", "patricio", "Trujillo", "marzo", "lanza", "madrileño",
			"Esteban", "Río", "camión", "delta", "Álex", "Biel", "Napoleto claro", "Azur", "Zafiro", "Áxel",
			"Púrpura oscuro", "Eloy", "Ituzaingó", "La Banda", "Mendoza", "Thiago", "Gris claro", "Fucsia rojizo",
			"Conde", "Tomate o cartamina", "libra", "ciruelo", "Verde azulado", "Necochea", "Panamá", "Adara",
			"montañero", "escuela", "árbol", "Jordi", "Nicaragua", "Mostaza", "Asier", "Amarillo limón", "bicicleta",
			"onza", "Bruno", "López", "almuerzo", "María", "Perico", "Azul", "Gallego", "Manuel", "Sergio",
			"Luján de Cuyo", "Rojo naranja", "Gris de Payne", "Calipso", "perro", "carpintero", "meseta", "Martí",
			"Mostaza oscuro", "Turquesa", "Amaia", "manzana", "Dorado", "ciervo", "El Salvador", "Sancho", "viernes",
			"teléfono", "patio", "Rosado encaje", "Guacamaya", "Colombia", "planeta", "Crespo", "Godoy Cruz", "Irati",
			"Azul Munsell", "Esmeralda claro", "Caballero", "México", "Puente", "muñeco", "Lila claro",
			"Aguamarina pantone", "Loro", "Ratón", "Cuesta", "San Rafael", "Lila francés", "Vega", "Marfil", "Bermejo",
			"Ramírez", "cuaderno", "Vargas", "Maia", "Morado", "Gris frío", "Miranda", "San Salvador de Jujuy",
			"Isabella", "Crodillera", "Napoleto rojizo", "Casas", "Molina", "raqueta", "Aguamarina", "Eric", "Naiara",
			"bocina", "Hurtado", "Rosado pictórico", "Menéndez", "moneda", "Moreno", "ratón", "Rafael", "Sánchez",
			"San Francisco", "Rivas", "Alabastro", "Mora", "Luca", "acueducto", "Aimar", "Eduardo", "policía", "Campos",
			"Canela", "Platino", "satélite", "Púrpura medio", "azúcar", "chimenea", "Verde de París",
			"Gobernador Gálvez", "Cian", "Santiago", "destornillador", "Vaca", "Vera", "Luna", "Verde cian", "Iker",
			"Ángel", "Rojo purpúreo", "Carrillo", "Guayana", "Gómez", "Iris", "Crema", "Violín", "Amarillo de plata",
			"Ríos", "della", "bastón", "Naranja claro", "sofá", "Azul oscuro", "aluminio", "Mostaza claro", "febrero",
			"Buey", "León", "Esmeralda", "caimán", "África", "Méndez", "Perú", "Ganso", "Salmón", "Unai", "Rey",
			"puerta", "Inés", "Argentina", "fuente", "Antonio", "Álvarez", "Vicente López", "Carmona", "Aluminio",
			"Plata antiguo", "Escarlata Gobelinos", "Magenta", "Serrano", "abril", "Vázquez", "Manuela", "Jurado",
			"Medina", "Pato", "Pardo verdoso", "Amarillo medio", "llama", "Turquesa pálido", "miel", "Ezeiza",
			"apellido", "miércoles", "Naia", "Granate", "De la Fuente", "Turquesa oscuro", "kilómetro", "Mar del Plata",
			"Pera", "Contreras", "Pons", "Bahía Blanca", "San Martín", "Carpa Común", "Lorenzo", "tres", "Azul marino",
			"televisor", "Puerto Rico", "Magenta claro", "Pez Dorado", "torre", "montaña", "Coral", "Otero",
			"Guatemala", "Treviso", "Durán", "Zárate", "Enzo", "Abraham", "concejal", "Pavo", "Abad", "capitán",
			"Tandil", "Iguana", "Alberto", "Bermellón de China", "Continente", "Muñoz", "Costa", "Berisso", "lector",
			"arco", "Iria", "de", "Celeste", "Azul eléctrico", "Guillermo", "Albo", "Ander", "Macías", "emperador",
			"cuchara", "caja", "Marrón pálido", "Tortuga", "Hematita roja", "conejo", "Kilian", "Mateo", "Aguilera",
			"Ante", "Laia", "Gutiérrez", "Samuel", "curso", "Gris atenuado", "Menta​", "Corrientes", "Alma", "Bernal",
			"océano", "Manzana", "Alan", "culebra", "Quintana", "Noelia", "Noel", "Gael", "Blanco yeso", "Gil",
			"Camello", "Uruguay", "Redondo", "Azul glauco", "Banda del Río Salí", "Hernández", "Aitor", "ciudad",
			"Beltrán", "Camacho", "Varela", "Lara", "aula", "Abril", "Casado", "Domínguez", "Bolivia", "América",
			"Aguamarina oriental", "Claudia", "Alarcón", "Roberto", "Arena", "Pau", "Elsa", "Castro", "Mendoza",
			"Comodoro Rivadavia", "Esteban Echeverría", "Marco", "Ana", "Morales", "Carbón", "Perro", "Hurón",
			"Nicolás", "Escarlata", "Magenta oscuro", "profesor", "Celia", "hierro", "Laguna", "Rojo persa", "Montes",
			"Valero", "Lechuga", "Sanz", "Lola", "Napoleto oscuro", "Rosa", "Pez Betta", "limón", "General Pico",
			"Trébol", "calendario", "grillo", "Naranja", "Andrés", "Yak", "Dorado", "Mireia", "sábado", "Ona", "Brasil",
			"Verde loro​", "Víctor", "Blanco", "doctor", "sacacorchos", "Almirante Brown", "Del Río", "Gonzalo",
			"bombero", "lapicero", "Reconquista", "Violeta pálido", "José C. Paz", "Díez", "Melado", "Calabaza",
			"Magenta cielo", "Florencio Varela", "San Isidro", "Salta", "Palacios", "Púrpura de Perkin", "Berta",
			"Luján", "Torres", "Granada", "Marrón medio", "La Rioja", "Daniela", "Rocío", "Andrés", "Andrea",
			"Lila lavanda", "oxígeno", "teclado", "Marina", "Azul de Prusia", "Marrón oscuro", "Flores", "Ferrer",
			"alfa", "sabio", "Turquesa", "David", "Rico", "Pardo ocre", "Aciano", "muralla", "Magenta intenso",
			"Blanco de zinc", "Gualeguaychú", "Lila brillante", "Lirio", "Gallardo", "Grafito", "Amarillo", "afluente",
			"deportista", "Benítez", "Nerea", "fanega", "Velasco", "Verde primavera", "Cetrino", "Celeste claro",
			"Ámbar", "pelota", "Carmín (estándar)", "Serra", "Olivia", "Yerba Buena", "Cobalto", "Sáez", "Santo Tomé",
			"Cobalto claro", "Bermejo", "Reyes", "Rojo Falun", "Lía", "Marrón dorado", "Zafiro", "terraza", "sigma",
			"San Miguel", "pluma", "Rojo púrpura", "Ciudad", "Púrpura rojizo", "Isaac", "Resistencia", "carpeta",
			"Delgado", "Aguilar", "Visón", "Marrón cuero", "Nieto", "Hígado", "velero", "Candela", "Blanco navajo",
			"Concordia", "Guaymallén", "Manzano", "Segura", "Chocolate", "Bronce", "sotana", "Antártida", "Darío",
			"Núñez", "Julieta", "Leo", "hoja", "mar", "Amarillo oscuro", "Roca", "Llama", "espada", "Ceniza", "Nora",
			"Canario", "Aparicio", "Rojo", "Santos", "Herreras", "Marc", "Padilla", "Paloma", "Ocre amarillo",
			"Lila pálido", "gamma", "Mar", "Salas", "Camino", "Izquierdo", "Millán", "Limón", "volcán", "País", "Derek",
			"gruta", "Azul", "San Nicolás de los Arroyos", "Santa Fe", "universidad", "Román", "Las Heras",
			"Rojo naranjado", "Pergamino", "circuito", "Cerdo", "meseta", "Salmón", "Prieto", "Naranja medio",
			"Salvador", "Europa", "Rivera", "Berazategui", "Avellaneda", "Liam", "Martínez", "Ocre oro",
			"Blanco antigua", "Zamora", "Carolina", "Nil", "Violeta intenso", "caballo", "Ariadna", "guerra",
			"Chivilcoy", "Costa Rica", "Guerra", "Presidencia Roque Sáenz Peña", "Azul Majorelle", "Miguel",
			"Azul Alicia (blco azul frío)", "panadero", "Azul cobalto", "espejo", "Punta Alta", "Colza", "Aitana",
			"Leyre", "Chile", "Benito", "científico", "pueblo", "Alexia", "Merlo", "Provincia", "Peña", "Honduras",
			"Rojo veneciano", "Julen", "nitrógeno", "bombilla", "Perico", "Poni", "muro", "psi", "Tomás", "periódico",
			"murciélago", "Rubén", "Estévez", "Naranja (obscuro)", "Lorente", "Eva", "Herrumbre", "Rivadavia", "Arias",
			"Azul turquesa", "Ballesteros", "Ibáñez", "estación", "Cisne", "Gamuza", "Carrasco", "Neizan",
			"Turquesa claro", "Pistacho​", "Pérez", "salmón", "Soto", "García", "Pilar", "Javier", "Aroa", "Lanús",
			"Arya", "Erizo", "Sofía", "octubre", "Aguamarina", "Amarillo claro", "Blázquez", "Cano", "cajón", "Lázaro",
			"avión", "Sara", "enero", "Pastor", "corriente", "Lomas de Zamora", "Chloe", "Alpaca", "Valeria",
			"Calabaza", "Plaza", "coche", "África", "Carmín (pictórico)", "Calvo", "Blasco", "Zoe", "Córdoba",
			"Fuentes", "Paraná", "biblioteca", "edificio", "Jan", "Espinosa", "Grana", "Montero", "Moya", "Frutilla",
			"Gerard", "Marrón", "lengua", "Río Grande", "Asia", "Ocre pardo", "Antón", "altavoz", "Buenos Aires",
			"Verde amarillo web5​", "estrecho", "hectária", "Lima", "francés", "Hámster", "Yeray", "Martí", "oro",
			"serie", "Azul medio", "Arlet", "Oveja", "Rosa coral", "General San Martín", "Rojo Munsell", "Arroyo",
			"barco", "Pedro", "Paola", "Víctor", "Quilmes", "Chimbas", "Galán", "ministro", "General Roca",
			"Barranqueras", "Mario", "Alicia", "Verde botella​", "Miguel Ángel", "Izan", "Rivero", "Victoria",
			"San Juan", "Pardo", "Martina", "pingüino", "Raúl", "Verde ceniza", "tigre", "Morón", "Negro", "León",
			"Dylan", "Gálvez", "Camila", "Alba", "Teo", "omega", "Posadas", "Gracia", "flecha", "turrón", "Merino",
			"Oliver", "Oceanía", "Adriana", "Sierra", "Ámbar", "Aarón", "Aranda", "Martín", "Robles",
			"Verde amarillento", "Aina", "Naranja oscuro", "Vicente", "Perú", "Ébano", "Veronese", "Guillén", "sirena",
			"Carmín de alizarina", "Santana", "Adrián", "Cobalto obscuro", "ácido", "Caseros", "Verde turquesa", "Cruz",
			"septiembre", "Cabra", "Bígaro", "fregona", "Castaño", "río", "Valentina", "Pacheco", "Bermellón",
			"verde oxidado", "Siena", "gato", "Ismael", "Santiago", "zapato", "Rafaela", "Villa Carlos Paz", "José",
			"Río Gallegos", "Elia", "cantante", "Bueno", "Hurlingham", "Ramos", "Campana", "Rojo indio", "Neuquén",
			"Marrón sepia", "Púrpura", "fortín", "Garrido", "Malva", "Joel", "Arroyo", "edad", "Nombre", "cometa",
			"Ruiz", "Diana", "Hidalgo", "Aleix", "Lago", "Nuria", "Lucas", "Soriano", "Iván", "Chinchilla", "fontanero",
			"Paula", "Oliva", "soldado", "Joan", "Moreno", "Vidal", "Loro Gris Africano", "Noa", "libro", "Ainara",
			"Azul eléctrico oscuro", "ladrillo", "mayo", "español", "Rosado", "Cerúleo", "Verde oscuro", "Orcela",
			"Villa María", "Mía", "Gallina", "Humo", "Santiago del Estero", "Vicuña", "eta", "Guerrero", "Plateado",
			"Alejandro", "Caoba", "Jimena", "India", "Miguel", "Mateo", "sardina", "escritor", "Gris de Davy", "jueves",
			"Daniel", "Rodrigo", "Cetrino", "Nácar", "ordenador", "San Fernando", "cueva", "diciembre", "bordó",
			"Cristian", "beta", "Rubio", "Amarillo verdoso", "pintura", "Conejo", "Mula", "Alonso", "Uva", "Ocre",
			"Calderón", "Azul pálido", "Jesús", "Oberá", "Vino", "Negro bujía", "Burro", "Rojo toscano", "catalejo",
			"Formosa", "Acosta", "Guernica", "Navarro", "cocinero", "Expósito", "Díaz", "Rufo", "camisa", "Ortega",
			"Gris medio", "Jamaica", "Venado Tuerto", "Jiménez", "lunes", "Rueda", "Villar", "verde gris", "Lucía",
			"épsilon", "Cuba", "Monte", "Lara", "mármol", "Márquez", "Mercedes", "Haití", "oreja", "Ocre pardo oscuro",
			"Carlos", "Adam", "Diego", "Alejandra", "Marrón claro", "domingo", "verde pino", "Púrpura pálido", "Álvaro",
			"Julia", "Ocre carne", "Rodrigo", "Marta", "Rodríguez", "naranja", "Verde oliva", "cura", "Cordobán",
			"González", "Venezuela", "Marcos", "Jade", "Lino", "tenedor", "plata", "vaso", "portero", "Juan", "Giménez",
			"Uva", "junio", "Hugo", "legionario", "Banana", "San Pedro", "sierra", "Laura", "península", "Bistre1​",
			"julio", "municipio", "cangrejo" };

}
