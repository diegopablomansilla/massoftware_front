
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
);

*/