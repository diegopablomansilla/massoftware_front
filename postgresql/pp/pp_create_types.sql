


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadPuerta                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadPuerta



DROP TYPE IF EXISTS massoftware.t_SeguridadPuerta_1 CASCADE;

CREATE TYPE massoftware.t_SeguridadPuerta_1 AS (

	  SeguridadPuerta_id      	VARCHAR(36)		-- 0	SeguridadPuerta.id
	, SeguridadPuerta_numero  	INTEGER    		-- 1	SeguridadPuerta.numero
	, SeguridadPuerta_nombre  	VARCHAR(50)		-- 2	SeguridadPuerta.nombre
	, SeguridadPuerta_equate  	VARCHAR(30)		-- 3	SeguridadPuerta.equate
	, SeguridadModulo_4_id    	VARCHAR(36)		-- 4	SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_4_numero	INTEGER    		-- 5	SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_4_nombre	VARCHAR(50)		-- 6	SeguridadPuerta.SeguridadModulo.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia



DROP TYPE IF EXISTS massoftware.t_Provincia_1 CASCADE;

CREATE TYPE massoftware.t_Provincia_1 AS (

	  Provincia_id                  	VARCHAR(36)		-- 0	Provincia.id
	, Provincia_numero              	INTEGER    		-- 1	Provincia.numero
	, Provincia_nombre              	VARCHAR(50)		-- 2	Provincia.nombre
	, Provincia_abreviatura         	VARCHAR(5) 		-- 3	Provincia.abreviatura
	, Provincia_numeroAFIP          	INTEGER    		-- 4	Provincia.numeroAFIP
	, Provincia_numeroIngresosBrutos	INTEGER    		-- 5	Provincia.numeroIngresosBrutos
	, Provincia_numeroRENATEA       	INTEGER    		-- 6	Provincia.numeroRENATEA
	, Pais_7_id                     	VARCHAR(36)		-- 7	Provincia.Pais.id
	, Pais_7_numero                 	INTEGER    		-- 8	Provincia.Pais.numero
	, Pais_7_nombre                 	VARCHAR(50)		-- 9	Provincia.Pais.nombre
	, Pais_7_abreviatura            	VARCHAR(5) 		-- 10	Provincia.Pais.abreviatura

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad



DROP TYPE IF EXISTS massoftware.t_Ciudad_1 CASCADE;

CREATE TYPE massoftware.t_Ciudad_1 AS (

	  Ciudad_id                       	VARCHAR(36)		-- 0	Ciudad.id
	, Ciudad_numero                   	INTEGER    		-- 1	Ciudad.numero
	, Ciudad_nombre                   	VARCHAR(50)		-- 2	Ciudad.nombre
	, Ciudad_departamento             	VARCHAR(50)		-- 3	Ciudad.departamento
	, Ciudad_numeroAFIP               	INTEGER    		-- 4	Ciudad.numeroAFIP
	, Provincia_5_id                  	VARCHAR(36)		-- 5	Ciudad.Provincia.id
	, Provincia_5_numero              	INTEGER    		-- 6	Ciudad.Provincia.numero
	, Provincia_5_nombre              	VARCHAR(50)		-- 7	Ciudad.Provincia.nombre
	, Provincia_5_abreviatura         	VARCHAR(5) 		-- 8	Ciudad.Provincia.abreviatura
	, Provincia_5_numeroAFIP          	INTEGER    		-- 9	Ciudad.Provincia.numeroAFIP
	, Provincia_5_numeroIngresosBrutos	INTEGER    		-- 10	Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_5_numeroRENATEA       	INTEGER    		-- 11	Ciudad.Provincia.numeroRENATEA
	, Provincia_5_pais                	VARCHAR(36)		-- 12	Ciudad.Provincia.pais

);

DROP TYPE IF EXISTS massoftware.t_Ciudad_2 CASCADE;

CREATE TYPE massoftware.t_Ciudad_2 AS (

	  Ciudad_id                       	VARCHAR(36)		-- 0	Ciudad.id
	, Ciudad_numero                   	INTEGER    		-- 1	Ciudad.numero
	, Ciudad_nombre                   	VARCHAR(50)		-- 2	Ciudad.nombre
	, Ciudad_departamento             	VARCHAR(50)		-- 3	Ciudad.departamento
	, Ciudad_numeroAFIP               	INTEGER    		-- 4	Ciudad.numeroAFIP
	, Provincia_5_id                  	VARCHAR(36)		-- 5	Ciudad.Provincia.id
	, Provincia_5_numero              	INTEGER    		-- 6	Ciudad.Provincia.numero
	, Provincia_5_nombre              	VARCHAR(50)		-- 7	Ciudad.Provincia.nombre
	, Provincia_5_abreviatura         	VARCHAR(5) 		-- 8	Ciudad.Provincia.abreviatura
	, Provincia_5_numeroAFIP          	INTEGER    		-- 9	Ciudad.Provincia.numeroAFIP
	, Provincia_5_numeroIngresosBrutos	INTEGER    		-- 10	Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_5_numeroRENATEA       	INTEGER    		-- 11	Ciudad.Provincia.numeroRENATEA
	, Pais_12_id                      	VARCHAR(36)		-- 12	Ciudad.Provincia.Pais.id
	, Pais_12_numero                  	INTEGER    		-- 13	Ciudad.Provincia.Pais.numero
	, Pais_12_nombre                  	VARCHAR(50)		-- 14	Ciudad.Provincia.Pais.nombre
	, Pais_12_abreviatura             	VARCHAR(5) 		-- 15	Ciudad.Provincia.Pais.abreviatura

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal



DROP TYPE IF EXISTS massoftware.t_CodigoPostal_1 CASCADE;

CREATE TYPE massoftware.t_CodigoPostal_1 AS (

	  CodigoPostal_id         	VARCHAR(36) 		-- 0	CodigoPostal.id
	, CodigoPostal_codigo     	VARCHAR(12) 		-- 1	CodigoPostal.codigo
	, CodigoPostal_numero     	INTEGER     		-- 2	CodigoPostal.numero
	, CodigoPostal_nombreCalle	VARCHAR(200)		-- 3	CodigoPostal.nombreCalle
	, CodigoPostal_numeroCalle	VARCHAR(20) 		-- 4	CodigoPostal.numeroCalle
	, Ciudad_5_id             	VARCHAR(36) 		-- 5	CodigoPostal.Ciudad.id
	, Ciudad_5_numero         	INTEGER     		-- 6	CodigoPostal.Ciudad.numero
	, Ciudad_5_nombre         	VARCHAR(50) 		-- 7	CodigoPostal.Ciudad.nombre
	, Ciudad_5_departamento   	VARCHAR(50) 		-- 8	CodigoPostal.Ciudad.departamento
	, Ciudad_5_numeroAFIP     	INTEGER     		-- 9	CodigoPostal.Ciudad.numeroAFIP
	, Ciudad_5_provincia      	VARCHAR(36) 		-- 10	CodigoPostal.Ciudad.provincia

);

DROP TYPE IF EXISTS massoftware.t_CodigoPostal_2 CASCADE;

CREATE TYPE massoftware.t_CodigoPostal_2 AS (

	  CodigoPostal_id                  	VARCHAR(36) 		-- 0	CodigoPostal.id
	, CodigoPostal_codigo              	VARCHAR(12) 		-- 1	CodigoPostal.codigo
	, CodigoPostal_numero              	INTEGER     		-- 2	CodigoPostal.numero
	, CodigoPostal_nombreCalle         	VARCHAR(200)		-- 3	CodigoPostal.nombreCalle
	, CodigoPostal_numeroCalle         	VARCHAR(20) 		-- 4	CodigoPostal.numeroCalle
	, Ciudad_5_id                      	VARCHAR(36) 		-- 5	CodigoPostal.Ciudad.id
	, Ciudad_5_numero                  	INTEGER     		-- 6	CodigoPostal.Ciudad.numero
	, Ciudad_5_nombre                  	VARCHAR(50) 		-- 7	CodigoPostal.Ciudad.nombre
	, Ciudad_5_departamento            	VARCHAR(50) 		-- 8	CodigoPostal.Ciudad.departamento
	, Ciudad_5_numeroAFIP              	INTEGER     		-- 9	CodigoPostal.Ciudad.numeroAFIP
	, Provincia_10_id                  	VARCHAR(36) 		-- 10	CodigoPostal.Ciudad.Provincia.id
	, Provincia_10_numero              	INTEGER     		-- 11	CodigoPostal.Ciudad.Provincia.numero
	, Provincia_10_nombre              	VARCHAR(50) 		-- 12	CodigoPostal.Ciudad.Provincia.nombre
	, Provincia_10_abreviatura         	VARCHAR(5)  		-- 13	CodigoPostal.Ciudad.Provincia.abreviatura
	, Provincia_10_numeroAFIP          	INTEGER     		-- 14	CodigoPostal.Ciudad.Provincia.numeroAFIP
	, Provincia_10_numeroIngresosBrutos	INTEGER     		-- 15	CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_10_numeroRENATEA       	INTEGER     		-- 16	CodigoPostal.Ciudad.Provincia.numeroRENATEA
	, Provincia_10_pais                	VARCHAR(36) 		-- 17	CodigoPostal.Ciudad.Provincia.pais

);

DROP TYPE IF EXISTS massoftware.t_CodigoPostal_3 CASCADE;

CREATE TYPE massoftware.t_CodigoPostal_3 AS (

	  CodigoPostal_id                  	VARCHAR(36) 		-- 0	CodigoPostal.id
	, CodigoPostal_codigo              	VARCHAR(12) 		-- 1	CodigoPostal.codigo
	, CodigoPostal_numero              	INTEGER     		-- 2	CodigoPostal.numero
	, CodigoPostal_nombreCalle         	VARCHAR(200)		-- 3	CodigoPostal.nombreCalle
	, CodigoPostal_numeroCalle         	VARCHAR(20) 		-- 4	CodigoPostal.numeroCalle
	, Ciudad_5_id                      	VARCHAR(36) 		-- 5	CodigoPostal.Ciudad.id
	, Ciudad_5_numero                  	INTEGER     		-- 6	CodigoPostal.Ciudad.numero
	, Ciudad_5_nombre                  	VARCHAR(50) 		-- 7	CodigoPostal.Ciudad.nombre
	, Ciudad_5_departamento            	VARCHAR(50) 		-- 8	CodigoPostal.Ciudad.departamento
	, Ciudad_5_numeroAFIP              	INTEGER     		-- 9	CodigoPostal.Ciudad.numeroAFIP
	, Provincia_10_id                  	VARCHAR(36) 		-- 10	CodigoPostal.Ciudad.Provincia.id
	, Provincia_10_numero              	INTEGER     		-- 11	CodigoPostal.Ciudad.Provincia.numero
	, Provincia_10_nombre              	VARCHAR(50) 		-- 12	CodigoPostal.Ciudad.Provincia.nombre
	, Provincia_10_abreviatura         	VARCHAR(5)  		-- 13	CodigoPostal.Ciudad.Provincia.abreviatura
	, Provincia_10_numeroAFIP          	INTEGER     		-- 14	CodigoPostal.Ciudad.Provincia.numeroAFIP
	, Provincia_10_numeroIngresosBrutos	INTEGER     		-- 15	CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_10_numeroRENATEA       	INTEGER     		-- 16	CodigoPostal.Ciudad.Provincia.numeroRENATEA
	, Pais_17_id                       	VARCHAR(36) 		-- 17	CodigoPostal.Ciudad.Provincia.Pais.id
	, Pais_17_numero                   	INTEGER     		-- 18	CodigoPostal.Ciudad.Provincia.Pais.numero
	, Pais_17_nombre                   	VARCHAR(50) 		-- 19	CodigoPostal.Ciudad.Provincia.Pais.nombre
	, Pais_17_abreviatura              	VARCHAR(5)  		-- 20	CodigoPostal.Ciudad.Provincia.Pais.abreviatura

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte



DROP TYPE IF EXISTS massoftware.t_Transporte_1 CASCADE;

CREATE TYPE massoftware.t_Transporte_1 AS (

	  Transporte_id             	VARCHAR(36) 		-- 0	Transporte.id
	, Transporte_numero         	INTEGER     		-- 1	Transporte.numero
	, Transporte_nombre         	VARCHAR(50) 		-- 2	Transporte.nombre
	, Transporte_cuit           	BIGINT      		-- 3	Transporte.cuit
	, Transporte_ingresosBrutos 	VARCHAR(13) 		-- 4	Transporte.ingresosBrutos
	, Transporte_telefono       	VARCHAR(50) 		-- 5	Transporte.telefono
	, Transporte_fax            	VARCHAR(50) 		-- 6	Transporte.fax
	, CodigoPostal_7_id         	VARCHAR(36) 		-- 7	Transporte.CodigoPostal.id
	, CodigoPostal_7_codigo     	VARCHAR(12) 		-- 8	Transporte.CodigoPostal.codigo
	, CodigoPostal_7_numero     	INTEGER     		-- 9	Transporte.CodigoPostal.numero
	, CodigoPostal_7_nombreCalle	VARCHAR(200)		-- 10	Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_7_numeroCalle	VARCHAR(20) 		-- 11	Transporte.CodigoPostal.numeroCalle
	, CodigoPostal_7_ciudad     	VARCHAR(36) 		-- 12	Transporte.CodigoPostal.ciudad
	, Transporte_domicilio      	VARCHAR(150)		-- 13	Transporte.domicilio
	, Transporte_comentario     	VARCHAR(300)		-- 14	Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Transporte_2 CASCADE;

CREATE TYPE massoftware.t_Transporte_2 AS (

	  Transporte_id             	VARCHAR(36) 		-- 0	Transporte.id
	, Transporte_numero         	INTEGER     		-- 1	Transporte.numero
	, Transporte_nombre         	VARCHAR(50) 		-- 2	Transporte.nombre
	, Transporte_cuit           	BIGINT      		-- 3	Transporte.cuit
	, Transporte_ingresosBrutos 	VARCHAR(13) 		-- 4	Transporte.ingresosBrutos
	, Transporte_telefono       	VARCHAR(50) 		-- 5	Transporte.telefono
	, Transporte_fax            	VARCHAR(50) 		-- 6	Transporte.fax
	, CodigoPostal_7_id         	VARCHAR(36) 		-- 7	Transporte.CodigoPostal.id
	, CodigoPostal_7_codigo     	VARCHAR(12) 		-- 8	Transporte.CodigoPostal.codigo
	, CodigoPostal_7_numero     	INTEGER     		-- 9	Transporte.CodigoPostal.numero
	, CodigoPostal_7_nombreCalle	VARCHAR(200)		-- 10	Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_7_numeroCalle	VARCHAR(20) 		-- 11	Transporte.CodigoPostal.numeroCalle
	, Ciudad_12_id              	VARCHAR(36) 		-- 12	Transporte.CodigoPostal.Ciudad.id
	, Ciudad_12_numero          	INTEGER     		-- 13	Transporte.CodigoPostal.Ciudad.numero
	, Ciudad_12_nombre          	VARCHAR(50) 		-- 14	Transporte.CodigoPostal.Ciudad.nombre
	, Ciudad_12_departamento    	VARCHAR(50) 		-- 15	Transporte.CodigoPostal.Ciudad.departamento
	, Ciudad_12_numeroAFIP      	INTEGER     		-- 16	Transporte.CodigoPostal.Ciudad.numeroAFIP
	, Ciudad_12_provincia       	VARCHAR(36) 		-- 17	Transporte.CodigoPostal.Ciudad.provincia
	, Transporte_domicilio      	VARCHAR(150)		-- 18	Transporte.domicilio
	, Transporte_comentario     	VARCHAR(300)		-- 19	Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Transporte_3 CASCADE;

CREATE TYPE massoftware.t_Transporte_3 AS (

	  Transporte_id                    	VARCHAR(36) 		-- 0	Transporte.id
	, Transporte_numero                	INTEGER     		-- 1	Transporte.numero
	, Transporte_nombre                	VARCHAR(50) 		-- 2	Transporte.nombre
	, Transporte_cuit                  	BIGINT      		-- 3	Transporte.cuit
	, Transporte_ingresosBrutos        	VARCHAR(13) 		-- 4	Transporte.ingresosBrutos
	, Transporte_telefono              	VARCHAR(50) 		-- 5	Transporte.telefono
	, Transporte_fax                   	VARCHAR(50) 		-- 6	Transporte.fax
	, CodigoPostal_7_id                	VARCHAR(36) 		-- 7	Transporte.CodigoPostal.id
	, CodigoPostal_7_codigo            	VARCHAR(12) 		-- 8	Transporte.CodigoPostal.codigo
	, CodigoPostal_7_numero            	INTEGER     		-- 9	Transporte.CodigoPostal.numero
	, CodigoPostal_7_nombreCalle       	VARCHAR(200)		-- 10	Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_7_numeroCalle       	VARCHAR(20) 		-- 11	Transporte.CodigoPostal.numeroCalle
	, Ciudad_12_id                     	VARCHAR(36) 		-- 12	Transporte.CodigoPostal.Ciudad.id
	, Ciudad_12_numero                 	INTEGER     		-- 13	Transporte.CodigoPostal.Ciudad.numero
	, Ciudad_12_nombre                 	VARCHAR(50) 		-- 14	Transporte.CodigoPostal.Ciudad.nombre
	, Ciudad_12_departamento           	VARCHAR(50) 		-- 15	Transporte.CodigoPostal.Ciudad.departamento
	, Ciudad_12_numeroAFIP             	INTEGER     		-- 16	Transporte.CodigoPostal.Ciudad.numeroAFIP
	, Provincia_17_id                  	VARCHAR(36) 		-- 17	Transporte.CodigoPostal.Ciudad.Provincia.id
	, Provincia_17_numero              	INTEGER     		-- 18	Transporte.CodigoPostal.Ciudad.Provincia.numero
	, Provincia_17_nombre              	VARCHAR(50) 		-- 19	Transporte.CodigoPostal.Ciudad.Provincia.nombre
	, Provincia_17_abreviatura         	VARCHAR(5)  		-- 20	Transporte.CodigoPostal.Ciudad.Provincia.abreviatura
	, Provincia_17_numeroAFIP          	INTEGER     		-- 21	Transporte.CodigoPostal.Ciudad.Provincia.numeroAFIP
	, Provincia_17_numeroIngresosBrutos	INTEGER     		-- 22	Transporte.CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_17_numeroRENATEA       	INTEGER     		-- 23	Transporte.CodigoPostal.Ciudad.Provincia.numeroRENATEA
	, Provincia_17_pais                	VARCHAR(36) 		-- 24	Transporte.CodigoPostal.Ciudad.Provincia.pais
	, Transporte_domicilio             	VARCHAR(150)		-- 25	Transporte.domicilio
	, Transporte_comentario            	VARCHAR(300)		-- 26	Transporte.comentario

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga



DROP TYPE IF EXISTS massoftware.t_Carga_1 CASCADE;

CREATE TYPE massoftware.t_Carga_1 AS (

	  Carga_id                   	VARCHAR(36) 		-- 0	Carga.id
	, Carga_numero               	INTEGER     		-- 1	Carga.numero
	, Carga_nombre               	VARCHAR(50) 		-- 2	Carga.nombre
	, Transporte_3_id            	VARCHAR(36) 		-- 3	Carga.Transporte.id
	, Transporte_3_numero        	INTEGER     		-- 4	Carga.Transporte.numero
	, Transporte_3_nombre        	VARCHAR(50) 		-- 5	Carga.Transporte.nombre
	, Transporte_3_cuit          	BIGINT      		-- 6	Carga.Transporte.cuit
	, Transporte_3_ingresosBrutos	VARCHAR(13) 		-- 7	Carga.Transporte.ingresosBrutos
	, Transporte_3_telefono      	VARCHAR(50) 		-- 8	Carga.Transporte.telefono
	, Transporte_3_fax           	VARCHAR(50) 		-- 9	Carga.Transporte.fax
	, Transporte_3_codigoPostal  	VARCHAR(36) 		-- 10	Carga.Transporte.codigoPostal
	, Transporte_3_domicilio     	VARCHAR(150)		-- 11	Carga.Transporte.domicilio
	, Transporte_3_comentario    	VARCHAR(300)		-- 12	Carga.Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Carga_2 CASCADE;

CREATE TYPE massoftware.t_Carga_2 AS (

	  Carga_id                   	VARCHAR(36) 		-- 0	Carga.id
	, Carga_numero               	INTEGER     		-- 1	Carga.numero
	, Carga_nombre               	VARCHAR(50) 		-- 2	Carga.nombre
	, Transporte_3_id            	VARCHAR(36) 		-- 3	Carga.Transporte.id
	, Transporte_3_numero        	INTEGER     		-- 4	Carga.Transporte.numero
	, Transporte_3_nombre        	VARCHAR(50) 		-- 5	Carga.Transporte.nombre
	, Transporte_3_cuit          	BIGINT      		-- 6	Carga.Transporte.cuit
	, Transporte_3_ingresosBrutos	VARCHAR(13) 		-- 7	Carga.Transporte.ingresosBrutos
	, Transporte_3_telefono      	VARCHAR(50) 		-- 8	Carga.Transporte.telefono
	, Transporte_3_fax           	VARCHAR(50) 		-- 9	Carga.Transporte.fax
	, CodigoPostal_10_id         	VARCHAR(36) 		-- 10	Carga.Transporte.CodigoPostal.id
	, CodigoPostal_10_codigo     	VARCHAR(12) 		-- 11	Carga.Transporte.CodigoPostal.codigo
	, CodigoPostal_10_numero     	INTEGER     		-- 12	Carga.Transporte.CodigoPostal.numero
	, CodigoPostal_10_nombreCalle	VARCHAR(200)		-- 13	Carga.Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_10_numeroCalle	VARCHAR(20) 		-- 14	Carga.Transporte.CodigoPostal.numeroCalle
	, CodigoPostal_10_ciudad     	VARCHAR(36) 		-- 15	Carga.Transporte.CodigoPostal.ciudad
	, Transporte_3_domicilio     	VARCHAR(150)		-- 16	Carga.Transporte.domicilio
	, Transporte_3_comentario    	VARCHAR(300)		-- 17	Carga.Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Carga_3 CASCADE;

CREATE TYPE massoftware.t_Carga_3 AS (

	  Carga_id                   	VARCHAR(36) 		-- 0	Carga.id
	, Carga_numero               	INTEGER     		-- 1	Carga.numero
	, Carga_nombre               	VARCHAR(50) 		-- 2	Carga.nombre
	, Transporte_3_id            	VARCHAR(36) 		-- 3	Carga.Transporte.id
	, Transporte_3_numero        	INTEGER     		-- 4	Carga.Transporte.numero
	, Transporte_3_nombre        	VARCHAR(50) 		-- 5	Carga.Transporte.nombre
	, Transporte_3_cuit          	BIGINT      		-- 6	Carga.Transporte.cuit
	, Transporte_3_ingresosBrutos	VARCHAR(13) 		-- 7	Carga.Transporte.ingresosBrutos
	, Transporte_3_telefono      	VARCHAR(50) 		-- 8	Carga.Transporte.telefono
	, Transporte_3_fax           	VARCHAR(50) 		-- 9	Carga.Transporte.fax
	, CodigoPostal_10_id         	VARCHAR(36) 		-- 10	Carga.Transporte.CodigoPostal.id
	, CodigoPostal_10_codigo     	VARCHAR(12) 		-- 11	Carga.Transporte.CodigoPostal.codigo
	, CodigoPostal_10_numero     	INTEGER     		-- 12	Carga.Transporte.CodigoPostal.numero
	, CodigoPostal_10_nombreCalle	VARCHAR(200)		-- 13	Carga.Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_10_numeroCalle	VARCHAR(20) 		-- 14	Carga.Transporte.CodigoPostal.numeroCalle
	, Ciudad_15_id               	VARCHAR(36) 		-- 15	Carga.Transporte.CodigoPostal.Ciudad.id
	, Ciudad_15_numero           	INTEGER     		-- 16	Carga.Transporte.CodigoPostal.Ciudad.numero
	, Ciudad_15_nombre           	VARCHAR(50) 		-- 17	Carga.Transporte.CodigoPostal.Ciudad.nombre
	, Ciudad_15_departamento     	VARCHAR(50) 		-- 18	Carga.Transporte.CodigoPostal.Ciudad.departamento
	, Ciudad_15_numeroAFIP       	INTEGER     		-- 19	Carga.Transporte.CodigoPostal.Ciudad.numeroAFIP
	, Ciudad_15_provincia        	VARCHAR(36) 		-- 20	Carga.Transporte.CodigoPostal.Ciudad.provincia
	, Transporte_3_domicilio     	VARCHAR(150)		-- 21	Carga.Transporte.domicilio
	, Transporte_3_comentario    	VARCHAR(300)		-- 22	Carga.Transporte.comentario

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa



DROP TYPE IF EXISTS massoftware.t_TransporteTarifa_1 CASCADE;

CREATE TYPE massoftware.t_TransporteTarifa_1 AS (

	  TransporteTarifa_id                     	VARCHAR(36)  		-- 0	TransporteTarifa.id
	, TransporteTarifa_numero                 	INTEGER      		-- 1	TransporteTarifa.numero
	, Carga_2_id                              	VARCHAR(36)  		-- 2	TransporteTarifa.Carga.id
	, Carga_2_numero                          	INTEGER      		-- 3	TransporteTarifa.Carga.numero
	, Carga_2_nombre                          	VARCHAR(50)  		-- 4	TransporteTarifa.Carga.nombre
	, Carga_2_transporte                      	VARCHAR(36)  		-- 5	TransporteTarifa.Carga.transporte
	, Ciudad_6_id                             	VARCHAR(36)  		-- 6	TransporteTarifa.Ciudad.id
	, Ciudad_6_numero                         	INTEGER      		-- 7	TransporteTarifa.Ciudad.numero
	, Ciudad_6_nombre                         	VARCHAR(50)  		-- 8	TransporteTarifa.Ciudad.nombre
	, Ciudad_6_departamento                   	VARCHAR(50)  		-- 9	TransporteTarifa.Ciudad.departamento
	, Ciudad_6_numeroAFIP                     	INTEGER      		-- 10	TransporteTarifa.Ciudad.numeroAFIP
	, Ciudad_6_provincia                      	VARCHAR(36)  		-- 11	TransporteTarifa.Ciudad.provincia
	, TransporteTarifa_precioFlete            	DECIMAL(13,5)		-- 12	TransporteTarifa.precioFlete
	, TransporteTarifa_precioUnidadFacturacion	DECIMAL(13,5)		-- 13	TransporteTarifa.precioUnidadFacturacion
	, TransporteTarifa_precioUnidadStock      	DECIMAL(13,5)		-- 14	TransporteTarifa.precioUnidadStock
	, TransporteTarifa_precioBultos           	DECIMAL(13,5)		-- 15	TransporteTarifa.precioBultos
	, TransporteTarifa_importeMinimoEntrega   	DECIMAL(13,5)		-- 16	TransporteTarifa.importeMinimoEntrega
	, TransporteTarifa_importeMinimoCarga     	DECIMAL(13,5)		-- 17	TransporteTarifa.importeMinimoCarga

);

DROP TYPE IF EXISTS massoftware.t_TransporteTarifa_2 CASCADE;

CREATE TYPE massoftware.t_TransporteTarifa_2 AS (

	  TransporteTarifa_id                     	VARCHAR(36)  		-- 0	TransporteTarifa.id
	, TransporteTarifa_numero                 	INTEGER      		-- 1	TransporteTarifa.numero
	, Carga_2_id                              	VARCHAR(36)  		-- 2	TransporteTarifa.Carga.id
	, Carga_2_numero                          	INTEGER      		-- 3	TransporteTarifa.Carga.numero
	, Carga_2_nombre                          	VARCHAR(50)  		-- 4	TransporteTarifa.Carga.nombre
	, Transporte_5_id                         	VARCHAR(36)  		-- 5	TransporteTarifa.Carga.Transporte.id
	, Transporte_5_numero                     	INTEGER      		-- 6	TransporteTarifa.Carga.Transporte.numero
	, Transporte_5_nombre                     	VARCHAR(50)  		-- 7	TransporteTarifa.Carga.Transporte.nombre
	, Transporte_5_cuit                       	BIGINT       		-- 8	TransporteTarifa.Carga.Transporte.cuit
	, Transporte_5_ingresosBrutos             	VARCHAR(13)  		-- 9	TransporteTarifa.Carga.Transporte.ingresosBrutos
	, Transporte_5_telefono                   	VARCHAR(50)  		-- 10	TransporteTarifa.Carga.Transporte.telefono
	, Transporte_5_fax                        	VARCHAR(50)  		-- 11	TransporteTarifa.Carga.Transporte.fax
	, Transporte_5_codigoPostal               	VARCHAR(36)  		-- 12	TransporteTarifa.Carga.Transporte.codigoPostal
	, Transporte_5_domicilio                  	VARCHAR(150) 		-- 13	TransporteTarifa.Carga.Transporte.domicilio
	, Transporte_5_comentario                 	VARCHAR(300) 		-- 14	TransporteTarifa.Carga.Transporte.comentario
	, Ciudad_15_id                            	VARCHAR(36)  		-- 15	TransporteTarifa.Ciudad.id
	, Ciudad_15_numero                        	INTEGER      		-- 16	TransporteTarifa.Ciudad.numero
	, Ciudad_15_nombre                        	VARCHAR(50)  		-- 17	TransporteTarifa.Ciudad.nombre
	, Ciudad_15_departamento                  	VARCHAR(50)  		-- 18	TransporteTarifa.Ciudad.departamento
	, Ciudad_15_numeroAFIP                    	INTEGER      		-- 19	TransporteTarifa.Ciudad.numeroAFIP
	, Provincia_20_id                         	VARCHAR(36)  		-- 20	TransporteTarifa.Ciudad.Provincia.id
	, Provincia_20_numero                     	INTEGER      		-- 21	TransporteTarifa.Ciudad.Provincia.numero
	, Provincia_20_nombre                     	VARCHAR(50)  		-- 22	TransporteTarifa.Ciudad.Provincia.nombre
	, Provincia_20_abreviatura                	VARCHAR(5)   		-- 23	TransporteTarifa.Ciudad.Provincia.abreviatura
	, Provincia_20_numeroAFIP                 	INTEGER      		-- 24	TransporteTarifa.Ciudad.Provincia.numeroAFIP
	, Provincia_20_numeroIngresosBrutos       	INTEGER      		-- 25	TransporteTarifa.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_20_numeroRENATEA              	INTEGER      		-- 26	TransporteTarifa.Ciudad.Provincia.numeroRENATEA
	, Provincia_20_pais                       	VARCHAR(36)  		-- 27	TransporteTarifa.Ciudad.Provincia.pais
	, TransporteTarifa_precioFlete            	DECIMAL(13,5)		-- 28	TransporteTarifa.precioFlete
	, TransporteTarifa_precioUnidadFacturacion	DECIMAL(13,5)		-- 29	TransporteTarifa.precioUnidadFacturacion
	, TransporteTarifa_precioUnidadStock      	DECIMAL(13,5)		-- 30	TransporteTarifa.precioUnidadStock
	, TransporteTarifa_precioBultos           	DECIMAL(13,5)		-- 31	TransporteTarifa.precioBultos
	, TransporteTarifa_importeMinimoEntrega   	DECIMAL(13,5)		-- 32	TransporteTarifa.importeMinimoEntrega
	, TransporteTarifa_importeMinimoCarga     	DECIMAL(13,5)		-- 33	TransporteTarifa.importeMinimoCarga

);

DROP TYPE IF EXISTS massoftware.t_TransporteTarifa_3 CASCADE;

CREATE TYPE massoftware.t_TransporteTarifa_3 AS (

	  TransporteTarifa_id                     	VARCHAR(36)  		-- 0	TransporteTarifa.id
	, TransporteTarifa_numero                 	INTEGER      		-- 1	TransporteTarifa.numero
	, Carga_2_id                              	VARCHAR(36)  		-- 2	TransporteTarifa.Carga.id
	, Carga_2_numero                          	INTEGER      		-- 3	TransporteTarifa.Carga.numero
	, Carga_2_nombre                          	VARCHAR(50)  		-- 4	TransporteTarifa.Carga.nombre
	, Transporte_5_id                         	VARCHAR(36)  		-- 5	TransporteTarifa.Carga.Transporte.id
	, Transporte_5_numero                     	INTEGER      		-- 6	TransporteTarifa.Carga.Transporte.numero
	, Transporte_5_nombre                     	VARCHAR(50)  		-- 7	TransporteTarifa.Carga.Transporte.nombre
	, Transporte_5_cuit                       	BIGINT       		-- 8	TransporteTarifa.Carga.Transporte.cuit
	, Transporte_5_ingresosBrutos             	VARCHAR(13)  		-- 9	TransporteTarifa.Carga.Transporte.ingresosBrutos
	, Transporte_5_telefono                   	VARCHAR(50)  		-- 10	TransporteTarifa.Carga.Transporte.telefono
	, Transporte_5_fax                        	VARCHAR(50)  		-- 11	TransporteTarifa.Carga.Transporte.fax
	, CodigoPostal_12_id                      	VARCHAR(36)  		-- 12	TransporteTarifa.Carga.Transporte.CodigoPostal.id
	, CodigoPostal_12_codigo                  	VARCHAR(12)  		-- 13	TransporteTarifa.Carga.Transporte.CodigoPostal.codigo
	, CodigoPostal_12_numero                  	INTEGER      		-- 14	TransporteTarifa.Carga.Transporte.CodigoPostal.numero
	, CodigoPostal_12_nombreCalle             	VARCHAR(200) 		-- 15	TransporteTarifa.Carga.Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_12_numeroCalle             	VARCHAR(20)  		-- 16	TransporteTarifa.Carga.Transporte.CodigoPostal.numeroCalle
	, CodigoPostal_12_ciudad                  	VARCHAR(36)  		-- 17	TransporteTarifa.Carga.Transporte.CodigoPostal.ciudad
	, Transporte_5_domicilio                  	VARCHAR(150) 		-- 18	TransporteTarifa.Carga.Transporte.domicilio
	, Transporte_5_comentario                 	VARCHAR(300) 		-- 19	TransporteTarifa.Carga.Transporte.comentario
	, Ciudad_20_id                            	VARCHAR(36)  		-- 20	TransporteTarifa.Ciudad.id
	, Ciudad_20_numero                        	INTEGER      		-- 21	TransporteTarifa.Ciudad.numero
	, Ciudad_20_nombre                        	VARCHAR(50)  		-- 22	TransporteTarifa.Ciudad.nombre
	, Ciudad_20_departamento                  	VARCHAR(50)  		-- 23	TransporteTarifa.Ciudad.departamento
	, Ciudad_20_numeroAFIP                    	INTEGER      		-- 24	TransporteTarifa.Ciudad.numeroAFIP
	, Provincia_25_id                         	VARCHAR(36)  		-- 25	TransporteTarifa.Ciudad.Provincia.id
	, Provincia_25_numero                     	INTEGER      		-- 26	TransporteTarifa.Ciudad.Provincia.numero
	, Provincia_25_nombre                     	VARCHAR(50)  		-- 27	TransporteTarifa.Ciudad.Provincia.nombre
	, Provincia_25_abreviatura                	VARCHAR(5)   		-- 28	TransporteTarifa.Ciudad.Provincia.abreviatura
	, Provincia_25_numeroAFIP                 	INTEGER      		-- 29	TransporteTarifa.Ciudad.Provincia.numeroAFIP
	, Provincia_25_numeroIngresosBrutos       	INTEGER      		-- 30	TransporteTarifa.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_25_numeroRENATEA              	INTEGER      		-- 31	TransporteTarifa.Ciudad.Provincia.numeroRENATEA
	, Pais_32_id                              	VARCHAR(36)  		-- 32	TransporteTarifa.Ciudad.Provincia.Pais.id
	, Pais_32_numero                          	INTEGER      		-- 33	TransporteTarifa.Ciudad.Provincia.Pais.numero
	, Pais_32_nombre                          	VARCHAR(50)  		-- 34	TransporteTarifa.Ciudad.Provincia.Pais.nombre
	, Pais_32_abreviatura                     	VARCHAR(5)   		-- 35	TransporteTarifa.Ciudad.Provincia.Pais.abreviatura
	, TransporteTarifa_precioFlete            	DECIMAL(13,5)		-- 36	TransporteTarifa.precioFlete
	, TransporteTarifa_precioUnidadFacturacion	DECIMAL(13,5)		-- 37	TransporteTarifa.precioUnidadFacturacion
	, TransporteTarifa_precioUnidadStock      	DECIMAL(13,5)		-- 38	TransporteTarifa.precioUnidadStock
	, TransporteTarifa_precioBultos           	DECIMAL(13,5)		-- 39	TransporteTarifa.precioBultos
	, TransporteTarifa_importeMinimoEntrega   	DECIMAL(13,5)		-- 40	TransporteTarifa.importeMinimoEntrega
	, TransporteTarifa_importeMinimoCarga     	DECIMAL(13,5)		-- 41	TransporteTarifa.importeMinimoCarga

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente



DROP TYPE IF EXISTS massoftware.t_MotivoBloqueoCliente_1 CASCADE;

CREATE TYPE massoftware.t_MotivoBloqueoCliente_1 AS (

	  MotivoBloqueoCliente_id      	VARCHAR(36)		-- 0	MotivoBloqueoCliente.id
	, MotivoBloqueoCliente_numero  	INTEGER    		-- 1	MotivoBloqueoCliente.numero
	, MotivoBloqueoCliente_nombre  	VARCHAR(50)		-- 2	MotivoBloqueoCliente.nombre
	, ClasificacionCliente_3_id    	VARCHAR(36)		-- 3	MotivoBloqueoCliente.ClasificacionCliente.id
	, ClasificacionCliente_3_numero	INTEGER    		-- 4	MotivoBloqueoCliente.ClasificacionCliente.numero
	, ClasificacionCliente_3_nombre	VARCHAR(50)		-- 5	MotivoBloqueoCliente.ClasificacionCliente.nombre
	, ClasificacionCliente_3_color 	INTEGER    		-- 6	MotivoBloqueoCliente.ClasificacionCliente.color

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Sucursal                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Sucursal



DROP TYPE IF EXISTS massoftware.t_Sucursal_1 CASCADE;

CREATE TYPE massoftware.t_Sucursal_1 AS (

	  Sucursal_id                               	VARCHAR(36)		-- 0	Sucursal.id
	, Sucursal_numero                           	INTEGER    		-- 1	Sucursal.numero
	, Sucursal_nombre                           	VARCHAR(50)		-- 2	Sucursal.nombre
	, Sucursal_abreviatura                      	VARCHAR(5) 		-- 3	Sucursal.abreviatura
	, TipoSucursal_4_id                         	VARCHAR(36)		-- 4	Sucursal.TipoSucursal.id
	, TipoSucursal_4_numero                     	INTEGER    		-- 5	Sucursal.TipoSucursal.numero
	, TipoSucursal_4_nombre                     	VARCHAR(50)		-- 6	Sucursal.TipoSucursal.nombre
	, Sucursal_cuentaClientesDesde              	VARCHAR(7) 		-- 7	Sucursal.cuentaClientesDesde
	, Sucursal_cuentaClientesHasta              	VARCHAR(7) 		-- 8	Sucursal.cuentaClientesHasta
	, Sucursal_cantidadCaracteresClientes       	INTEGER    		-- 9	Sucursal.cantidadCaracteresClientes
	, Sucursal_identificacionNumericaClientes   	BOOLEAN    		-- 10	Sucursal.identificacionNumericaClientes
	, Sucursal_permiteCambiarClientes           	BOOLEAN    		-- 11	Sucursal.permiteCambiarClientes
	, Sucursal_cuentaProveedoresDesde           	VARCHAR(6) 		-- 12	Sucursal.cuentaProveedoresDesde
	, Sucursal_cuentaProveedoresHasta           	VARCHAR(6) 		-- 13	Sucursal.cuentaProveedoresHasta
	, Sucursal_cantidadCaracteresProveedores    	INTEGER    		-- 14	Sucursal.cantidadCaracteresProveedores
	, Sucursal_identificacionNumericaProveedores	BOOLEAN    		-- 15	Sucursal.identificacionNumericaProveedores
	, Sucursal_permiteCambiarProveedores        	BOOLEAN    		-- 16	Sucursal.permiteCambiarProveedores
	, Sucursal_clientesOcacionalesDesde         	INTEGER    		-- 17	Sucursal.clientesOcacionalesDesde
	, Sucursal_clientesOcacionalesHasta         	INTEGER    		-- 18	Sucursal.clientesOcacionalesHasta
	, Sucursal_numeroCobranzaDesde              	INTEGER    		-- 19	Sucursal.numeroCobranzaDesde
	, Sucursal_numeroCobranzaHasta              	INTEGER    		-- 20	Sucursal.numeroCobranzaHasta

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Deposito                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Deposito



DROP TYPE IF EXISTS massoftware.t_Deposito_1 CASCADE;

CREATE TYPE massoftware.t_Deposito_1 AS (

	  Deposito_id                                 	VARCHAR(36)		-- 0	Deposito.id
	, Deposito_numero                             	INTEGER    		-- 1	Deposito.numero
	, Deposito_nombre                             	VARCHAR(50)		-- 2	Deposito.nombre
	, Deposito_abreviatura                        	VARCHAR(5) 		-- 3	Deposito.abreviatura
	, Sucursal_4_id                               	VARCHAR(36)		-- 4	Deposito.Sucursal.id
	, Sucursal_4_numero                           	INTEGER    		-- 5	Deposito.Sucursal.numero
	, Sucursal_4_nombre                           	VARCHAR(50)		-- 6	Deposito.Sucursal.nombre
	, Sucursal_4_abreviatura                      	VARCHAR(5) 		-- 7	Deposito.Sucursal.abreviatura
	, Sucursal_4_tipoSucursal                     	VARCHAR(36)		-- 8	Deposito.Sucursal.tipoSucursal
	, Sucursal_4_cuentaClientesDesde              	VARCHAR(7) 		-- 9	Deposito.Sucursal.cuentaClientesDesde
	, Sucursal_4_cuentaClientesHasta              	VARCHAR(7) 		-- 10	Deposito.Sucursal.cuentaClientesHasta
	, Sucursal_4_cantidadCaracteresClientes       	INTEGER    		-- 11	Deposito.Sucursal.cantidadCaracteresClientes
	, Sucursal_4_identificacionNumericaClientes   	BOOLEAN    		-- 12	Deposito.Sucursal.identificacionNumericaClientes
	, Sucursal_4_permiteCambiarClientes           	BOOLEAN    		-- 13	Deposito.Sucursal.permiteCambiarClientes
	, Sucursal_4_cuentaProveedoresDesde           	VARCHAR(6) 		-- 14	Deposito.Sucursal.cuentaProveedoresDesde
	, Sucursal_4_cuentaProveedoresHasta           	VARCHAR(6) 		-- 15	Deposito.Sucursal.cuentaProveedoresHasta
	, Sucursal_4_cantidadCaracteresProveedores    	INTEGER    		-- 16	Deposito.Sucursal.cantidadCaracteresProveedores
	, Sucursal_4_identificacionNumericaProveedores	BOOLEAN    		-- 17	Deposito.Sucursal.identificacionNumericaProveedores
	, Sucursal_4_permiteCambiarProveedores        	BOOLEAN    		-- 18	Deposito.Sucursal.permiteCambiarProveedores
	, Sucursal_4_clientesOcacionalesDesde         	INTEGER    		-- 19	Deposito.Sucursal.clientesOcacionalesDesde
	, Sucursal_4_clientesOcacionalesHasta         	INTEGER    		-- 20	Deposito.Sucursal.clientesOcacionalesHasta
	, Sucursal_4_numeroCobranzaDesde              	INTEGER    		-- 21	Deposito.Sucursal.numeroCobranzaDesde
	, Sucursal_4_numeroCobranzaHasta              	INTEGER    		-- 22	Deposito.Sucursal.numeroCobranzaHasta
	, DepositoModulo_23_id                        	VARCHAR(36)		-- 23	Deposito.DepositoModulo.id
	, DepositoModulo_23_numero                    	INTEGER    		-- 24	Deposito.DepositoModulo.numero
	, DepositoModulo_23_nombre                    	VARCHAR(50)		-- 25	Deposito.DepositoModulo.nombre
	, SeguridadPuerta_26_id                       	VARCHAR(36)		-- 26	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_26_numero                   	INTEGER    		-- 27	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_26_nombre                   	VARCHAR(50)		-- 28	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_26_equate                   	VARCHAR(30)		-- 29	Deposito.SeguridadPuerta.equate
	, SeguridadPuerta_26_seguridadModulo          	VARCHAR(36)		-- 30	Deposito.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_31_id                       	VARCHAR(36)		-- 31	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_31_numero                   	INTEGER    		-- 32	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_31_nombre                   	VARCHAR(50)		-- 33	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_31_equate                   	VARCHAR(30)		-- 34	Deposito.SeguridadPuerta.equate
	, SeguridadPuerta_31_seguridadModulo          	VARCHAR(36)		-- 35	Deposito.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_Deposito_2 CASCADE;

CREATE TYPE massoftware.t_Deposito_2 AS (

	  Deposito_id                                 	VARCHAR(36)		-- 0	Deposito.id
	, Deposito_numero                             	INTEGER    		-- 1	Deposito.numero
	, Deposito_nombre                             	VARCHAR(50)		-- 2	Deposito.nombre
	, Deposito_abreviatura                        	VARCHAR(5) 		-- 3	Deposito.abreviatura
	, Sucursal_4_id                               	VARCHAR(36)		-- 4	Deposito.Sucursal.id
	, Sucursal_4_numero                           	INTEGER    		-- 5	Deposito.Sucursal.numero
	, Sucursal_4_nombre                           	VARCHAR(50)		-- 6	Deposito.Sucursal.nombre
	, Sucursal_4_abreviatura                      	VARCHAR(5) 		-- 7	Deposito.Sucursal.abreviatura
	, TipoSucursal_8_id                           	VARCHAR(36)		-- 8	Deposito.Sucursal.TipoSucursal.id
	, TipoSucursal_8_numero                       	INTEGER    		-- 9	Deposito.Sucursal.TipoSucursal.numero
	, TipoSucursal_8_nombre                       	VARCHAR(50)		-- 10	Deposito.Sucursal.TipoSucursal.nombre
	, Sucursal_4_cuentaClientesDesde              	VARCHAR(7) 		-- 11	Deposito.Sucursal.cuentaClientesDesde
	, Sucursal_4_cuentaClientesHasta              	VARCHAR(7) 		-- 12	Deposito.Sucursal.cuentaClientesHasta
	, Sucursal_4_cantidadCaracteresClientes       	INTEGER    		-- 13	Deposito.Sucursal.cantidadCaracteresClientes
	, Sucursal_4_identificacionNumericaClientes   	BOOLEAN    		-- 14	Deposito.Sucursal.identificacionNumericaClientes
	, Sucursal_4_permiteCambiarClientes           	BOOLEAN    		-- 15	Deposito.Sucursal.permiteCambiarClientes
	, Sucursal_4_cuentaProveedoresDesde           	VARCHAR(6) 		-- 16	Deposito.Sucursal.cuentaProveedoresDesde
	, Sucursal_4_cuentaProveedoresHasta           	VARCHAR(6) 		-- 17	Deposito.Sucursal.cuentaProveedoresHasta
	, Sucursal_4_cantidadCaracteresProveedores    	INTEGER    		-- 18	Deposito.Sucursal.cantidadCaracteresProveedores
	, Sucursal_4_identificacionNumericaProveedores	BOOLEAN    		-- 19	Deposito.Sucursal.identificacionNumericaProveedores
	, Sucursal_4_permiteCambiarProveedores        	BOOLEAN    		-- 20	Deposito.Sucursal.permiteCambiarProveedores
	, Sucursal_4_clientesOcacionalesDesde         	INTEGER    		-- 21	Deposito.Sucursal.clientesOcacionalesDesde
	, Sucursal_4_clientesOcacionalesHasta         	INTEGER    		-- 22	Deposito.Sucursal.clientesOcacionalesHasta
	, Sucursal_4_numeroCobranzaDesde              	INTEGER    		-- 23	Deposito.Sucursal.numeroCobranzaDesde
	, Sucursal_4_numeroCobranzaHasta              	INTEGER    		-- 24	Deposito.Sucursal.numeroCobranzaHasta
	, DepositoModulo_25_id                        	VARCHAR(36)		-- 25	Deposito.DepositoModulo.id
	, DepositoModulo_25_numero                    	INTEGER    		-- 26	Deposito.DepositoModulo.numero
	, DepositoModulo_25_nombre                    	VARCHAR(50)		-- 27	Deposito.DepositoModulo.nombre
	, SeguridadPuerta_28_id                       	VARCHAR(36)		-- 28	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_28_numero                   	INTEGER    		-- 29	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_28_nombre                   	VARCHAR(50)		-- 30	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_28_equate                   	VARCHAR(30)		-- 31	Deposito.SeguridadPuerta.equate
	, SeguridadModulo_32_id                       	VARCHAR(36)		-- 32	Deposito.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_32_numero                   	INTEGER    		-- 33	Deposito.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_32_nombre                   	VARCHAR(50)		-- 34	Deposito.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_35_id                       	VARCHAR(36)		-- 35	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_35_numero                   	INTEGER    		-- 36	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_35_nombre                   	VARCHAR(50)		-- 37	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_35_equate                   	VARCHAR(30)		-- 38	Deposito.SeguridadPuerta.equate
	, SeguridadModulo_39_id                       	VARCHAR(36)		-- 39	Deposito.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_39_numero                   	INTEGER    		-- 40	Deposito.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_39_nombre                   	VARCHAR(50)		-- 41	Deposito.SeguridadPuerta.SeguridadModulo.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CentroCostoContable                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CentroCostoContable



DROP TYPE IF EXISTS massoftware.t_CentroCostoContable_1 CASCADE;

CREATE TYPE massoftware.t_CentroCostoContable_1 AS (

	  CentroCostoContable_id            	VARCHAR(36) 		-- 0	CentroCostoContable.id
	, CentroCostoContable_numero        	INTEGER     		-- 1	CentroCostoContable.numero
	, CentroCostoContable_nombre        	VARCHAR(50) 		-- 2	CentroCostoContable.nombre
	, CentroCostoContable_abreviatura   	VARCHAR(5)  		-- 3	CentroCostoContable.abreviatura
	, EjercicioContable_4_id            	VARCHAR(36) 		-- 4	CentroCostoContable.EjercicioContable.id
	, EjercicioContable_4_numero        	INTEGER     		-- 5	CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_4_apertura      	DATE        		-- 6	CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_4_cierre        	DATE        		-- 7	CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_4_cerrado       	BOOLEAN     		-- 8	CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_4_cerradoModulos	BOOLEAN     		-- 9	CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_4_comentario    	VARCHAR(250)		-- 10	CentroCostoContable.EjercicioContable.comentario

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: PuntoEquilibrio                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.PuntoEquilibrio



DROP TYPE IF EXISTS massoftware.t_PuntoEquilibrio_1 CASCADE;

CREATE TYPE massoftware.t_PuntoEquilibrio_1 AS (

	  PuntoEquilibrio_id                	VARCHAR(36) 		-- 0	PuntoEquilibrio.id
	, PuntoEquilibrio_numero            	INTEGER     		-- 1	PuntoEquilibrio.numero
	, PuntoEquilibrio_nombre            	VARCHAR(50) 		-- 2	PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_3_id          	VARCHAR(36) 		-- 3	PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_3_numero      	INTEGER     		-- 4	PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_3_nombre      	VARCHAR(50) 		-- 5	PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_6_id            	VARCHAR(36) 		-- 6	PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_6_numero        	INTEGER     		-- 7	PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_6_apertura      	DATE        		-- 8	PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_6_cierre        	DATE        		-- 9	PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_6_cerrado       	BOOLEAN     		-- 10	PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_6_cerradoModulos	BOOLEAN     		-- 11	PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_6_comentario    	VARCHAR(250)		-- 12	PuntoEquilibrio.EjercicioContable.comentario

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContable



DROP TYPE IF EXISTS massoftware.t_CuentaContable_1 CASCADE;

CREATE TYPE massoftware.t_CuentaContable_1 AS (

	  CuentaContable_id                       	VARCHAR(36) 		-- 0	CuentaContable.id
	, CuentaContable_codigo                   	VARCHAR(11) 		-- 1	CuentaContable.codigo
	, CuentaContable_nombre                   	VARCHAR(50) 		-- 2	CuentaContable.nombre
	, EjercicioContable_3_id                  	VARCHAR(36) 		-- 3	CuentaContable.EjercicioContable.id
	, EjercicioContable_3_numero              	INTEGER     		-- 4	CuentaContable.EjercicioContable.numero
	, EjercicioContable_3_apertura            	DATE        		-- 5	CuentaContable.EjercicioContable.apertura
	, EjercicioContable_3_cierre              	DATE        		-- 6	CuentaContable.EjercicioContable.cierre
	, EjercicioContable_3_cerrado             	BOOLEAN     		-- 7	CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_3_cerradoModulos      	BOOLEAN     		-- 8	CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_3_comentario          	VARCHAR(250)		-- 9	CuentaContable.EjercicioContable.comentario
	, CuentaContable_integra                  	VARCHAR(16) 		-- 10	CuentaContable.integra
	, CuentaContable_cuentaJerarquia          	VARCHAR(16) 		-- 11	CuentaContable.cuentaJerarquia
	, CuentaContable_imputable                	BOOLEAN     		-- 12	CuentaContable.imputable
	, CuentaContable_ajustaPorInflacion       	BOOLEAN     		-- 13	CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_14_id              	VARCHAR(36) 		-- 14	CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_14_numero          	INTEGER     		-- 15	CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_14_nombre          	VARCHAR(50) 		-- 16	CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_cuentaConApropiacion     	BOOLEAN     		-- 17	CuentaContable.cuentaConApropiacion
	, CentroCostoContable_18_id               	VARCHAR(36) 		-- 18	CuentaContable.CentroCostoContable.id
	, CentroCostoContable_18_numero           	INTEGER     		-- 19	CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_18_nombre           	VARCHAR(50) 		-- 20	CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_18_abreviatura      	VARCHAR(5)  		-- 21	CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_18_ejercicioContable	VARCHAR(36) 		-- 22	CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_cuentaAgrupadora         	VARCHAR(50) 		-- 23	CuentaContable.cuentaAgrupadora
	, CuentaContable_porcentaje               	DECIMAL(6,3)		-- 24	CuentaContable.porcentaje
	, PuntoEquilibrio_25_id                   	VARCHAR(36) 		-- 25	CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_25_numero               	INTEGER     		-- 26	CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_25_nombre               	VARCHAR(50) 		-- 27	CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_25_tipoPuntoEquilibrio  	VARCHAR(36) 		-- 28	CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_25_ejercicioContable    	VARCHAR(36) 		-- 29	CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_30_id                        	VARCHAR(36) 		-- 30	CuentaContable.CostoVenta.id
	, CostoVenta_30_numero                    	INTEGER     		-- 31	CuentaContable.CostoVenta.numero
	, CostoVenta_30_nombre                    	VARCHAR(50) 		-- 32	CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_33_id                   	VARCHAR(36) 		-- 33	CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_33_numero               	INTEGER     		-- 34	CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_33_nombre               	VARCHAR(50) 		-- 35	CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_33_equate               	VARCHAR(30) 		-- 36	CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_33_seguridadModulo      	VARCHAR(36) 		-- 37	CuentaContable.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_CuentaContable_2 CASCADE;

CREATE TYPE massoftware.t_CuentaContable_2 AS (

	  CuentaContable_id                  	VARCHAR(36) 		-- 0	CuentaContable.id
	, CuentaContable_codigo              	VARCHAR(11) 		-- 1	CuentaContable.codigo
	, CuentaContable_nombre              	VARCHAR(50) 		-- 2	CuentaContable.nombre
	, EjercicioContable_3_id             	VARCHAR(36) 		-- 3	CuentaContable.EjercicioContable.id
	, EjercicioContable_3_numero         	INTEGER     		-- 4	CuentaContable.EjercicioContable.numero
	, EjercicioContable_3_apertura       	DATE        		-- 5	CuentaContable.EjercicioContable.apertura
	, EjercicioContable_3_cierre         	DATE        		-- 6	CuentaContable.EjercicioContable.cierre
	, EjercicioContable_3_cerrado        	BOOLEAN     		-- 7	CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_3_cerradoModulos 	BOOLEAN     		-- 8	CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_3_comentario     	VARCHAR(250)		-- 9	CuentaContable.EjercicioContable.comentario
	, CuentaContable_integra             	VARCHAR(16) 		-- 10	CuentaContable.integra
	, CuentaContable_cuentaJerarquia     	VARCHAR(16) 		-- 11	CuentaContable.cuentaJerarquia
	, CuentaContable_imputable           	BOOLEAN     		-- 12	CuentaContable.imputable
	, CuentaContable_ajustaPorInflacion  	BOOLEAN     		-- 13	CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_14_id         	VARCHAR(36) 		-- 14	CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_14_numero     	INTEGER     		-- 15	CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_14_nombre     	VARCHAR(50) 		-- 16	CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_cuentaConApropiacion	BOOLEAN     		-- 17	CuentaContable.cuentaConApropiacion
	, CentroCostoContable_18_id          	VARCHAR(36) 		-- 18	CuentaContable.CentroCostoContable.id
	, CentroCostoContable_18_numero      	INTEGER     		-- 19	CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_18_nombre      	VARCHAR(50) 		-- 20	CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_18_abreviatura 	VARCHAR(5)  		-- 21	CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_22_id            	VARCHAR(36) 		-- 22	CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_22_numero        	INTEGER     		-- 23	CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_22_apertura      	DATE        		-- 24	CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_22_cierre        	DATE        		-- 25	CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_22_cerrado       	BOOLEAN     		-- 26	CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_22_cerradoModulos	BOOLEAN     		-- 27	CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_22_comentario    	VARCHAR(250)		-- 28	CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_cuentaAgrupadora    	VARCHAR(50) 		-- 29	CuentaContable.cuentaAgrupadora
	, CuentaContable_porcentaje          	DECIMAL(6,3)		-- 30	CuentaContable.porcentaje
	, PuntoEquilibrio_31_id              	VARCHAR(36) 		-- 31	CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_31_numero          	INTEGER     		-- 32	CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_31_nombre          	VARCHAR(50) 		-- 33	CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_34_id          	VARCHAR(36) 		-- 34	CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_34_numero      	INTEGER     		-- 35	CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_34_nombre      	VARCHAR(50) 		-- 36	CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_37_id            	VARCHAR(36) 		-- 37	CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_37_numero        	INTEGER     		-- 38	CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_37_apertura      	DATE        		-- 39	CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_37_cierre        	DATE        		-- 40	CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_37_cerrado       	BOOLEAN     		-- 41	CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_37_cerradoModulos	BOOLEAN     		-- 42	CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_37_comentario    	VARCHAR(250)		-- 43	CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_44_id                   	VARCHAR(36) 		-- 44	CuentaContable.CostoVenta.id
	, CostoVenta_44_numero               	INTEGER     		-- 45	CuentaContable.CostoVenta.numero
	, CostoVenta_44_nombre               	VARCHAR(50) 		-- 46	CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_47_id              	VARCHAR(36) 		-- 47	CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_47_numero          	INTEGER     		-- 48	CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_47_nombre          	VARCHAR(50) 		-- 49	CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_47_equate          	VARCHAR(30) 		-- 50	CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_51_id              	VARCHAR(36) 		-- 51	CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_51_numero          	INTEGER     		-- 52	CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_51_nombre          	VARCHAR(50) 		-- 53	CuentaContable.SeguridadPuerta.SeguridadModulo.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModelo                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModelo



DROP TYPE IF EXISTS massoftware.t_AsientoModelo_1 CASCADE;

CREATE TYPE massoftware.t_AsientoModelo_1 AS (

	  AsientoModelo_id                  	VARCHAR(36) 		-- 0	AsientoModelo.id
	, AsientoModelo_numero              	INTEGER     		-- 1	AsientoModelo.numero
	, AsientoModelo_nombre              	VARCHAR(50) 		-- 2	AsientoModelo.nombre
	, EjercicioContable_3_id            	VARCHAR(36) 		-- 3	AsientoModelo.EjercicioContable.id
	, EjercicioContable_3_numero        	INTEGER     		-- 4	AsientoModelo.EjercicioContable.numero
	, EjercicioContable_3_apertura      	DATE        		-- 5	AsientoModelo.EjercicioContable.apertura
	, EjercicioContable_3_cierre        	DATE        		-- 6	AsientoModelo.EjercicioContable.cierre
	, EjercicioContable_3_cerrado       	BOOLEAN     		-- 7	AsientoModelo.EjercicioContable.cerrado
	, EjercicioContable_3_cerradoModulos	BOOLEAN     		-- 8	AsientoModelo.EjercicioContable.cerradoModulos
	, EjercicioContable_3_comentario    	VARCHAR(250)		-- 9	AsientoModelo.EjercicioContable.comentario

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModeloItem                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModeloItem



DROP TYPE IF EXISTS massoftware.t_AsientoModeloItem_1 CASCADE;

CREATE TYPE massoftware.t_AsientoModeloItem_1 AS (

	  AsientoModeloItem_id                 	VARCHAR(36) 		-- 0	AsientoModeloItem.id
	, AsientoModeloItem_numero             	INTEGER     		-- 1	AsientoModeloItem.numero
	, AsientoModelo_2_id                   	VARCHAR(36) 		-- 2	AsientoModeloItem.AsientoModelo.id
	, AsientoModelo_2_numero               	INTEGER     		-- 3	AsientoModeloItem.AsientoModelo.numero
	, AsientoModelo_2_nombre               	VARCHAR(50) 		-- 4	AsientoModeloItem.AsientoModelo.nombre
	, AsientoModelo_2_ejercicioContable    	VARCHAR(36) 		-- 5	AsientoModeloItem.AsientoModelo.ejercicioContable
	, CuentaContable_6_id                  	VARCHAR(36) 		-- 6	AsientoModeloItem.CuentaContable.id
	, CuentaContable_6_codigo              	VARCHAR(11) 		-- 7	AsientoModeloItem.CuentaContable.codigo
	, CuentaContable_6_nombre              	VARCHAR(50) 		-- 8	AsientoModeloItem.CuentaContable.nombre
	, CuentaContable_6_ejercicioContable   	VARCHAR(36) 		-- 9	AsientoModeloItem.CuentaContable.ejercicioContable
	, CuentaContable_6_integra             	VARCHAR(16) 		-- 10	AsientoModeloItem.CuentaContable.integra
	, CuentaContable_6_cuentaJerarquia     	VARCHAR(16) 		-- 11	AsientoModeloItem.CuentaContable.cuentaJerarquia
	, CuentaContable_6_imputable           	BOOLEAN     		-- 12	AsientoModeloItem.CuentaContable.imputable
	, CuentaContable_6_ajustaPorInflacion  	BOOLEAN     		-- 13	AsientoModeloItem.CuentaContable.ajustaPorInflacion
	, CuentaContable_6_cuentaContableEstado	VARCHAR(36) 		-- 14	AsientoModeloItem.CuentaContable.cuentaContableEstado
	, CuentaContable_6_cuentaConApropiacion	BOOLEAN     		-- 15	AsientoModeloItem.CuentaContable.cuentaConApropiacion
	, CuentaContable_6_centroCostoContable 	VARCHAR(36) 		-- 16	AsientoModeloItem.CuentaContable.centroCostoContable
	, CuentaContable_6_cuentaAgrupadora    	VARCHAR(50) 		-- 17	AsientoModeloItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_6_porcentaje          	DECIMAL(6,3)		-- 18	AsientoModeloItem.CuentaContable.porcentaje
	, CuentaContable_6_puntoEquilibrio     	VARCHAR(36) 		-- 19	AsientoModeloItem.CuentaContable.puntoEquilibrio
	, CuentaContable_6_costoVenta          	VARCHAR(36) 		-- 20	AsientoModeloItem.CuentaContable.costoVenta
	, CuentaContable_6_seguridadPuerta     	VARCHAR(36) 		-- 21	AsientoModeloItem.CuentaContable.seguridadPuerta

);

DROP TYPE IF EXISTS massoftware.t_AsientoModeloItem_2 CASCADE;

CREATE TYPE massoftware.t_AsientoModeloItem_2 AS (

	  AsientoModeloItem_id                    	VARCHAR(36) 		-- 0	AsientoModeloItem.id
	, AsientoModeloItem_numero                	INTEGER     		-- 1	AsientoModeloItem.numero
	, AsientoModelo_2_id                      	VARCHAR(36) 		-- 2	AsientoModeloItem.AsientoModelo.id
	, AsientoModelo_2_numero                  	INTEGER     		-- 3	AsientoModeloItem.AsientoModelo.numero
	, AsientoModelo_2_nombre                  	VARCHAR(50) 		-- 4	AsientoModeloItem.AsientoModelo.nombre
	, EjercicioContable_5_id                  	VARCHAR(36) 		-- 5	AsientoModeloItem.AsientoModelo.EjercicioContable.id
	, EjercicioContable_5_numero              	INTEGER     		-- 6	AsientoModeloItem.AsientoModelo.EjercicioContable.numero
	, EjercicioContable_5_apertura            	DATE        		-- 7	AsientoModeloItem.AsientoModelo.EjercicioContable.apertura
	, EjercicioContable_5_cierre              	DATE        		-- 8	AsientoModeloItem.AsientoModelo.EjercicioContable.cierre
	, EjercicioContable_5_cerrado             	BOOLEAN     		-- 9	AsientoModeloItem.AsientoModelo.EjercicioContable.cerrado
	, EjercicioContable_5_cerradoModulos      	BOOLEAN     		-- 10	AsientoModeloItem.AsientoModelo.EjercicioContable.cerradoModulos
	, EjercicioContable_5_comentario          	VARCHAR(250)		-- 11	AsientoModeloItem.AsientoModelo.EjercicioContable.comentario
	, CuentaContable_12_id                    	VARCHAR(36) 		-- 12	AsientoModeloItem.CuentaContable.id
	, CuentaContable_12_codigo                	VARCHAR(11) 		-- 13	AsientoModeloItem.CuentaContable.codigo
	, CuentaContable_12_nombre                	VARCHAR(50) 		-- 14	AsientoModeloItem.CuentaContable.nombre
	, EjercicioContable_15_id                 	VARCHAR(36) 		-- 15	AsientoModeloItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_15_numero             	INTEGER     		-- 16	AsientoModeloItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_15_apertura           	DATE        		-- 17	AsientoModeloItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_15_cierre             	DATE        		-- 18	AsientoModeloItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_15_cerrado            	BOOLEAN     		-- 19	AsientoModeloItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_15_cerradoModulos     	BOOLEAN     		-- 20	AsientoModeloItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_15_comentario         	VARCHAR(250)		-- 21	AsientoModeloItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_12_integra               	VARCHAR(16) 		-- 22	AsientoModeloItem.CuentaContable.integra
	, CuentaContable_12_cuentaJerarquia       	VARCHAR(16) 		-- 23	AsientoModeloItem.CuentaContable.cuentaJerarquia
	, CuentaContable_12_imputable             	BOOLEAN     		-- 24	AsientoModeloItem.CuentaContable.imputable
	, CuentaContable_12_ajustaPorInflacion    	BOOLEAN     		-- 25	AsientoModeloItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_26_id              	VARCHAR(36) 		-- 26	AsientoModeloItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_26_numero          	INTEGER     		-- 27	AsientoModeloItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_26_nombre          	VARCHAR(50) 		-- 28	AsientoModeloItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_12_cuentaConApropiacion  	BOOLEAN     		-- 29	AsientoModeloItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_30_id               	VARCHAR(36) 		-- 30	AsientoModeloItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_30_numero           	INTEGER     		-- 31	AsientoModeloItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_30_nombre           	VARCHAR(50) 		-- 32	AsientoModeloItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_30_abreviatura      	VARCHAR(5)  		-- 33	AsientoModeloItem.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_30_ejercicioContable	VARCHAR(36) 		-- 34	AsientoModeloItem.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_12_cuentaAgrupadora      	VARCHAR(50) 		-- 35	AsientoModeloItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_12_porcentaje            	DECIMAL(6,3)		-- 36	AsientoModeloItem.CuentaContable.porcentaje
	, PuntoEquilibrio_37_id                   	VARCHAR(36) 		-- 37	AsientoModeloItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_37_numero               	INTEGER     		-- 38	AsientoModeloItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_37_nombre               	VARCHAR(50) 		-- 39	AsientoModeloItem.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_37_tipoPuntoEquilibrio  	VARCHAR(36) 		-- 40	AsientoModeloItem.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_37_ejercicioContable    	VARCHAR(36) 		-- 41	AsientoModeloItem.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_42_id                        	VARCHAR(36) 		-- 42	AsientoModeloItem.CuentaContable.CostoVenta.id
	, CostoVenta_42_numero                    	INTEGER     		-- 43	AsientoModeloItem.CuentaContable.CostoVenta.numero
	, CostoVenta_42_nombre                    	VARCHAR(50) 		-- 44	AsientoModeloItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_45_id                   	VARCHAR(36) 		-- 45	AsientoModeloItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_45_numero               	INTEGER     		-- 46	AsientoModeloItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_45_nombre               	VARCHAR(50) 		-- 47	AsientoModeloItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_45_equate               	VARCHAR(30) 		-- 48	AsientoModeloItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_45_seguridadModulo      	VARCHAR(36) 		-- 49	AsientoModeloItem.CuentaContable.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_AsientoModeloItem_3 CASCADE;

CREATE TYPE massoftware.t_AsientoModeloItem_3 AS (

	  AsientoModeloItem_id                  	VARCHAR(36) 		-- 0	AsientoModeloItem.id
	, AsientoModeloItem_numero              	INTEGER     		-- 1	AsientoModeloItem.numero
	, AsientoModelo_2_id                    	VARCHAR(36) 		-- 2	AsientoModeloItem.AsientoModelo.id
	, AsientoModelo_2_numero                	INTEGER     		-- 3	AsientoModeloItem.AsientoModelo.numero
	, AsientoModelo_2_nombre                	VARCHAR(50) 		-- 4	AsientoModeloItem.AsientoModelo.nombre
	, EjercicioContable_5_id                	VARCHAR(36) 		-- 5	AsientoModeloItem.AsientoModelo.EjercicioContable.id
	, EjercicioContable_5_numero            	INTEGER     		-- 6	AsientoModeloItem.AsientoModelo.EjercicioContable.numero
	, EjercicioContable_5_apertura          	DATE        		-- 7	AsientoModeloItem.AsientoModelo.EjercicioContable.apertura
	, EjercicioContable_5_cierre            	DATE        		-- 8	AsientoModeloItem.AsientoModelo.EjercicioContable.cierre
	, EjercicioContable_5_cerrado           	BOOLEAN     		-- 9	AsientoModeloItem.AsientoModelo.EjercicioContable.cerrado
	, EjercicioContable_5_cerradoModulos    	BOOLEAN     		-- 10	AsientoModeloItem.AsientoModelo.EjercicioContable.cerradoModulos
	, EjercicioContable_5_comentario        	VARCHAR(250)		-- 11	AsientoModeloItem.AsientoModelo.EjercicioContable.comentario
	, CuentaContable_12_id                  	VARCHAR(36) 		-- 12	AsientoModeloItem.CuentaContable.id
	, CuentaContable_12_codigo              	VARCHAR(11) 		-- 13	AsientoModeloItem.CuentaContable.codigo
	, CuentaContable_12_nombre              	VARCHAR(50) 		-- 14	AsientoModeloItem.CuentaContable.nombre
	, EjercicioContable_15_id               	VARCHAR(36) 		-- 15	AsientoModeloItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_15_numero           	INTEGER     		-- 16	AsientoModeloItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_15_apertura         	DATE        		-- 17	AsientoModeloItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_15_cierre           	DATE        		-- 18	AsientoModeloItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_15_cerrado          	BOOLEAN     		-- 19	AsientoModeloItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_15_cerradoModulos   	BOOLEAN     		-- 20	AsientoModeloItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_15_comentario       	VARCHAR(250)		-- 21	AsientoModeloItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_12_integra             	VARCHAR(16) 		-- 22	AsientoModeloItem.CuentaContable.integra
	, CuentaContable_12_cuentaJerarquia     	VARCHAR(16) 		-- 23	AsientoModeloItem.CuentaContable.cuentaJerarquia
	, CuentaContable_12_imputable           	BOOLEAN     		-- 24	AsientoModeloItem.CuentaContable.imputable
	, CuentaContable_12_ajustaPorInflacion  	BOOLEAN     		-- 25	AsientoModeloItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_26_id            	VARCHAR(36) 		-- 26	AsientoModeloItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_26_numero        	INTEGER     		-- 27	AsientoModeloItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_26_nombre        	VARCHAR(50) 		-- 28	AsientoModeloItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_12_cuentaConApropiacion	BOOLEAN     		-- 29	AsientoModeloItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_30_id             	VARCHAR(36) 		-- 30	AsientoModeloItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_30_numero         	INTEGER     		-- 31	AsientoModeloItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_30_nombre         	VARCHAR(50) 		-- 32	AsientoModeloItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_30_abreviatura    	VARCHAR(5)  		-- 33	AsientoModeloItem.CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_34_id               	VARCHAR(36) 		-- 34	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_34_numero           	INTEGER     		-- 35	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_34_apertura         	DATE        		-- 36	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_34_cierre           	DATE        		-- 37	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_34_cerrado          	BOOLEAN     		-- 38	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_34_cerradoModulos   	BOOLEAN     		-- 39	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_34_comentario       	VARCHAR(250)		-- 40	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_12_cuentaAgrupadora    	VARCHAR(50) 		-- 41	AsientoModeloItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_12_porcentaje          	DECIMAL(6,3)		-- 42	AsientoModeloItem.CuentaContable.porcentaje
	, PuntoEquilibrio_43_id                 	VARCHAR(36) 		-- 43	AsientoModeloItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_43_numero             	INTEGER     		-- 44	AsientoModeloItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_43_nombre             	VARCHAR(50) 		-- 45	AsientoModeloItem.CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_46_id             	VARCHAR(36) 		-- 46	AsientoModeloItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_46_numero         	INTEGER     		-- 47	AsientoModeloItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_46_nombre         	VARCHAR(50) 		-- 48	AsientoModeloItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_49_id               	VARCHAR(36) 		-- 49	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_49_numero           	INTEGER     		-- 50	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_49_apertura         	DATE        		-- 51	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_49_cierre           	DATE        		-- 52	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_49_cerrado          	BOOLEAN     		-- 53	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_49_cerradoModulos   	BOOLEAN     		-- 54	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_49_comentario       	VARCHAR(250)		-- 55	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_56_id                      	VARCHAR(36) 		-- 56	AsientoModeloItem.CuentaContable.CostoVenta.id
	, CostoVenta_56_numero                  	INTEGER     		-- 57	AsientoModeloItem.CuentaContable.CostoVenta.numero
	, CostoVenta_56_nombre                  	VARCHAR(50) 		-- 58	AsientoModeloItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_59_id                 	VARCHAR(36) 		-- 59	AsientoModeloItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_59_numero             	INTEGER     		-- 60	AsientoModeloItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_59_nombre             	VARCHAR(50) 		-- 61	AsientoModeloItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_59_equate             	VARCHAR(30) 		-- 62	AsientoModeloItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_63_id                 	VARCHAR(36) 		-- 63	AsientoModeloItem.CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_63_numero             	INTEGER     		-- 64	AsientoModeloItem.CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_63_nombre             	VARCHAR(50) 		-- 65	AsientoModeloItem.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContable                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContable



DROP TYPE IF EXISTS massoftware.t_AsientoContable_1 CASCADE;

CREATE TYPE massoftware.t_AsientoContable_1 AS (

	  AsientoContable_id                           	VARCHAR(36) 		-- 0	AsientoContable.id
	, AsientoContable_numero                       	INTEGER     		-- 1	AsientoContable.numero
	, AsientoContable_fecha                        	DATE        		-- 2	AsientoContable.fecha
	, AsientoContable_detalle                      	VARCHAR(100)		-- 3	AsientoContable.detalle
	, EjercicioContable_4_id                       	VARCHAR(36) 		-- 4	AsientoContable.EjercicioContable.id
	, EjercicioContable_4_numero                   	INTEGER     		-- 5	AsientoContable.EjercicioContable.numero
	, EjercicioContable_4_apertura                 	DATE        		-- 6	AsientoContable.EjercicioContable.apertura
	, EjercicioContable_4_cierre                   	DATE        		-- 7	AsientoContable.EjercicioContable.cierre
	, EjercicioContable_4_cerrado                  	BOOLEAN     		-- 8	AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_4_cerradoModulos           	BOOLEAN     		-- 9	AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_4_comentario               	VARCHAR(250)		-- 10	AsientoContable.EjercicioContable.comentario
	, MinutaContable_11_id                         	VARCHAR(36) 		-- 11	AsientoContable.MinutaContable.id
	, MinutaContable_11_numero                     	INTEGER     		-- 12	AsientoContable.MinutaContable.numero
	, MinutaContable_11_nombre                     	VARCHAR(50) 		-- 13	AsientoContable.MinutaContable.nombre
	, Sucursal_14_id                               	VARCHAR(36) 		-- 14	AsientoContable.Sucursal.id
	, Sucursal_14_numero                           	INTEGER     		-- 15	AsientoContable.Sucursal.numero
	, Sucursal_14_nombre                           	VARCHAR(50) 		-- 16	AsientoContable.Sucursal.nombre
	, Sucursal_14_abreviatura                      	VARCHAR(5)  		-- 17	AsientoContable.Sucursal.abreviatura
	, Sucursal_14_tipoSucursal                     	VARCHAR(36) 		-- 18	AsientoContable.Sucursal.tipoSucursal
	, Sucursal_14_cuentaClientesDesde              	VARCHAR(7)  		-- 19	AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_14_cuentaClientesHasta              	VARCHAR(7)  		-- 20	AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_14_cantidadCaracteresClientes       	INTEGER     		-- 21	AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_14_identificacionNumericaClientes   	BOOLEAN     		-- 22	AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_14_permiteCambiarClientes           	BOOLEAN     		-- 23	AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_14_cuentaProveedoresDesde           	VARCHAR(6)  		-- 24	AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_14_cuentaProveedoresHasta           	VARCHAR(6)  		-- 25	AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_14_cantidadCaracteresProveedores    	INTEGER     		-- 26	AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_14_identificacionNumericaProveedores	BOOLEAN     		-- 27	AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_14_permiteCambiarProveedores        	BOOLEAN     		-- 28	AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_14_clientesOcacionalesDesde         	INTEGER     		-- 29	AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_14_clientesOcacionalesHasta         	INTEGER     		-- 30	AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_14_numeroCobranzaDesde              	INTEGER     		-- 31	AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_14_numeroCobranzaHasta              	INTEGER     		-- 32	AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_33_id                  	VARCHAR(36) 		-- 33	AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_33_numero              	INTEGER     		-- 34	AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_33_nombre              	VARCHAR(50) 		-- 35	AsientoContable.AsientoContableModulo.nombre

);

DROP TYPE IF EXISTS massoftware.t_AsientoContable_2 CASCADE;

CREATE TYPE massoftware.t_AsientoContable_2 AS (

	  AsientoContable_id                           	VARCHAR(36) 		-- 0	AsientoContable.id
	, AsientoContable_numero                       	INTEGER     		-- 1	AsientoContable.numero
	, AsientoContable_fecha                        	DATE        		-- 2	AsientoContable.fecha
	, AsientoContable_detalle                      	VARCHAR(100)		-- 3	AsientoContable.detalle
	, EjercicioContable_4_id                       	VARCHAR(36) 		-- 4	AsientoContable.EjercicioContable.id
	, EjercicioContable_4_numero                   	INTEGER     		-- 5	AsientoContable.EjercicioContable.numero
	, EjercicioContable_4_apertura                 	DATE        		-- 6	AsientoContable.EjercicioContable.apertura
	, EjercicioContable_4_cierre                   	DATE        		-- 7	AsientoContable.EjercicioContable.cierre
	, EjercicioContable_4_cerrado                  	BOOLEAN     		-- 8	AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_4_cerradoModulos           	BOOLEAN     		-- 9	AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_4_comentario               	VARCHAR(250)		-- 10	AsientoContable.EjercicioContable.comentario
	, MinutaContable_11_id                         	VARCHAR(36) 		-- 11	AsientoContable.MinutaContable.id
	, MinutaContable_11_numero                     	INTEGER     		-- 12	AsientoContable.MinutaContable.numero
	, MinutaContable_11_nombre                     	VARCHAR(50) 		-- 13	AsientoContable.MinutaContable.nombre
	, Sucursal_14_id                               	VARCHAR(36) 		-- 14	AsientoContable.Sucursal.id
	, Sucursal_14_numero                           	INTEGER     		-- 15	AsientoContable.Sucursal.numero
	, Sucursal_14_nombre                           	VARCHAR(50) 		-- 16	AsientoContable.Sucursal.nombre
	, Sucursal_14_abreviatura                      	VARCHAR(5)  		-- 17	AsientoContable.Sucursal.abreviatura
	, TipoSucursal_18_id                           	VARCHAR(36) 		-- 18	AsientoContable.Sucursal.TipoSucursal.id
	, TipoSucursal_18_numero                       	INTEGER     		-- 19	AsientoContable.Sucursal.TipoSucursal.numero
	, TipoSucursal_18_nombre                       	VARCHAR(50) 		-- 20	AsientoContable.Sucursal.TipoSucursal.nombre
	, Sucursal_14_cuentaClientesDesde              	VARCHAR(7)  		-- 21	AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_14_cuentaClientesHasta              	VARCHAR(7)  		-- 22	AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_14_cantidadCaracteresClientes       	INTEGER     		-- 23	AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_14_identificacionNumericaClientes   	BOOLEAN     		-- 24	AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_14_permiteCambiarClientes           	BOOLEAN     		-- 25	AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_14_cuentaProveedoresDesde           	VARCHAR(6)  		-- 26	AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_14_cuentaProveedoresHasta           	VARCHAR(6)  		-- 27	AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_14_cantidadCaracteresProveedores    	INTEGER     		-- 28	AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_14_identificacionNumericaProveedores	BOOLEAN     		-- 29	AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_14_permiteCambiarProveedores        	BOOLEAN     		-- 30	AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_14_clientesOcacionalesDesde         	INTEGER     		-- 31	AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_14_clientesOcacionalesHasta         	INTEGER     		-- 32	AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_14_numeroCobranzaDesde              	INTEGER     		-- 33	AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_14_numeroCobranzaHasta              	INTEGER     		-- 34	AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_35_id                  	VARCHAR(36) 		-- 35	AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_35_numero              	INTEGER     		-- 36	AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_35_nombre              	VARCHAR(50) 		-- 37	AsientoContable.AsientoContableModulo.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableItem                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableItem



DROP TYPE IF EXISTS massoftware.t_AsientoContableItem_1 CASCADE;

CREATE TYPE massoftware.t_AsientoContableItem_1 AS (

	  AsientoContableItem_id                 	VARCHAR(36)  		-- 0	AsientoContableItem.id
	, AsientoContableItem_numero             	INTEGER      		-- 1	AsientoContableItem.numero
	, AsientoContableItem_fecha              	DATE         		-- 2	AsientoContableItem.fecha
	, AsientoContableItem_detalle            	VARCHAR(100) 		-- 3	AsientoContableItem.detalle
	, AsientoContable_4_id                   	VARCHAR(36)  		-- 4	AsientoContableItem.AsientoContable.id
	, AsientoContable_4_numero               	INTEGER      		-- 5	AsientoContableItem.AsientoContable.numero
	, AsientoContable_4_fecha                	DATE         		-- 6	AsientoContableItem.AsientoContable.fecha
	, AsientoContable_4_detalle              	VARCHAR(100) 		-- 7	AsientoContableItem.AsientoContable.detalle
	, AsientoContable_4_ejercicioContable    	VARCHAR(36)  		-- 8	AsientoContableItem.AsientoContable.ejercicioContable
	, AsientoContable_4_minutaContable       	VARCHAR(36)  		-- 9	AsientoContableItem.AsientoContable.minutaContable
	, AsientoContable_4_sucursal             	VARCHAR(36)  		-- 10	AsientoContableItem.AsientoContable.sucursal
	, AsientoContable_4_asientoContableModulo	VARCHAR(36)  		-- 11	AsientoContableItem.AsientoContable.asientoContableModulo
	, CuentaContable_12_id                   	VARCHAR(36)  		-- 12	AsientoContableItem.CuentaContable.id
	, CuentaContable_12_codigo               	VARCHAR(11)  		-- 13	AsientoContableItem.CuentaContable.codigo
	, CuentaContable_12_nombre               	VARCHAR(50)  		-- 14	AsientoContableItem.CuentaContable.nombre
	, CuentaContable_12_ejercicioContable    	VARCHAR(36)  		-- 15	AsientoContableItem.CuentaContable.ejercicioContable
	, CuentaContable_12_integra              	VARCHAR(16)  		-- 16	AsientoContableItem.CuentaContable.integra
	, CuentaContable_12_cuentaJerarquia      	VARCHAR(16)  		-- 17	AsientoContableItem.CuentaContable.cuentaJerarquia
	, CuentaContable_12_imputable            	BOOLEAN      		-- 18	AsientoContableItem.CuentaContable.imputable
	, CuentaContable_12_ajustaPorInflacion   	BOOLEAN      		-- 19	AsientoContableItem.CuentaContable.ajustaPorInflacion
	, CuentaContable_12_cuentaContableEstado 	VARCHAR(36)  		-- 20	AsientoContableItem.CuentaContable.cuentaContableEstado
	, CuentaContable_12_cuentaConApropiacion 	BOOLEAN      		-- 21	AsientoContableItem.CuentaContable.cuentaConApropiacion
	, CuentaContable_12_centroCostoContable  	VARCHAR(36)  		-- 22	AsientoContableItem.CuentaContable.centroCostoContable
	, CuentaContable_12_cuentaAgrupadora     	VARCHAR(50)  		-- 23	AsientoContableItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_12_porcentaje           	DECIMAL(6,3) 		-- 24	AsientoContableItem.CuentaContable.porcentaje
	, CuentaContable_12_puntoEquilibrio      	VARCHAR(36)  		-- 25	AsientoContableItem.CuentaContable.puntoEquilibrio
	, CuentaContable_12_costoVenta           	VARCHAR(36)  		-- 26	AsientoContableItem.CuentaContable.costoVenta
	, CuentaContable_12_seguridadPuerta      	VARCHAR(36)  		-- 27	AsientoContableItem.CuentaContable.seguridadPuerta
	, AsientoContableItem_debe               	DECIMAL(13,5)		-- 28	AsientoContableItem.debe
	, AsientoContableItem_haber              	DECIMAL(13,5)		-- 29	AsientoContableItem.haber

);

DROP TYPE IF EXISTS massoftware.t_AsientoContableItem_2 CASCADE;

CREATE TYPE massoftware.t_AsientoContableItem_2 AS (

	  AsientoContableItem_id                       	VARCHAR(36)  		-- 0	AsientoContableItem.id
	, AsientoContableItem_numero                   	INTEGER      		-- 1	AsientoContableItem.numero
	, AsientoContableItem_fecha                    	DATE         		-- 2	AsientoContableItem.fecha
	, AsientoContableItem_detalle                  	VARCHAR(100) 		-- 3	AsientoContableItem.detalle
	, AsientoContable_4_id                         	VARCHAR(36)  		-- 4	AsientoContableItem.AsientoContable.id
	, AsientoContable_4_numero                     	INTEGER      		-- 5	AsientoContableItem.AsientoContable.numero
	, AsientoContable_4_fecha                      	DATE         		-- 6	AsientoContableItem.AsientoContable.fecha
	, AsientoContable_4_detalle                    	VARCHAR(100) 		-- 7	AsientoContableItem.AsientoContable.detalle
	, EjercicioContable_8_id                       	VARCHAR(36)  		-- 8	AsientoContableItem.AsientoContable.EjercicioContable.id
	, EjercicioContable_8_numero                   	INTEGER      		-- 9	AsientoContableItem.AsientoContable.EjercicioContable.numero
	, EjercicioContable_8_apertura                 	DATE         		-- 10	AsientoContableItem.AsientoContable.EjercicioContable.apertura
	, EjercicioContable_8_cierre                   	DATE         		-- 11	AsientoContableItem.AsientoContable.EjercicioContable.cierre
	, EjercicioContable_8_cerrado                  	BOOLEAN      		-- 12	AsientoContableItem.AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_8_cerradoModulos           	BOOLEAN      		-- 13	AsientoContableItem.AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_8_comentario               	VARCHAR(250) 		-- 14	AsientoContableItem.AsientoContable.EjercicioContable.comentario
	, MinutaContable_15_id                         	VARCHAR(36)  		-- 15	AsientoContableItem.AsientoContable.MinutaContable.id
	, MinutaContable_15_numero                     	INTEGER      		-- 16	AsientoContableItem.AsientoContable.MinutaContable.numero
	, MinutaContable_15_nombre                     	VARCHAR(50)  		-- 17	AsientoContableItem.AsientoContable.MinutaContable.nombre
	, Sucursal_18_id                               	VARCHAR(36)  		-- 18	AsientoContableItem.AsientoContable.Sucursal.id
	, Sucursal_18_numero                           	INTEGER      		-- 19	AsientoContableItem.AsientoContable.Sucursal.numero
	, Sucursal_18_nombre                           	VARCHAR(50)  		-- 20	AsientoContableItem.AsientoContable.Sucursal.nombre
	, Sucursal_18_abreviatura                      	VARCHAR(5)   		-- 21	AsientoContableItem.AsientoContable.Sucursal.abreviatura
	, Sucursal_18_tipoSucursal                     	VARCHAR(36)  		-- 22	AsientoContableItem.AsientoContable.Sucursal.tipoSucursal
	, Sucursal_18_cuentaClientesDesde              	VARCHAR(7)   		-- 23	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_18_cuentaClientesHasta              	VARCHAR(7)   		-- 24	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_18_cantidadCaracteresClientes       	INTEGER      		-- 25	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_18_identificacionNumericaClientes   	BOOLEAN      		-- 26	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_18_permiteCambiarClientes           	BOOLEAN      		-- 27	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_18_cuentaProveedoresDesde           	VARCHAR(6)   		-- 28	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_18_cuentaProveedoresHasta           	VARCHAR(6)   		-- 29	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_18_cantidadCaracteresProveedores    	INTEGER      		-- 30	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_18_identificacionNumericaProveedores	BOOLEAN      		-- 31	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_18_permiteCambiarProveedores        	BOOLEAN      		-- 32	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_18_clientesOcacionalesDesde         	INTEGER      		-- 33	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_18_clientesOcacionalesHasta         	INTEGER      		-- 34	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_18_numeroCobranzaDesde              	INTEGER      		-- 35	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_18_numeroCobranzaHasta              	INTEGER      		-- 36	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_37_id                  	VARCHAR(36)  		-- 37	AsientoContableItem.AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_37_numero              	INTEGER      		-- 38	AsientoContableItem.AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_37_nombre              	VARCHAR(50)  		-- 39	AsientoContableItem.AsientoContable.AsientoContableModulo.nombre
	, CuentaContable_40_id                         	VARCHAR(36)  		-- 40	AsientoContableItem.CuentaContable.id
	, CuentaContable_40_codigo                     	VARCHAR(11)  		-- 41	AsientoContableItem.CuentaContable.codigo
	, CuentaContable_40_nombre                     	VARCHAR(50)  		-- 42	AsientoContableItem.CuentaContable.nombre
	, EjercicioContable_43_id                      	VARCHAR(36)  		-- 43	AsientoContableItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_43_numero                  	INTEGER      		-- 44	AsientoContableItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_43_apertura                	DATE         		-- 45	AsientoContableItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_43_cierre                  	DATE         		-- 46	AsientoContableItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_43_cerrado                 	BOOLEAN      		-- 47	AsientoContableItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_43_cerradoModulos          	BOOLEAN      		-- 48	AsientoContableItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_43_comentario              	VARCHAR(250) 		-- 49	AsientoContableItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_40_integra                    	VARCHAR(16)  		-- 50	AsientoContableItem.CuentaContable.integra
	, CuentaContable_40_cuentaJerarquia            	VARCHAR(16)  		-- 51	AsientoContableItem.CuentaContable.cuentaJerarquia
	, CuentaContable_40_imputable                  	BOOLEAN      		-- 52	AsientoContableItem.CuentaContable.imputable
	, CuentaContable_40_ajustaPorInflacion         	BOOLEAN      		-- 53	AsientoContableItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_54_id                   	VARCHAR(36)  		-- 54	AsientoContableItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_54_numero               	INTEGER      		-- 55	AsientoContableItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_54_nombre               	VARCHAR(50)  		-- 56	AsientoContableItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_40_cuentaConApropiacion       	BOOLEAN      		-- 57	AsientoContableItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_58_id                    	VARCHAR(36)  		-- 58	AsientoContableItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_58_numero                	INTEGER      		-- 59	AsientoContableItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_58_nombre                	VARCHAR(50)  		-- 60	AsientoContableItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_58_abreviatura           	VARCHAR(5)   		-- 61	AsientoContableItem.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_58_ejercicioContable     	VARCHAR(36)  		-- 62	AsientoContableItem.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_40_cuentaAgrupadora           	VARCHAR(50)  		-- 63	AsientoContableItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_40_porcentaje                 	DECIMAL(6,3) 		-- 64	AsientoContableItem.CuentaContable.porcentaje
	, PuntoEquilibrio_65_id                        	VARCHAR(36)  		-- 65	AsientoContableItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_65_numero                    	INTEGER      		-- 66	AsientoContableItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_65_nombre                    	VARCHAR(50)  		-- 67	AsientoContableItem.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_65_tipoPuntoEquilibrio       	VARCHAR(36)  		-- 68	AsientoContableItem.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_65_ejercicioContable         	VARCHAR(36)  		-- 69	AsientoContableItem.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_70_id                             	VARCHAR(36)  		-- 70	AsientoContableItem.CuentaContable.CostoVenta.id
	, CostoVenta_70_numero                         	INTEGER      		-- 71	AsientoContableItem.CuentaContable.CostoVenta.numero
	, CostoVenta_70_nombre                         	VARCHAR(50)  		-- 72	AsientoContableItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_73_id                        	VARCHAR(36)  		-- 73	AsientoContableItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_73_numero                    	INTEGER      		-- 74	AsientoContableItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_73_nombre                    	VARCHAR(50)  		-- 75	AsientoContableItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_73_equate                    	VARCHAR(30)  		-- 76	AsientoContableItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_73_seguridadModulo           	VARCHAR(36)  		-- 77	AsientoContableItem.CuentaContable.SeguridadPuerta.seguridadModulo
	, AsientoContableItem_debe                     	DECIMAL(13,5)		-- 78	AsientoContableItem.debe
	, AsientoContableItem_haber                    	DECIMAL(13,5)		-- 79	AsientoContableItem.haber

);

DROP TYPE IF EXISTS massoftware.t_AsientoContableItem_3 CASCADE;

CREATE TYPE massoftware.t_AsientoContableItem_3 AS (

	  AsientoContableItem_id                       	VARCHAR(36)  		-- 0	AsientoContableItem.id
	, AsientoContableItem_numero                   	INTEGER      		-- 1	AsientoContableItem.numero
	, AsientoContableItem_fecha                    	DATE         		-- 2	AsientoContableItem.fecha
	, AsientoContableItem_detalle                  	VARCHAR(100) 		-- 3	AsientoContableItem.detalle
	, AsientoContable_4_id                         	VARCHAR(36)  		-- 4	AsientoContableItem.AsientoContable.id
	, AsientoContable_4_numero                     	INTEGER      		-- 5	AsientoContableItem.AsientoContable.numero
	, AsientoContable_4_fecha                      	DATE         		-- 6	AsientoContableItem.AsientoContable.fecha
	, AsientoContable_4_detalle                    	VARCHAR(100) 		-- 7	AsientoContableItem.AsientoContable.detalle
	, EjercicioContable_8_id                       	VARCHAR(36)  		-- 8	AsientoContableItem.AsientoContable.EjercicioContable.id
	, EjercicioContable_8_numero                   	INTEGER      		-- 9	AsientoContableItem.AsientoContable.EjercicioContable.numero
	, EjercicioContable_8_apertura                 	DATE         		-- 10	AsientoContableItem.AsientoContable.EjercicioContable.apertura
	, EjercicioContable_8_cierre                   	DATE         		-- 11	AsientoContableItem.AsientoContable.EjercicioContable.cierre
	, EjercicioContable_8_cerrado                  	BOOLEAN      		-- 12	AsientoContableItem.AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_8_cerradoModulos           	BOOLEAN      		-- 13	AsientoContableItem.AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_8_comentario               	VARCHAR(250) 		-- 14	AsientoContableItem.AsientoContable.EjercicioContable.comentario
	, MinutaContable_15_id                         	VARCHAR(36)  		-- 15	AsientoContableItem.AsientoContable.MinutaContable.id
	, MinutaContable_15_numero                     	INTEGER      		-- 16	AsientoContableItem.AsientoContable.MinutaContable.numero
	, MinutaContable_15_nombre                     	VARCHAR(50)  		-- 17	AsientoContableItem.AsientoContable.MinutaContable.nombre
	, Sucursal_18_id                               	VARCHAR(36)  		-- 18	AsientoContableItem.AsientoContable.Sucursal.id
	, Sucursal_18_numero                           	INTEGER      		-- 19	AsientoContableItem.AsientoContable.Sucursal.numero
	, Sucursal_18_nombre                           	VARCHAR(50)  		-- 20	AsientoContableItem.AsientoContable.Sucursal.nombre
	, Sucursal_18_abreviatura                      	VARCHAR(5)   		-- 21	AsientoContableItem.AsientoContable.Sucursal.abreviatura
	, TipoSucursal_22_id                           	VARCHAR(36)  		-- 22	AsientoContableItem.AsientoContable.Sucursal.TipoSucursal.id
	, TipoSucursal_22_numero                       	INTEGER      		-- 23	AsientoContableItem.AsientoContable.Sucursal.TipoSucursal.numero
	, TipoSucursal_22_nombre                       	VARCHAR(50)  		-- 24	AsientoContableItem.AsientoContable.Sucursal.TipoSucursal.nombre
	, Sucursal_18_cuentaClientesDesde              	VARCHAR(7)   		-- 25	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_18_cuentaClientesHasta              	VARCHAR(7)   		-- 26	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_18_cantidadCaracteresClientes       	INTEGER      		-- 27	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_18_identificacionNumericaClientes   	BOOLEAN      		-- 28	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_18_permiteCambiarClientes           	BOOLEAN      		-- 29	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_18_cuentaProveedoresDesde           	VARCHAR(6)   		-- 30	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_18_cuentaProveedoresHasta           	VARCHAR(6)   		-- 31	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_18_cantidadCaracteresProveedores    	INTEGER      		-- 32	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_18_identificacionNumericaProveedores	BOOLEAN      		-- 33	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_18_permiteCambiarProveedores        	BOOLEAN      		-- 34	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_18_clientesOcacionalesDesde         	INTEGER      		-- 35	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_18_clientesOcacionalesHasta         	INTEGER      		-- 36	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_18_numeroCobranzaDesde              	INTEGER      		-- 37	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_18_numeroCobranzaHasta              	INTEGER      		-- 38	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_39_id                  	VARCHAR(36)  		-- 39	AsientoContableItem.AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_39_numero              	INTEGER      		-- 40	AsientoContableItem.AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_39_nombre              	VARCHAR(50)  		-- 41	AsientoContableItem.AsientoContable.AsientoContableModulo.nombre
	, CuentaContable_42_id                         	VARCHAR(36)  		-- 42	AsientoContableItem.CuentaContable.id
	, CuentaContable_42_codigo                     	VARCHAR(11)  		-- 43	AsientoContableItem.CuentaContable.codigo
	, CuentaContable_42_nombre                     	VARCHAR(50)  		-- 44	AsientoContableItem.CuentaContable.nombre
	, EjercicioContable_45_id                      	VARCHAR(36)  		-- 45	AsientoContableItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_45_numero                  	INTEGER      		-- 46	AsientoContableItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_45_apertura                	DATE         		-- 47	AsientoContableItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_45_cierre                  	DATE         		-- 48	AsientoContableItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_45_cerrado                 	BOOLEAN      		-- 49	AsientoContableItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_45_cerradoModulos          	BOOLEAN      		-- 50	AsientoContableItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_45_comentario              	VARCHAR(250) 		-- 51	AsientoContableItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_42_integra                    	VARCHAR(16)  		-- 52	AsientoContableItem.CuentaContable.integra
	, CuentaContable_42_cuentaJerarquia            	VARCHAR(16)  		-- 53	AsientoContableItem.CuentaContable.cuentaJerarquia
	, CuentaContable_42_imputable                  	BOOLEAN      		-- 54	AsientoContableItem.CuentaContable.imputable
	, CuentaContable_42_ajustaPorInflacion         	BOOLEAN      		-- 55	AsientoContableItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_56_id                   	VARCHAR(36)  		-- 56	AsientoContableItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_56_numero               	INTEGER      		-- 57	AsientoContableItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_56_nombre               	VARCHAR(50)  		-- 58	AsientoContableItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_42_cuentaConApropiacion       	BOOLEAN      		-- 59	AsientoContableItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_60_id                    	VARCHAR(36)  		-- 60	AsientoContableItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_60_numero                	INTEGER      		-- 61	AsientoContableItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_60_nombre                	VARCHAR(50)  		-- 62	AsientoContableItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_60_abreviatura           	VARCHAR(5)   		-- 63	AsientoContableItem.CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_64_id                      	VARCHAR(36)  		-- 64	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_64_numero                  	INTEGER      		-- 65	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_64_apertura                	DATE         		-- 66	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_64_cierre                  	DATE         		-- 67	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_64_cerrado                 	BOOLEAN      		-- 68	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_64_cerradoModulos          	BOOLEAN      		-- 69	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_64_comentario              	VARCHAR(250) 		-- 70	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_42_cuentaAgrupadora           	VARCHAR(50)  		-- 71	AsientoContableItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_42_porcentaje                 	DECIMAL(6,3) 		-- 72	AsientoContableItem.CuentaContable.porcentaje
	, PuntoEquilibrio_73_id                        	VARCHAR(36)  		-- 73	AsientoContableItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_73_numero                    	INTEGER      		-- 74	AsientoContableItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_73_nombre                    	VARCHAR(50)  		-- 75	AsientoContableItem.CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_76_id                    	VARCHAR(36)  		-- 76	AsientoContableItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_76_numero                	INTEGER      		-- 77	AsientoContableItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_76_nombre                	VARCHAR(50)  		-- 78	AsientoContableItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_79_id                      	VARCHAR(36)  		-- 79	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_79_numero                  	INTEGER      		-- 80	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_79_apertura                	DATE         		-- 81	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_79_cierre                  	DATE         		-- 82	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_79_cerrado                 	BOOLEAN      		-- 83	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_79_cerradoModulos          	BOOLEAN      		-- 84	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_79_comentario              	VARCHAR(250) 		-- 85	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_86_id                             	VARCHAR(36)  		-- 86	AsientoContableItem.CuentaContable.CostoVenta.id
	, CostoVenta_86_numero                         	INTEGER      		-- 87	AsientoContableItem.CuentaContable.CostoVenta.numero
	, CostoVenta_86_nombre                         	VARCHAR(50)  		-- 88	AsientoContableItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_89_id                        	VARCHAR(36)  		-- 89	AsientoContableItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_89_numero                    	INTEGER      		-- 90	AsientoContableItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_89_nombre                    	VARCHAR(50)  		-- 91	AsientoContableItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_89_equate                    	VARCHAR(30)  		-- 92	AsientoContableItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_93_id                        	VARCHAR(36)  		-- 93	AsientoContableItem.CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_93_numero                    	INTEGER      		-- 94	AsientoContableItem.CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_93_nombre                    	VARCHAR(50)  		-- 95	AsientoContableItem.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre
	, AsientoContableItem_debe                     	DECIMAL(13,5)		-- 96	AsientoContableItem.debe
	, AsientoContableItem_haber                    	DECIMAL(13,5)		-- 97	AsientoContableItem.haber

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Empresa                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Empresa



DROP TYPE IF EXISTS massoftware.t_Empresa_1 CASCADE;

CREATE TYPE massoftware.t_Empresa_1 AS (

	  Empresa_id                             	VARCHAR(36) 		-- 0	Empresa.id
	, EjercicioContable_1_id                 	VARCHAR(36) 		-- 1	Empresa.EjercicioContable.id
	, EjercicioContable_1_numero             	INTEGER     		-- 2	Empresa.EjercicioContable.numero
	, EjercicioContable_1_apertura           	DATE        		-- 3	Empresa.EjercicioContable.apertura
	, EjercicioContable_1_cierre             	DATE        		-- 4	Empresa.EjercicioContable.cierre
	, EjercicioContable_1_cerrado            	BOOLEAN     		-- 5	Empresa.EjercicioContable.cerrado
	, EjercicioContable_1_cerradoModulos     	BOOLEAN     		-- 6	Empresa.EjercicioContable.cerradoModulos
	, EjercicioContable_1_comentario         	VARCHAR(250)		-- 7	Empresa.EjercicioContable.comentario
	, Empresa_fechaCierreVentas              	DATE        		-- 8	Empresa.fechaCierreVentas
	, Empresa_fechaCierreStock               	DATE        		-- 9	Empresa.fechaCierreStock
	, Empresa_fechaCierreFondo               	DATE        		-- 10	Empresa.fechaCierreFondo
	, Empresa_fechaCierreCompras             	DATE        		-- 11	Empresa.fechaCierreCompras
	, Empresa_fechaCierreContabilidad        	DATE        		-- 12	Empresa.fechaCierreContabilidad
	, Empresa_fechaCierreGarantiaDevoluciones	DATE        		-- 13	Empresa.fechaCierreGarantiaDevoluciones
	, Empresa_fechaCierreTambos              	DATE        		-- 14	Empresa.fechaCierreTambos
	, Empresa_fechaCierreRRHH                	DATE        		-- 15	Empresa.fechaCierreRRHH

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda



DROP TYPE IF EXISTS massoftware.t_Moneda_1 CASCADE;

CREATE TYPE massoftware.t_Moneda_1 AS (

	  Moneda_id                  	VARCHAR(36)  		-- 0	Moneda.id
	, Moneda_numero              	INTEGER      		-- 1	Moneda.numero
	, Moneda_nombre              	VARCHAR(50)  		-- 2	Moneda.nombre
	, Moneda_abreviatura         	VARCHAR(5)   		-- 3	Moneda.abreviatura
	, Moneda_cotizacion          	DECIMAL(13,5)		-- 4	Moneda.cotizacion
	, Moneda_cotizacionFecha     	TIMESTAMP    		-- 5	Moneda.cotizacionFecha
	, Moneda_controlActualizacion	BOOLEAN      		-- 6	Moneda.controlActualizacion
	, MonedaAFIP_7_id            	VARCHAR(36)  		-- 7	Moneda.MonedaAFIP.id
	, MonedaAFIP_7_codigo        	VARCHAR(3)   		-- 8	Moneda.MonedaAFIP.codigo
	, MonedaAFIP_7_nombre        	VARCHAR(50)  		-- 9	Moneda.MonedaAFIP.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaCotizacion                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaCotizacion



DROP TYPE IF EXISTS massoftware.t_MonedaCotizacion_1 CASCADE;

CREATE TYPE massoftware.t_MonedaCotizacion_1 AS (

	  MonedaCotizacion_id                      	VARCHAR(36)  		-- 0	MonedaCotizacion.id
	, MonedaCotizacion_cotizacionFecha         	TIMESTAMP    		-- 1	MonedaCotizacion.cotizacionFecha
	, MonedaCotizacion_compra                  	DECIMAL(13,5)		-- 2	MonedaCotizacion.compra
	, MonedaCotizacion_venta                   	DECIMAL(13,5)		-- 3	MonedaCotizacion.venta
	, MonedaCotizacion_cotizacionFechaAuditoria	TIMESTAMP    		-- 4	MonedaCotizacion.cotizacionFechaAuditoria
	, Moneda_5_id                              	VARCHAR(36)  		-- 5	MonedaCotizacion.Moneda.id
	, Moneda_5_numero                          	INTEGER      		-- 6	MonedaCotizacion.Moneda.numero
	, Moneda_5_nombre                          	VARCHAR(50)  		-- 7	MonedaCotizacion.Moneda.nombre
	, Moneda_5_abreviatura                     	VARCHAR(5)   		-- 8	MonedaCotizacion.Moneda.abreviatura
	, Moneda_5_cotizacion                      	DECIMAL(13,5)		-- 9	MonedaCotizacion.Moneda.cotizacion
	, Moneda_5_cotizacionFecha                 	TIMESTAMP    		-- 10	MonedaCotizacion.Moneda.cotizacionFecha
	, Moneda_5_controlActualizacion            	BOOLEAN      		-- 11	MonedaCotizacion.Moneda.controlActualizacion
	, Moneda_5_monedaAFIP                      	VARCHAR(36)  		-- 12	MonedaCotizacion.Moneda.monedaAFIP
	, Usuario_13_id                            	VARCHAR(36)  		-- 13	MonedaCotizacion.Usuario.id
	, Usuario_13_numero                        	INTEGER      		-- 14	MonedaCotizacion.Usuario.numero
	, Usuario_13_nombre                        	VARCHAR(50)  		-- 15	MonedaCotizacion.Usuario.nombre

);

DROP TYPE IF EXISTS massoftware.t_MonedaCotizacion_2 CASCADE;

CREATE TYPE massoftware.t_MonedaCotizacion_2 AS (

	  MonedaCotizacion_id                      	VARCHAR(36)  		-- 0	MonedaCotizacion.id
	, MonedaCotizacion_cotizacionFecha         	TIMESTAMP    		-- 1	MonedaCotizacion.cotizacionFecha
	, MonedaCotizacion_compra                  	DECIMAL(13,5)		-- 2	MonedaCotizacion.compra
	, MonedaCotizacion_venta                   	DECIMAL(13,5)		-- 3	MonedaCotizacion.venta
	, MonedaCotizacion_cotizacionFechaAuditoria	TIMESTAMP    		-- 4	MonedaCotizacion.cotizacionFechaAuditoria
	, Moneda_5_id                              	VARCHAR(36)  		-- 5	MonedaCotizacion.Moneda.id
	, Moneda_5_numero                          	INTEGER      		-- 6	MonedaCotizacion.Moneda.numero
	, Moneda_5_nombre                          	VARCHAR(50)  		-- 7	MonedaCotizacion.Moneda.nombre
	, Moneda_5_abreviatura                     	VARCHAR(5)   		-- 8	MonedaCotizacion.Moneda.abreviatura
	, Moneda_5_cotizacion                      	DECIMAL(13,5)		-- 9	MonedaCotizacion.Moneda.cotizacion
	, Moneda_5_cotizacionFecha                 	TIMESTAMP    		-- 10	MonedaCotizacion.Moneda.cotizacionFecha
	, Moneda_5_controlActualizacion            	BOOLEAN      		-- 11	MonedaCotizacion.Moneda.controlActualizacion
	, MonedaAFIP_12_id                         	VARCHAR(36)  		-- 12	MonedaCotizacion.Moneda.MonedaAFIP.id
	, MonedaAFIP_12_codigo                     	VARCHAR(3)   		-- 13	MonedaCotizacion.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_12_nombre                     	VARCHAR(50)  		-- 14	MonedaCotizacion.Moneda.MonedaAFIP.nombre
	, Usuario_15_id                            	VARCHAR(36)  		-- 15	MonedaCotizacion.Usuario.id
	, Usuario_15_numero                        	INTEGER      		-- 16	MonedaCotizacion.Usuario.numero
	, Usuario_15_nombre                        	VARCHAR(50)  		-- 17	MonedaCotizacion.Usuario.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Caja                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Caja



DROP TYPE IF EXISTS massoftware.t_Caja_1 CASCADE;

CREATE TYPE massoftware.t_Caja_1 AS (

	  Caja_id                          	VARCHAR(36)		-- 0	Caja.id
	, Caja_numero                      	INTEGER    		-- 1	Caja.numero
	, Caja_nombre                      	VARCHAR(50)		-- 2	Caja.nombre
	, SeguridadPuerta_3_id             	VARCHAR(36)		-- 3	Caja.SeguridadPuerta.id
	, SeguridadPuerta_3_numero         	INTEGER    		-- 4	Caja.SeguridadPuerta.numero
	, SeguridadPuerta_3_nombre         	VARCHAR(50)		-- 5	Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_3_equate         	VARCHAR(30)		-- 6	Caja.SeguridadPuerta.equate
	, SeguridadPuerta_3_seguridadModulo	VARCHAR(36)		-- 7	Caja.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_Caja_2 CASCADE;

CREATE TYPE massoftware.t_Caja_2 AS (

	  Caja_id                 	VARCHAR(36)		-- 0	Caja.id
	, Caja_numero             	INTEGER    		-- 1	Caja.numero
	, Caja_nombre             	VARCHAR(50)		-- 2	Caja.nombre
	, SeguridadPuerta_3_id    	VARCHAR(36)		-- 3	Caja.SeguridadPuerta.id
	, SeguridadPuerta_3_numero	INTEGER    		-- 4	Caja.SeguridadPuerta.numero
	, SeguridadPuerta_3_nombre	VARCHAR(50)		-- 5	Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_3_equate	VARCHAR(30)		-- 6	Caja.SeguridadPuerta.equate
	, SeguridadModulo_7_id    	VARCHAR(36)		-- 7	Caja.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_7_numero	INTEGER    		-- 8	Caja.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_7_nombre	VARCHAR(50)		-- 9	Caja.SeguridadPuerta.SeguridadModulo.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoGrupo                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoGrupo



DROP TYPE IF EXISTS massoftware.t_CuentaFondoGrupo_1 CASCADE;

CREATE TYPE massoftware.t_CuentaFondoGrupo_1 AS (

	  CuentaFondoGrupo_id      	VARCHAR(36)		-- 0	CuentaFondoGrupo.id
	, CuentaFondoGrupo_numero  	INTEGER    		-- 1	CuentaFondoGrupo.numero
	, CuentaFondoGrupo_nombre  	VARCHAR(50)		-- 2	CuentaFondoGrupo.nombre
	, CuentaFondoRubro_3_id    	VARCHAR(36)		-- 3	CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_3_numero	INTEGER    		-- 4	CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_3_nombre	VARCHAR(50)		-- 5	CuentaFondoGrupo.CuentaFondoRubro.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondo                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondo



DROP TYPE IF EXISTS massoftware.t_CuentaFondo_1 CASCADE;

CREATE TYPE massoftware.t_CuentaFondo_1 AS (

	  CuentaFondo_id                       	VARCHAR(36)  		-- 0	CuentaFondo.id
	, CuentaFondo_numero                   	INTEGER      		-- 1	CuentaFondo.numero
	, CuentaFondo_nombre                   	VARCHAR(50)  		-- 2	CuentaFondo.nombre
	, CuentaContable_3_id                  	VARCHAR(36)  		-- 3	CuentaFondo.CuentaContable.id
	, CuentaContable_3_codigo              	VARCHAR(11)  		-- 4	CuentaFondo.CuentaContable.codigo
	, CuentaContable_3_nombre              	VARCHAR(50)  		-- 5	CuentaFondo.CuentaContable.nombre
	, CuentaContable_3_ejercicioContable   	VARCHAR(36)  		-- 6	CuentaFondo.CuentaContable.ejercicioContable
	, CuentaContable_3_integra             	VARCHAR(16)  		-- 7	CuentaFondo.CuentaContable.integra
	, CuentaContable_3_cuentaJerarquia     	VARCHAR(16)  		-- 8	CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_3_imputable           	BOOLEAN      		-- 9	CuentaFondo.CuentaContable.imputable
	, CuentaContable_3_ajustaPorInflacion  	BOOLEAN      		-- 10	CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContable_3_cuentaContableEstado	VARCHAR(36)  		-- 11	CuentaFondo.CuentaContable.cuentaContableEstado
	, CuentaContable_3_cuentaConApropiacion	BOOLEAN      		-- 12	CuentaFondo.CuentaContable.cuentaConApropiacion
	, CuentaContable_3_centroCostoContable 	VARCHAR(36)  		-- 13	CuentaFondo.CuentaContable.centroCostoContable
	, CuentaContable_3_cuentaAgrupadora    	VARCHAR(50)  		-- 14	CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_3_porcentaje          	DECIMAL(6,3) 		-- 15	CuentaFondo.CuentaContable.porcentaje
	, CuentaContable_3_puntoEquilibrio     	VARCHAR(36)  		-- 16	CuentaFondo.CuentaContable.puntoEquilibrio
	, CuentaContable_3_costoVenta          	VARCHAR(36)  		-- 17	CuentaFondo.CuentaContable.costoVenta
	, CuentaContable_3_seguridadPuerta     	VARCHAR(36)  		-- 18	CuentaFondo.CuentaContable.seguridadPuerta
	, CuentaFondoGrupo_19_id               	VARCHAR(36)  		-- 19	CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_19_numero           	INTEGER      		-- 20	CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_19_nombre           	VARCHAR(50)  		-- 21	CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoGrupo_19_cuentaFondoRubro 	VARCHAR(36)  		-- 22	CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro
	, CuentaFondoTipo_23_id                	VARCHAR(36)  		-- 23	CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_23_numero            	INTEGER      		-- 24	CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_23_nombre            	VARCHAR(50)  		-- 25	CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_obsoleto                 	BOOLEAN      		-- 26	CuentaFondo.obsoleto
	, CuentaFondo_noImprimeCaja            	BOOLEAN      		-- 27	CuentaFondo.noImprimeCaja
	, CuentaFondo_ventas                   	BOOLEAN      		-- 28	CuentaFondo.ventas
	, CuentaFondo_fondos                   	BOOLEAN      		-- 29	CuentaFondo.fondos
	, CuentaFondo_compras                  	BOOLEAN      		-- 30	CuentaFondo.compras
	, Moneda_31_id                         	VARCHAR(36)  		-- 31	CuentaFondo.Moneda.id
	, Moneda_31_numero                     	INTEGER      		-- 32	CuentaFondo.Moneda.numero
	, Moneda_31_nombre                     	VARCHAR(50)  		-- 33	CuentaFondo.Moneda.nombre
	, Moneda_31_abreviatura                	VARCHAR(5)   		-- 34	CuentaFondo.Moneda.abreviatura
	, Moneda_31_cotizacion                 	DECIMAL(13,5)		-- 35	CuentaFondo.Moneda.cotizacion
	, Moneda_31_cotizacionFecha            	TIMESTAMP    		-- 36	CuentaFondo.Moneda.cotizacionFecha
	, Moneda_31_controlActualizacion       	BOOLEAN      		-- 37	CuentaFondo.Moneda.controlActualizacion
	, Moneda_31_monedaAFIP                 	VARCHAR(36)  		-- 38	CuentaFondo.Moneda.monedaAFIP
	, Caja_39_id                           	VARCHAR(36)  		-- 39	CuentaFondo.Caja.id
	, Caja_39_numero                       	INTEGER      		-- 40	CuentaFondo.Caja.numero
	, Caja_39_nombre                       	VARCHAR(50)  		-- 41	CuentaFondo.Caja.nombre
	, Caja_39_seguridadPuerta              	VARCHAR(36)  		-- 42	CuentaFondo.Caja.seguridadPuerta
	, CuentaFondo_rechazados               	BOOLEAN      		-- 43	CuentaFondo.rechazados
	, CuentaFondo_conciliacion             	BOOLEAN      		-- 44	CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_45_id           	VARCHAR(36)  		-- 45	CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_45_numero       	INTEGER      		-- 46	CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_45_nombre       	VARCHAR(50)  		-- 47	CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_48_id                          	VARCHAR(36)  		-- 48	CuentaFondo.Banco.id
	, Banco_48_numero                      	INTEGER      		-- 49	CuentaFondo.Banco.numero
	, Banco_48_nombre                      	VARCHAR(50)  		-- 50	CuentaFondo.Banco.nombre
	, Banco_48_cuit                        	BIGINT       		-- 51	CuentaFondo.Banco.cuit
	, Banco_48_bloqueado                   	BOOLEAN      		-- 52	CuentaFondo.Banco.bloqueado
	, Banco_48_hoja                        	INTEGER      		-- 53	CuentaFondo.Banco.hoja
	, Banco_48_primeraFila                 	INTEGER      		-- 54	CuentaFondo.Banco.primeraFila
	, Banco_48_ultimaFila                  	INTEGER      		-- 55	CuentaFondo.Banco.ultimaFila
	, Banco_48_fecha                       	VARCHAR(3)   		-- 56	CuentaFondo.Banco.fecha
	, Banco_48_descripcion                 	VARCHAR(3)   		-- 57	CuentaFondo.Banco.descripcion
	, Banco_48_referencia1                 	VARCHAR(3)   		-- 58	CuentaFondo.Banco.referencia1
	, Banco_48_importe                     	VARCHAR(3)   		-- 59	CuentaFondo.Banco.importe
	, Banco_48_referencia2                 	VARCHAR(3)   		-- 60	CuentaFondo.Banco.referencia2
	, Banco_48_saldo                       	VARCHAR(3)   		-- 61	CuentaFondo.Banco.saldo
	, CuentaFondo_cuentaBancaria           	VARCHAR(22)  		-- 62	CuentaFondo.cuentaBancaria
	, CuentaFondo_cbu                      	VARCHAR(22)  		-- 63	CuentaFondo.cbu
	, CuentaFondo_limiteDescubierto        	DECIMAL(13,5)		-- 64	CuentaFondo.limiteDescubierto
	, CuentaFondo_cuentaFondoCaucion       	VARCHAR(50)  		-- 65	CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_cuentaFondoDiferidos     	VARCHAR(50)  		-- 66	CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_formato                  	VARCHAR(50)  		-- 67	CuentaFondo.formato
	, CuentaFondoBancoCopia_68_id          	VARCHAR(36)  		-- 68	CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_68_numero      	INTEGER      		-- 69	CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_68_nombre      	VARCHAR(50)  		-- 70	CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_limiteOperacionIndividual	DECIMAL(13,5)		-- 71	CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_72_id                	VARCHAR(36)  		-- 72	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_72_numero            	INTEGER      		-- 73	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_72_nombre            	VARCHAR(50)  		-- 74	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_72_equate            	VARCHAR(30)  		-- 75	CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_72_seguridadModulo   	VARCHAR(36)  		-- 76	CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_77_id                	VARCHAR(36)  		-- 77	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_77_numero            	INTEGER      		-- 78	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_77_nombre            	VARCHAR(50)  		-- 79	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_77_equate            	VARCHAR(30)  		-- 80	CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_77_seguridadModulo   	VARCHAR(36)  		-- 81	CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_82_id                	VARCHAR(36)  		-- 82	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_82_numero            	INTEGER      		-- 83	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_82_nombre            	VARCHAR(50)  		-- 84	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_82_equate            	VARCHAR(30)  		-- 85	CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_82_seguridadModulo   	VARCHAR(36)  		-- 86	CuentaFondo.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_CuentaFondo_2 CASCADE;

CREATE TYPE massoftware.t_CuentaFondo_2 AS (

	  CuentaFondo_id                          	VARCHAR(36)  		-- 0	CuentaFondo.id
	, CuentaFondo_numero                      	INTEGER      		-- 1	CuentaFondo.numero
	, CuentaFondo_nombre                      	VARCHAR(50)  		-- 2	CuentaFondo.nombre
	, CuentaContable_3_id                     	VARCHAR(36)  		-- 3	CuentaFondo.CuentaContable.id
	, CuentaContable_3_codigo                 	VARCHAR(11)  		-- 4	CuentaFondo.CuentaContable.codigo
	, CuentaContable_3_nombre                 	VARCHAR(50)  		-- 5	CuentaFondo.CuentaContable.nombre
	, EjercicioContable_6_id                  	VARCHAR(36)  		-- 6	CuentaFondo.CuentaContable.EjercicioContable.id
	, EjercicioContable_6_numero              	INTEGER      		-- 7	CuentaFondo.CuentaContable.EjercicioContable.numero
	, EjercicioContable_6_apertura            	DATE         		-- 8	CuentaFondo.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_6_cierre              	DATE         		-- 9	CuentaFondo.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_6_cerrado             	BOOLEAN      		-- 10	CuentaFondo.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_6_cerradoModulos      	BOOLEAN      		-- 11	CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_6_comentario          	VARCHAR(250) 		-- 12	CuentaFondo.CuentaContable.EjercicioContable.comentario
	, CuentaContable_3_integra                	VARCHAR(16)  		-- 13	CuentaFondo.CuentaContable.integra
	, CuentaContable_3_cuentaJerarquia        	VARCHAR(16)  		-- 14	CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_3_imputable              	BOOLEAN      		-- 15	CuentaFondo.CuentaContable.imputable
	, CuentaContable_3_ajustaPorInflacion     	BOOLEAN      		-- 16	CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_17_id              	VARCHAR(36)  		-- 17	CuentaFondo.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_17_numero          	INTEGER      		-- 18	CuentaFondo.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_17_nombre          	VARCHAR(50)  		-- 19	CuentaFondo.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_3_cuentaConApropiacion   	BOOLEAN      		-- 20	CuentaFondo.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_21_id               	VARCHAR(36)  		-- 21	CuentaFondo.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_21_numero           	INTEGER      		-- 22	CuentaFondo.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_21_nombre           	VARCHAR(50)  		-- 23	CuentaFondo.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_21_abreviatura      	VARCHAR(5)   		-- 24	CuentaFondo.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_21_ejercicioContable	VARCHAR(36)  		-- 25	CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_3_cuentaAgrupadora       	VARCHAR(50)  		-- 26	CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_3_porcentaje             	DECIMAL(6,3) 		-- 27	CuentaFondo.CuentaContable.porcentaje
	, PuntoEquilibrio_28_id                   	VARCHAR(36)  		-- 28	CuentaFondo.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_28_numero               	INTEGER      		-- 29	CuentaFondo.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_28_nombre               	VARCHAR(50)  		-- 30	CuentaFondo.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_28_tipoPuntoEquilibrio  	VARCHAR(36)  		-- 31	CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_28_ejercicioContable    	VARCHAR(36)  		-- 32	CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_33_id                        	VARCHAR(36)  		-- 33	CuentaFondo.CuentaContable.CostoVenta.id
	, CostoVenta_33_numero                    	INTEGER      		-- 34	CuentaFondo.CuentaContable.CostoVenta.numero
	, CostoVenta_33_nombre                    	VARCHAR(50)  		-- 35	CuentaFondo.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_36_id                   	VARCHAR(36)  		-- 36	CuentaFondo.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_36_numero               	INTEGER      		-- 37	CuentaFondo.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_36_nombre               	VARCHAR(50)  		-- 38	CuentaFondo.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_36_equate               	VARCHAR(30)  		-- 39	CuentaFondo.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_36_seguridadModulo      	VARCHAR(36)  		-- 40	CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo
	, CuentaFondoGrupo_41_id                  	VARCHAR(36)  		-- 41	CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_41_numero              	INTEGER      		-- 42	CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_41_nombre              	VARCHAR(50)  		-- 43	CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoRubro_44_id                  	VARCHAR(36)  		-- 44	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_44_numero              	INTEGER      		-- 45	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_44_nombre              	VARCHAR(50)  		-- 46	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre
	, CuentaFondoTipo_47_id                   	VARCHAR(36)  		-- 47	CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_47_numero               	INTEGER      		-- 48	CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_47_nombre               	VARCHAR(50)  		-- 49	CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_obsoleto                    	BOOLEAN      		-- 50	CuentaFondo.obsoleto
	, CuentaFondo_noImprimeCaja               	BOOLEAN      		-- 51	CuentaFondo.noImprimeCaja
	, CuentaFondo_ventas                      	BOOLEAN      		-- 52	CuentaFondo.ventas
	, CuentaFondo_fondos                      	BOOLEAN      		-- 53	CuentaFondo.fondos
	, CuentaFondo_compras                     	BOOLEAN      		-- 54	CuentaFondo.compras
	, Moneda_55_id                            	VARCHAR(36)  		-- 55	CuentaFondo.Moneda.id
	, Moneda_55_numero                        	INTEGER      		-- 56	CuentaFondo.Moneda.numero
	, Moneda_55_nombre                        	VARCHAR(50)  		-- 57	CuentaFondo.Moneda.nombre
	, Moneda_55_abreviatura                   	VARCHAR(5)   		-- 58	CuentaFondo.Moneda.abreviatura
	, Moneda_55_cotizacion                    	DECIMAL(13,5)		-- 59	CuentaFondo.Moneda.cotizacion
	, Moneda_55_cotizacionFecha               	TIMESTAMP    		-- 60	CuentaFondo.Moneda.cotizacionFecha
	, Moneda_55_controlActualizacion          	BOOLEAN      		-- 61	CuentaFondo.Moneda.controlActualizacion
	, MonedaAFIP_62_id                        	VARCHAR(36)  		-- 62	CuentaFondo.Moneda.MonedaAFIP.id
	, MonedaAFIP_62_codigo                    	VARCHAR(3)   		-- 63	CuentaFondo.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_62_nombre                    	VARCHAR(50)  		-- 64	CuentaFondo.Moneda.MonedaAFIP.nombre
	, Caja_65_id                              	VARCHAR(36)  		-- 65	CuentaFondo.Caja.id
	, Caja_65_numero                          	INTEGER      		-- 66	CuentaFondo.Caja.numero
	, Caja_65_nombre                          	VARCHAR(50)  		-- 67	CuentaFondo.Caja.nombre
	, SeguridadPuerta_68_id                   	VARCHAR(36)  		-- 68	CuentaFondo.Caja.SeguridadPuerta.id
	, SeguridadPuerta_68_numero               	INTEGER      		-- 69	CuentaFondo.Caja.SeguridadPuerta.numero
	, SeguridadPuerta_68_nombre               	VARCHAR(50)  		-- 70	CuentaFondo.Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_68_equate               	VARCHAR(30)  		-- 71	CuentaFondo.Caja.SeguridadPuerta.equate
	, SeguridadPuerta_68_seguridadModulo      	VARCHAR(36)  		-- 72	CuentaFondo.Caja.SeguridadPuerta.seguridadModulo
	, CuentaFondo_rechazados                  	BOOLEAN      		-- 73	CuentaFondo.rechazados
	, CuentaFondo_conciliacion                	BOOLEAN      		-- 74	CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_75_id              	VARCHAR(36)  		-- 75	CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_75_numero          	INTEGER      		-- 76	CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_75_nombre          	VARCHAR(50)  		-- 77	CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_78_id                             	VARCHAR(36)  		-- 78	CuentaFondo.Banco.id
	, Banco_78_numero                         	INTEGER      		-- 79	CuentaFondo.Banco.numero
	, Banco_78_nombre                         	VARCHAR(50)  		-- 80	CuentaFondo.Banco.nombre
	, Banco_78_cuit                           	BIGINT       		-- 81	CuentaFondo.Banco.cuit
	, Banco_78_bloqueado                      	BOOLEAN      		-- 82	CuentaFondo.Banco.bloqueado
	, Banco_78_hoja                           	INTEGER      		-- 83	CuentaFondo.Banco.hoja
	, Banco_78_primeraFila                    	INTEGER      		-- 84	CuentaFondo.Banco.primeraFila
	, Banco_78_ultimaFila                     	INTEGER      		-- 85	CuentaFondo.Banco.ultimaFila
	, Banco_78_fecha                          	VARCHAR(3)   		-- 86	CuentaFondo.Banco.fecha
	, Banco_78_descripcion                    	VARCHAR(3)   		-- 87	CuentaFondo.Banco.descripcion
	, Banco_78_referencia1                    	VARCHAR(3)   		-- 88	CuentaFondo.Banco.referencia1
	, Banco_78_importe                        	VARCHAR(3)   		-- 89	CuentaFondo.Banco.importe
	, Banco_78_referencia2                    	VARCHAR(3)   		-- 90	CuentaFondo.Banco.referencia2
	, Banco_78_saldo                          	VARCHAR(3)   		-- 91	CuentaFondo.Banco.saldo
	, CuentaFondo_cuentaBancaria              	VARCHAR(22)  		-- 92	CuentaFondo.cuentaBancaria
	, CuentaFondo_cbu                         	VARCHAR(22)  		-- 93	CuentaFondo.cbu
	, CuentaFondo_limiteDescubierto           	DECIMAL(13,5)		-- 94	CuentaFondo.limiteDescubierto
	, CuentaFondo_cuentaFondoCaucion          	VARCHAR(50)  		-- 95	CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_cuentaFondoDiferidos        	VARCHAR(50)  		-- 96	CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_formato                     	VARCHAR(50)  		-- 97	CuentaFondo.formato
	, CuentaFondoBancoCopia_98_id             	VARCHAR(36)  		-- 98	CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_98_numero         	INTEGER      		-- 99	CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_98_nombre         	VARCHAR(50)  		-- 100	CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_limiteOperacionIndividual   	DECIMAL(13,5)		-- 101	CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_102_id                  	VARCHAR(36)  		-- 102	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_102_numero              	INTEGER      		-- 103	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_102_nombre              	VARCHAR(50)  		-- 104	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_102_equate              	VARCHAR(30)  		-- 105	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_106_id                  	VARCHAR(36)  		-- 106	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_106_numero              	INTEGER      		-- 107	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_106_nombre              	VARCHAR(50)  		-- 108	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_109_id                  	VARCHAR(36)  		-- 109	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_109_numero              	INTEGER      		-- 110	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_109_nombre              	VARCHAR(50)  		-- 111	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_109_equate              	VARCHAR(30)  		-- 112	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_113_id                  	VARCHAR(36)  		-- 113	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_113_numero              	INTEGER      		-- 114	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_113_nombre              	VARCHAR(50)  		-- 115	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_116_id                  	VARCHAR(36)  		-- 116	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_116_numero              	INTEGER      		-- 117	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_116_nombre              	VARCHAR(50)  		-- 118	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_116_equate              	VARCHAR(30)  		-- 119	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_120_id                  	VARCHAR(36)  		-- 120	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_120_numero              	INTEGER      		-- 121	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_120_nombre              	VARCHAR(50)  		-- 122	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre

);

DROP TYPE IF EXISTS massoftware.t_CuentaFondo_3 CASCADE;

CREATE TYPE massoftware.t_CuentaFondo_3 AS (

	  CuentaFondo_id                       	VARCHAR(36)  		-- 0	CuentaFondo.id
	, CuentaFondo_numero                   	INTEGER      		-- 1	CuentaFondo.numero
	, CuentaFondo_nombre                   	VARCHAR(50)  		-- 2	CuentaFondo.nombre
	, CuentaContable_3_id                  	VARCHAR(36)  		-- 3	CuentaFondo.CuentaContable.id
	, CuentaContable_3_codigo              	VARCHAR(11)  		-- 4	CuentaFondo.CuentaContable.codigo
	, CuentaContable_3_nombre              	VARCHAR(50)  		-- 5	CuentaFondo.CuentaContable.nombre
	, EjercicioContable_6_id               	VARCHAR(36)  		-- 6	CuentaFondo.CuentaContable.EjercicioContable.id
	, EjercicioContable_6_numero           	INTEGER      		-- 7	CuentaFondo.CuentaContable.EjercicioContable.numero
	, EjercicioContable_6_apertura         	DATE         		-- 8	CuentaFondo.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_6_cierre           	DATE         		-- 9	CuentaFondo.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_6_cerrado          	BOOLEAN      		-- 10	CuentaFondo.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_6_cerradoModulos   	BOOLEAN      		-- 11	CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_6_comentario       	VARCHAR(250) 		-- 12	CuentaFondo.CuentaContable.EjercicioContable.comentario
	, CuentaContable_3_integra             	VARCHAR(16)  		-- 13	CuentaFondo.CuentaContable.integra
	, CuentaContable_3_cuentaJerarquia     	VARCHAR(16)  		-- 14	CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_3_imputable           	BOOLEAN      		-- 15	CuentaFondo.CuentaContable.imputable
	, CuentaContable_3_ajustaPorInflacion  	BOOLEAN      		-- 16	CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_17_id           	VARCHAR(36)  		-- 17	CuentaFondo.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_17_numero       	INTEGER      		-- 18	CuentaFondo.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_17_nombre       	VARCHAR(50)  		-- 19	CuentaFondo.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_3_cuentaConApropiacion	BOOLEAN      		-- 20	CuentaFondo.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_21_id            	VARCHAR(36)  		-- 21	CuentaFondo.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_21_numero        	INTEGER      		-- 22	CuentaFondo.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_21_nombre        	VARCHAR(50)  		-- 23	CuentaFondo.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_21_abreviatura   	VARCHAR(5)   		-- 24	CuentaFondo.CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_25_id              	VARCHAR(36)  		-- 25	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_25_numero          	INTEGER      		-- 26	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_25_apertura        	DATE         		-- 27	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_25_cierre          	DATE         		-- 28	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_25_cerrado         	BOOLEAN      		-- 29	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_25_cerradoModulos  	BOOLEAN      		-- 30	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_25_comentario      	VARCHAR(250) 		-- 31	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_3_cuentaAgrupadora    	VARCHAR(50)  		-- 32	CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_3_porcentaje          	DECIMAL(6,3) 		-- 33	CuentaFondo.CuentaContable.porcentaje
	, PuntoEquilibrio_34_id                	VARCHAR(36)  		-- 34	CuentaFondo.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_34_numero            	INTEGER      		-- 35	CuentaFondo.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_34_nombre            	VARCHAR(50)  		-- 36	CuentaFondo.CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_37_id            	VARCHAR(36)  		-- 37	CuentaFondo.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_37_numero        	INTEGER      		-- 38	CuentaFondo.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_37_nombre        	VARCHAR(50)  		-- 39	CuentaFondo.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_40_id              	VARCHAR(36)  		-- 40	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_40_numero          	INTEGER      		-- 41	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_40_apertura        	DATE         		-- 42	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_40_cierre          	DATE         		-- 43	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_40_cerrado         	BOOLEAN      		-- 44	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_40_cerradoModulos  	BOOLEAN      		-- 45	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_40_comentario      	VARCHAR(250) 		-- 46	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_47_id                     	VARCHAR(36)  		-- 47	CuentaFondo.CuentaContable.CostoVenta.id
	, CostoVenta_47_numero                 	INTEGER      		-- 48	CuentaFondo.CuentaContable.CostoVenta.numero
	, CostoVenta_47_nombre                 	VARCHAR(50)  		-- 49	CuentaFondo.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_50_id                	VARCHAR(36)  		-- 50	CuentaFondo.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_50_numero            	INTEGER      		-- 51	CuentaFondo.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_50_nombre            	VARCHAR(50)  		-- 52	CuentaFondo.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_50_equate            	VARCHAR(30)  		-- 53	CuentaFondo.CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_54_id                	VARCHAR(36)  		-- 54	CuentaFondo.CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_54_numero            	INTEGER      		-- 55	CuentaFondo.CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_54_nombre            	VARCHAR(50)  		-- 56	CuentaFondo.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre
	, CuentaFondoGrupo_57_id               	VARCHAR(36)  		-- 57	CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_57_numero           	INTEGER      		-- 58	CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_57_nombre           	VARCHAR(50)  		-- 59	CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoRubro_60_id               	VARCHAR(36)  		-- 60	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_60_numero           	INTEGER      		-- 61	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_60_nombre           	VARCHAR(50)  		-- 62	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre
	, CuentaFondoTipo_63_id                	VARCHAR(36)  		-- 63	CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_63_numero            	INTEGER      		-- 64	CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_63_nombre            	VARCHAR(50)  		-- 65	CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_obsoleto                 	BOOLEAN      		-- 66	CuentaFondo.obsoleto
	, CuentaFondo_noImprimeCaja            	BOOLEAN      		-- 67	CuentaFondo.noImprimeCaja
	, CuentaFondo_ventas                   	BOOLEAN      		-- 68	CuentaFondo.ventas
	, CuentaFondo_fondos                   	BOOLEAN      		-- 69	CuentaFondo.fondos
	, CuentaFondo_compras                  	BOOLEAN      		-- 70	CuentaFondo.compras
	, Moneda_71_id                         	VARCHAR(36)  		-- 71	CuentaFondo.Moneda.id
	, Moneda_71_numero                     	INTEGER      		-- 72	CuentaFondo.Moneda.numero
	, Moneda_71_nombre                     	VARCHAR(50)  		-- 73	CuentaFondo.Moneda.nombre
	, Moneda_71_abreviatura                	VARCHAR(5)   		-- 74	CuentaFondo.Moneda.abreviatura
	, Moneda_71_cotizacion                 	DECIMAL(13,5)		-- 75	CuentaFondo.Moneda.cotizacion
	, Moneda_71_cotizacionFecha            	TIMESTAMP    		-- 76	CuentaFondo.Moneda.cotizacionFecha
	, Moneda_71_controlActualizacion       	BOOLEAN      		-- 77	CuentaFondo.Moneda.controlActualizacion
	, MonedaAFIP_78_id                     	VARCHAR(36)  		-- 78	CuentaFondo.Moneda.MonedaAFIP.id
	, MonedaAFIP_78_codigo                 	VARCHAR(3)   		-- 79	CuentaFondo.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_78_nombre                 	VARCHAR(50)  		-- 80	CuentaFondo.Moneda.MonedaAFIP.nombre
	, Caja_81_id                           	VARCHAR(36)  		-- 81	CuentaFondo.Caja.id
	, Caja_81_numero                       	INTEGER      		-- 82	CuentaFondo.Caja.numero
	, Caja_81_nombre                       	VARCHAR(50)  		-- 83	CuentaFondo.Caja.nombre
	, SeguridadPuerta_84_id                	VARCHAR(36)  		-- 84	CuentaFondo.Caja.SeguridadPuerta.id
	, SeguridadPuerta_84_numero            	INTEGER      		-- 85	CuentaFondo.Caja.SeguridadPuerta.numero
	, SeguridadPuerta_84_nombre            	VARCHAR(50)  		-- 86	CuentaFondo.Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_84_equate            	VARCHAR(30)  		-- 87	CuentaFondo.Caja.SeguridadPuerta.equate
	, SeguridadModulo_88_id                	VARCHAR(36)  		-- 88	CuentaFondo.Caja.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_88_numero            	INTEGER      		-- 89	CuentaFondo.Caja.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_88_nombre            	VARCHAR(50)  		-- 90	CuentaFondo.Caja.SeguridadPuerta.SeguridadModulo.nombre
	, CuentaFondo_rechazados               	BOOLEAN      		-- 91	CuentaFondo.rechazados
	, CuentaFondo_conciliacion             	BOOLEAN      		-- 92	CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_93_id           	VARCHAR(36)  		-- 93	CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_93_numero       	INTEGER      		-- 94	CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_93_nombre       	VARCHAR(50)  		-- 95	CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_96_id                          	VARCHAR(36)  		-- 96	CuentaFondo.Banco.id
	, Banco_96_numero                      	INTEGER      		-- 97	CuentaFondo.Banco.numero
	, Banco_96_nombre                      	VARCHAR(50)  		-- 98	CuentaFondo.Banco.nombre
	, Banco_96_cuit                        	BIGINT       		-- 99	CuentaFondo.Banco.cuit
	, Banco_96_bloqueado                   	BOOLEAN      		-- 100	CuentaFondo.Banco.bloqueado
	, Banco_96_hoja                        	INTEGER      		-- 101	CuentaFondo.Banco.hoja
	, Banco_96_primeraFila                 	INTEGER      		-- 102	CuentaFondo.Banco.primeraFila
	, Banco_96_ultimaFila                  	INTEGER      		-- 103	CuentaFondo.Banco.ultimaFila
	, Banco_96_fecha                       	VARCHAR(3)   		-- 104	CuentaFondo.Banco.fecha
	, Banco_96_descripcion                 	VARCHAR(3)   		-- 105	CuentaFondo.Banco.descripcion
	, Banco_96_referencia1                 	VARCHAR(3)   		-- 106	CuentaFondo.Banco.referencia1
	, Banco_96_importe                     	VARCHAR(3)   		-- 107	CuentaFondo.Banco.importe
	, Banco_96_referencia2                 	VARCHAR(3)   		-- 108	CuentaFondo.Banco.referencia2
	, Banco_96_saldo                       	VARCHAR(3)   		-- 109	CuentaFondo.Banco.saldo
	, CuentaFondo_cuentaBancaria           	VARCHAR(22)  		-- 110	CuentaFondo.cuentaBancaria
	, CuentaFondo_cbu                      	VARCHAR(22)  		-- 111	CuentaFondo.cbu
	, CuentaFondo_limiteDescubierto        	DECIMAL(13,5)		-- 112	CuentaFondo.limiteDescubierto
	, CuentaFondo_cuentaFondoCaucion       	VARCHAR(50)  		-- 113	CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_cuentaFondoDiferidos     	VARCHAR(50)  		-- 114	CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_formato                  	VARCHAR(50)  		-- 115	CuentaFondo.formato
	, CuentaFondoBancoCopia_116_id         	VARCHAR(36)  		-- 116	CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_116_numero     	INTEGER      		-- 117	CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_116_nombre     	VARCHAR(50)  		-- 118	CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_limiteOperacionIndividual	DECIMAL(13,5)		-- 119	CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_120_id               	VARCHAR(36)  		-- 120	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_120_numero           	INTEGER      		-- 121	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_120_nombre           	VARCHAR(50)  		-- 122	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_120_equate           	VARCHAR(30)  		-- 123	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_124_id               	VARCHAR(36)  		-- 124	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_124_numero           	INTEGER      		-- 125	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_124_nombre           	VARCHAR(50)  		-- 126	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_127_id               	VARCHAR(36)  		-- 127	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_127_numero           	INTEGER      		-- 128	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_127_nombre           	VARCHAR(50)  		-- 129	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_127_equate           	VARCHAR(30)  		-- 130	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_131_id               	VARCHAR(36)  		-- 131	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_131_numero           	INTEGER      		-- 132	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_131_nombre           	VARCHAR(50)  		-- 133	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_134_id               	VARCHAR(36)  		-- 134	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_134_numero           	INTEGER      		-- 135	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_134_nombre           	VARCHAR(50)  		-- 136	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_134_equate           	VARCHAR(30)  		-- 137	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_138_id               	VARCHAR(36)  		-- 138	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_138_numero           	INTEGER      		-- 139	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_138_nombre           	VARCHAR(50)  		-- 140	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre

);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModeloItem                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModeloItem



DROP TYPE IF EXISTS massoftware.t_ComprobanteFondoModeloItem_1 CASCADE;

CREATE TYPE massoftware.t_ComprobanteFondoModeloItem_1 AS (

	  ComprobanteFondoModeloItem_id          	VARCHAR(36)  		-- 0	ComprobanteFondoModeloItem.id
	, ComprobanteFondoModeloItem_numero      	INTEGER      		-- 1	ComprobanteFondoModeloItem.numero
	, ComprobanteFondoModeloItem_debe        	BOOLEAN      		-- 2	ComprobanteFondoModeloItem.debe
	, ComprobanteFondoModelo_3_id            	VARCHAR(36)  		-- 3	ComprobanteFondoModeloItem.ComprobanteFondoModelo.id
	, ComprobanteFondoModelo_3_numero        	INTEGER      		-- 4	ComprobanteFondoModeloItem.ComprobanteFondoModelo.numero
	, ComprobanteFondoModelo_3_nombre        	VARCHAR(50)  		-- 5	ComprobanteFondoModeloItem.ComprobanteFondoModelo.nombre
	, CuentaFondo_6_id                       	VARCHAR(36)  		-- 6	ComprobanteFondoModeloItem.CuentaFondo.id
	, CuentaFondo_6_numero                   	INTEGER      		-- 7	ComprobanteFondoModeloItem.CuentaFondo.numero
	, CuentaFondo_6_nombre                   	VARCHAR(50)  		-- 8	ComprobanteFondoModeloItem.CuentaFondo.nombre
	, CuentaFondo_6_cuentaContable           	VARCHAR(36)  		-- 9	ComprobanteFondoModeloItem.CuentaFondo.cuentaContable
	, CuentaFondo_6_cuentaFondoGrupo         	VARCHAR(36)  		-- 10	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoGrupo
	, CuentaFondo_6_cuentaFondoTipo          	VARCHAR(36)  		-- 11	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoTipo
	, CuentaFondo_6_obsoleto                 	BOOLEAN      		-- 12	ComprobanteFondoModeloItem.CuentaFondo.obsoleto
	, CuentaFondo_6_noImprimeCaja            	BOOLEAN      		-- 13	ComprobanteFondoModeloItem.CuentaFondo.noImprimeCaja
	, CuentaFondo_6_ventas                   	BOOLEAN      		-- 14	ComprobanteFondoModeloItem.CuentaFondo.ventas
	, CuentaFondo_6_fondos                   	BOOLEAN      		-- 15	ComprobanteFondoModeloItem.CuentaFondo.fondos
	, CuentaFondo_6_compras                  	BOOLEAN      		-- 16	ComprobanteFondoModeloItem.CuentaFondo.compras
	, CuentaFondo_6_moneda                   	VARCHAR(36)  		-- 17	ComprobanteFondoModeloItem.CuentaFondo.moneda
	, CuentaFondo_6_caja                     	VARCHAR(36)  		-- 18	ComprobanteFondoModeloItem.CuentaFondo.caja
	, CuentaFondo_6_rechazados               	BOOLEAN      		-- 19	ComprobanteFondoModeloItem.CuentaFondo.rechazados
	, CuentaFondo_6_conciliacion             	BOOLEAN      		-- 20	ComprobanteFondoModeloItem.CuentaFondo.conciliacion
	, CuentaFondo_6_cuentaFondoTipoBanco     	VARCHAR(36)  		-- 21	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoTipoBanco
	, CuentaFondo_6_banco                    	VARCHAR(36)  		-- 22	ComprobanteFondoModeloItem.CuentaFondo.banco
	, CuentaFondo_6_cuentaBancaria           	VARCHAR(22)  		-- 23	ComprobanteFondoModeloItem.CuentaFondo.cuentaBancaria
	, CuentaFondo_6_cbu                      	VARCHAR(22)  		-- 24	ComprobanteFondoModeloItem.CuentaFondo.cbu
	, CuentaFondo_6_limiteDescubierto        	DECIMAL(13,5)		-- 25	ComprobanteFondoModeloItem.CuentaFondo.limiteDescubierto
	, CuentaFondo_6_cuentaFondoCaucion       	VARCHAR(50)  		-- 26	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_6_cuentaFondoDiferidos     	VARCHAR(50)  		-- 27	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_6_formato                  	VARCHAR(50)  		-- 28	ComprobanteFondoModeloItem.CuentaFondo.formato
	, CuentaFondo_6_cuentaFondoBancoCopia    	VARCHAR(36)  		-- 29	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoBancoCopia
	, CuentaFondo_6_limiteOperacionIndividual	DECIMAL(13,5)		-- 30	ComprobanteFondoModeloItem.CuentaFondo.limiteOperacionIndividual
	, CuentaFondo_6_seguridadPuertaUso       	VARCHAR(36)  		-- 31	ComprobanteFondoModeloItem.CuentaFondo.seguridadPuertaUso
	, CuentaFondo_6_seguridadPuertaConsulta  	VARCHAR(36)  		-- 32	ComprobanteFondoModeloItem.CuentaFondo.seguridadPuertaConsulta
	, CuentaFondo_6_seguridadPuertaLimite    	VARCHAR(36)  		-- 33	ComprobanteFondoModeloItem.CuentaFondo.seguridadPuertaLimite

);

DROP TYPE IF EXISTS massoftware.t_ComprobanteFondoModeloItem_2 CASCADE;

CREATE TYPE massoftware.t_ComprobanteFondoModeloItem_2 AS (

	  ComprobanteFondoModeloItem_id          	VARCHAR(36)  		-- 0	ComprobanteFondoModeloItem.id
	, ComprobanteFondoModeloItem_numero      	INTEGER      		-- 1	ComprobanteFondoModeloItem.numero
	, ComprobanteFondoModeloItem_debe        	BOOLEAN      		-- 2	ComprobanteFondoModeloItem.debe
	, ComprobanteFondoModelo_3_id            	VARCHAR(36)  		-- 3	ComprobanteFondoModeloItem.ComprobanteFondoModelo.id
	, ComprobanteFondoModelo_3_numero        	INTEGER      		-- 4	ComprobanteFondoModeloItem.ComprobanteFondoModelo.numero
	, ComprobanteFondoModelo_3_nombre        	VARCHAR(50)  		-- 5	ComprobanteFondoModeloItem.ComprobanteFondoModelo.nombre
	, CuentaFondo_6_id                       	VARCHAR(36)  		-- 6	ComprobanteFondoModeloItem.CuentaFondo.id
	, CuentaFondo_6_numero                   	INTEGER      		-- 7	ComprobanteFondoModeloItem.CuentaFondo.numero
	, CuentaFondo_6_nombre                   	VARCHAR(50)  		-- 8	ComprobanteFondoModeloItem.CuentaFondo.nombre
	, CuentaContable_9_id                    	VARCHAR(36)  		-- 9	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.id
	, CuentaContable_9_codigo                	VARCHAR(11)  		-- 10	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.codigo
	, CuentaContable_9_nombre                	VARCHAR(50)  		-- 11	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.nombre
	, CuentaContable_9_ejercicioContable     	VARCHAR(36)  		-- 12	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.ejercicioContable
	, CuentaContable_9_integra               	VARCHAR(16)  		-- 13	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.integra
	, CuentaContable_9_cuentaJerarquia       	VARCHAR(16)  		-- 14	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_9_imputable             	BOOLEAN      		-- 15	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.imputable
	, CuentaContable_9_ajustaPorInflacion    	BOOLEAN      		-- 16	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContable_9_cuentaContableEstado  	VARCHAR(36)  		-- 17	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaContableEstado
	, CuentaContable_9_cuentaConApropiacion  	BOOLEAN      		-- 18	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaConApropiacion
	, CuentaContable_9_centroCostoContable   	VARCHAR(36)  		-- 19	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.centroCostoContable
	, CuentaContable_9_cuentaAgrupadora      	VARCHAR(50)  		-- 20	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_9_porcentaje            	DECIMAL(6,3) 		-- 21	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.porcentaje
	, CuentaContable_9_puntoEquilibrio       	VARCHAR(36)  		-- 22	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.puntoEquilibrio
	, CuentaContable_9_costoVenta            	VARCHAR(36)  		-- 23	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.costoVenta
	, CuentaContable_9_seguridadPuerta       	VARCHAR(36)  		-- 24	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.seguridadPuerta
	, CuentaFondoGrupo_25_id                 	VARCHAR(36)  		-- 25	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_25_numero             	INTEGER      		-- 26	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_25_nombre             	VARCHAR(50)  		-- 27	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoGrupo_25_cuentaFondoRubro   	VARCHAR(36)  		-- 28	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro
	, CuentaFondoTipo_29_id                  	VARCHAR(36)  		-- 29	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_29_numero              	INTEGER      		-- 30	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_29_nombre              	VARCHAR(50)  		-- 31	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_6_obsoleto                 	BOOLEAN      		-- 32	ComprobanteFondoModeloItem.CuentaFondo.obsoleto
	, CuentaFondo_6_noImprimeCaja            	BOOLEAN      		-- 33	ComprobanteFondoModeloItem.CuentaFondo.noImprimeCaja
	, CuentaFondo_6_ventas                   	BOOLEAN      		-- 34	ComprobanteFondoModeloItem.CuentaFondo.ventas
	, CuentaFondo_6_fondos                   	BOOLEAN      		-- 35	ComprobanteFondoModeloItem.CuentaFondo.fondos
	, CuentaFondo_6_compras                  	BOOLEAN      		-- 36	ComprobanteFondoModeloItem.CuentaFondo.compras
	, Moneda_37_id                           	VARCHAR(36)  		-- 37	ComprobanteFondoModeloItem.CuentaFondo.Moneda.id
	, Moneda_37_numero                       	INTEGER      		-- 38	ComprobanteFondoModeloItem.CuentaFondo.Moneda.numero
	, Moneda_37_nombre                       	VARCHAR(50)  		-- 39	ComprobanteFondoModeloItem.CuentaFondo.Moneda.nombre
	, Moneda_37_abreviatura                  	VARCHAR(5)   		-- 40	ComprobanteFondoModeloItem.CuentaFondo.Moneda.abreviatura
	, Moneda_37_cotizacion                   	DECIMAL(13,5)		-- 41	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacion
	, Moneda_37_cotizacionFecha              	TIMESTAMP    		-- 42	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacionFecha
	, Moneda_37_controlActualizacion         	BOOLEAN      		-- 43	ComprobanteFondoModeloItem.CuentaFondo.Moneda.controlActualizacion
	, Moneda_37_monedaAFIP                   	VARCHAR(36)  		-- 44	ComprobanteFondoModeloItem.CuentaFondo.Moneda.monedaAFIP
	, Caja_45_id                             	VARCHAR(36)  		-- 45	ComprobanteFondoModeloItem.CuentaFondo.Caja.id
	, Caja_45_numero                         	INTEGER      		-- 46	ComprobanteFondoModeloItem.CuentaFondo.Caja.numero
	, Caja_45_nombre                         	VARCHAR(50)  		-- 47	ComprobanteFondoModeloItem.CuentaFondo.Caja.nombre
	, Caja_45_seguridadPuerta                	VARCHAR(36)  		-- 48	ComprobanteFondoModeloItem.CuentaFondo.Caja.seguridadPuerta
	, CuentaFondo_6_rechazados               	BOOLEAN      		-- 49	ComprobanteFondoModeloItem.CuentaFondo.rechazados
	, CuentaFondo_6_conciliacion             	BOOLEAN      		-- 50	ComprobanteFondoModeloItem.CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_51_id             	VARCHAR(36)  		-- 51	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_51_numero         	INTEGER      		-- 52	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_51_nombre         	VARCHAR(50)  		-- 53	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_54_id                            	VARCHAR(36)  		-- 54	ComprobanteFondoModeloItem.CuentaFondo.Banco.id
	, Banco_54_numero                        	INTEGER      		-- 55	ComprobanteFondoModeloItem.CuentaFondo.Banco.numero
	, Banco_54_nombre                        	VARCHAR(50)  		-- 56	ComprobanteFondoModeloItem.CuentaFondo.Banco.nombre
	, Banco_54_cuit                          	BIGINT       		-- 57	ComprobanteFondoModeloItem.CuentaFondo.Banco.cuit
	, Banco_54_bloqueado                     	BOOLEAN      		-- 58	ComprobanteFondoModeloItem.CuentaFondo.Banco.bloqueado
	, Banco_54_hoja                          	INTEGER      		-- 59	ComprobanteFondoModeloItem.CuentaFondo.Banco.hoja
	, Banco_54_primeraFila                   	INTEGER      		-- 60	ComprobanteFondoModeloItem.CuentaFondo.Banco.primeraFila
	, Banco_54_ultimaFila                    	INTEGER      		-- 61	ComprobanteFondoModeloItem.CuentaFondo.Banco.ultimaFila
	, Banco_54_fecha                         	VARCHAR(3)   		-- 62	ComprobanteFondoModeloItem.CuentaFondo.Banco.fecha
	, Banco_54_descripcion                   	VARCHAR(3)   		-- 63	ComprobanteFondoModeloItem.CuentaFondo.Banco.descripcion
	, Banco_54_referencia1                   	VARCHAR(3)   		-- 64	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia1
	, Banco_54_importe                       	VARCHAR(3)   		-- 65	ComprobanteFondoModeloItem.CuentaFondo.Banco.importe
	, Banco_54_referencia2                   	VARCHAR(3)   		-- 66	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia2
	, Banco_54_saldo                         	VARCHAR(3)   		-- 67	ComprobanteFondoModeloItem.CuentaFondo.Banco.saldo
	, CuentaFondo_6_cuentaBancaria           	VARCHAR(22)  		-- 68	ComprobanteFondoModeloItem.CuentaFondo.cuentaBancaria
	, CuentaFondo_6_cbu                      	VARCHAR(22)  		-- 69	ComprobanteFondoModeloItem.CuentaFondo.cbu
	, CuentaFondo_6_limiteDescubierto        	DECIMAL(13,5)		-- 70	ComprobanteFondoModeloItem.CuentaFondo.limiteDescubierto
	, CuentaFondo_6_cuentaFondoCaucion       	VARCHAR(50)  		-- 71	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_6_cuentaFondoDiferidos     	VARCHAR(50)  		-- 72	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_6_formato                  	VARCHAR(50)  		-- 73	ComprobanteFondoModeloItem.CuentaFondo.formato
	, CuentaFondoBancoCopia_74_id            	VARCHAR(36)  		-- 74	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_74_numero        	INTEGER      		-- 75	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_74_nombre        	VARCHAR(50)  		-- 76	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_6_limiteOperacionIndividual	DECIMAL(13,5)		-- 77	ComprobanteFondoModeloItem.CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_78_id                  	VARCHAR(36)  		-- 78	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_78_numero              	INTEGER      		-- 79	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_78_nombre              	VARCHAR(50)  		-- 80	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_78_equate              	VARCHAR(30)  		-- 81	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_78_seguridadModulo     	VARCHAR(36)  		-- 82	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_83_id                  	VARCHAR(36)  		-- 83	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_83_numero              	INTEGER      		-- 84	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_83_nombre              	VARCHAR(50)  		-- 85	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_83_equate              	VARCHAR(30)  		-- 86	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_83_seguridadModulo     	VARCHAR(36)  		-- 87	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_88_id                  	VARCHAR(36)  		-- 88	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_88_numero              	INTEGER      		-- 89	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_88_nombre              	VARCHAR(50)  		-- 90	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_88_equate              	VARCHAR(30)  		-- 91	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_88_seguridadModulo     	VARCHAR(36)  		-- 92	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_ComprobanteFondoModeloItem_3 CASCADE;

CREATE TYPE massoftware.t_ComprobanteFondoModeloItem_3 AS (

	  ComprobanteFondoModeloItem_id           	VARCHAR(36)  		-- 0	ComprobanteFondoModeloItem.id
	, ComprobanteFondoModeloItem_numero       	INTEGER      		-- 1	ComprobanteFondoModeloItem.numero
	, ComprobanteFondoModeloItem_debe         	BOOLEAN      		-- 2	ComprobanteFondoModeloItem.debe
	, ComprobanteFondoModelo_3_id             	VARCHAR(36)  		-- 3	ComprobanteFondoModeloItem.ComprobanteFondoModelo.id
	, ComprobanteFondoModelo_3_numero         	INTEGER      		-- 4	ComprobanteFondoModeloItem.ComprobanteFondoModelo.numero
	, ComprobanteFondoModelo_3_nombre         	VARCHAR(50)  		-- 5	ComprobanteFondoModeloItem.ComprobanteFondoModelo.nombre
	, CuentaFondo_6_id                        	VARCHAR(36)  		-- 6	ComprobanteFondoModeloItem.CuentaFondo.id
	, CuentaFondo_6_numero                    	INTEGER      		-- 7	ComprobanteFondoModeloItem.CuentaFondo.numero
	, CuentaFondo_6_nombre                    	VARCHAR(50)  		-- 8	ComprobanteFondoModeloItem.CuentaFondo.nombre
	, CuentaContable_9_id                     	VARCHAR(36)  		-- 9	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.id
	, CuentaContable_9_codigo                 	VARCHAR(11)  		-- 10	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.codigo
	, CuentaContable_9_nombre                 	VARCHAR(50)  		-- 11	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.nombre
	, EjercicioContable_12_id                 	VARCHAR(36)  		-- 12	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.id
	, EjercicioContable_12_numero             	INTEGER      		-- 13	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.numero
	, EjercicioContable_12_apertura           	DATE         		-- 14	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_12_cierre             	DATE         		-- 15	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_12_cerrado            	BOOLEAN      		-- 16	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_12_cerradoModulos     	BOOLEAN      		-- 17	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_12_comentario         	VARCHAR(250) 		-- 18	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.comentario
	, CuentaContable_9_integra                	VARCHAR(16)  		-- 19	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.integra
	, CuentaContable_9_cuentaJerarquia        	VARCHAR(16)  		-- 20	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_9_imputable              	BOOLEAN      		-- 21	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.imputable
	, CuentaContable_9_ajustaPorInflacion     	BOOLEAN      		-- 22	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_23_id              	VARCHAR(36)  		-- 23	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_23_numero          	INTEGER      		-- 24	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_23_nombre          	VARCHAR(50)  		-- 25	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_9_cuentaConApropiacion   	BOOLEAN      		-- 26	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_27_id               	VARCHAR(36)  		-- 27	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_27_numero           	INTEGER      		-- 28	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_27_nombre           	VARCHAR(50)  		-- 29	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_27_abreviatura      	VARCHAR(5)   		-- 30	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_27_ejercicioContable	VARCHAR(36)  		-- 31	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_9_cuentaAgrupadora       	VARCHAR(50)  		-- 32	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_9_porcentaje             	DECIMAL(6,3) 		-- 33	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.porcentaje
	, PuntoEquilibrio_34_id                   	VARCHAR(36)  		-- 34	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_34_numero               	INTEGER      		-- 35	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_34_nombre               	VARCHAR(50)  		-- 36	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_34_tipoPuntoEquilibrio  	VARCHAR(36)  		-- 37	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_34_ejercicioContable    	VARCHAR(36)  		-- 38	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_39_id                        	VARCHAR(36)  		-- 39	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CostoVenta.id
	, CostoVenta_39_numero                    	INTEGER      		-- 40	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CostoVenta.numero
	, CostoVenta_39_nombre                    	VARCHAR(50)  		-- 41	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_42_id                   	VARCHAR(36)  		-- 42	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_42_numero               	INTEGER      		-- 43	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_42_nombre               	VARCHAR(50)  		-- 44	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_42_equate               	VARCHAR(30)  		-- 45	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_42_seguridadModulo      	VARCHAR(36)  		-- 46	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo
	, CuentaFondoGrupo_47_id                  	VARCHAR(36)  		-- 47	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_47_numero              	INTEGER      		-- 48	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_47_nombre              	VARCHAR(50)  		-- 49	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoRubro_50_id                  	VARCHAR(36)  		-- 50	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_50_numero              	INTEGER      		-- 51	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_50_nombre              	VARCHAR(50)  		-- 52	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre
	, CuentaFondoTipo_53_id                   	VARCHAR(36)  		-- 53	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_53_numero               	INTEGER      		-- 54	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_53_nombre               	VARCHAR(50)  		-- 55	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_6_obsoleto                  	BOOLEAN      		-- 56	ComprobanteFondoModeloItem.CuentaFondo.obsoleto
	, CuentaFondo_6_noImprimeCaja             	BOOLEAN      		-- 57	ComprobanteFondoModeloItem.CuentaFondo.noImprimeCaja
	, CuentaFondo_6_ventas                    	BOOLEAN      		-- 58	ComprobanteFondoModeloItem.CuentaFondo.ventas
	, CuentaFondo_6_fondos                    	BOOLEAN      		-- 59	ComprobanteFondoModeloItem.CuentaFondo.fondos
	, CuentaFondo_6_compras                   	BOOLEAN      		-- 60	ComprobanteFondoModeloItem.CuentaFondo.compras
	, Moneda_61_id                            	VARCHAR(36)  		-- 61	ComprobanteFondoModeloItem.CuentaFondo.Moneda.id
	, Moneda_61_numero                        	INTEGER      		-- 62	ComprobanteFondoModeloItem.CuentaFondo.Moneda.numero
	, Moneda_61_nombre                        	VARCHAR(50)  		-- 63	ComprobanteFondoModeloItem.CuentaFondo.Moneda.nombre
	, Moneda_61_abreviatura                   	VARCHAR(5)   		-- 64	ComprobanteFondoModeloItem.CuentaFondo.Moneda.abreviatura
	, Moneda_61_cotizacion                    	DECIMAL(13,5)		-- 65	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacion
	, Moneda_61_cotizacionFecha               	TIMESTAMP    		-- 66	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacionFecha
	, Moneda_61_controlActualizacion          	BOOLEAN      		-- 67	ComprobanteFondoModeloItem.CuentaFondo.Moneda.controlActualizacion
	, MonedaAFIP_68_id                        	VARCHAR(36)  		-- 68	ComprobanteFondoModeloItem.CuentaFondo.Moneda.MonedaAFIP.id
	, MonedaAFIP_68_codigo                    	VARCHAR(3)   		-- 69	ComprobanteFondoModeloItem.CuentaFondo.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_68_nombre                    	VARCHAR(50)  		-- 70	ComprobanteFondoModeloItem.CuentaFondo.Moneda.MonedaAFIP.nombre
	, Caja_71_id                              	VARCHAR(36)  		-- 71	ComprobanteFondoModeloItem.CuentaFondo.Caja.id
	, Caja_71_numero                          	INTEGER      		-- 72	ComprobanteFondoModeloItem.CuentaFondo.Caja.numero
	, Caja_71_nombre                          	VARCHAR(50)  		-- 73	ComprobanteFondoModeloItem.CuentaFondo.Caja.nombre
	, SeguridadPuerta_74_id                   	VARCHAR(36)  		-- 74	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.id
	, SeguridadPuerta_74_numero               	INTEGER      		-- 75	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.numero
	, SeguridadPuerta_74_nombre               	VARCHAR(50)  		-- 76	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_74_equate               	VARCHAR(30)  		-- 77	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.equate
	, SeguridadPuerta_74_seguridadModulo      	VARCHAR(36)  		-- 78	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.seguridadModulo
	, CuentaFondo_6_rechazados                	BOOLEAN      		-- 79	ComprobanteFondoModeloItem.CuentaFondo.rechazados
	, CuentaFondo_6_conciliacion              	BOOLEAN      		-- 80	ComprobanteFondoModeloItem.CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_81_id              	VARCHAR(36)  		-- 81	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_81_numero          	INTEGER      		-- 82	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_81_nombre          	VARCHAR(50)  		-- 83	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_84_id                             	VARCHAR(36)  		-- 84	ComprobanteFondoModeloItem.CuentaFondo.Banco.id
	, Banco_84_numero                         	INTEGER      		-- 85	ComprobanteFondoModeloItem.CuentaFondo.Banco.numero
	, Banco_84_nombre                         	VARCHAR(50)  		-- 86	ComprobanteFondoModeloItem.CuentaFondo.Banco.nombre
	, Banco_84_cuit                           	BIGINT       		-- 87	ComprobanteFondoModeloItem.CuentaFondo.Banco.cuit
	, Banco_84_bloqueado                      	BOOLEAN      		-- 88	ComprobanteFondoModeloItem.CuentaFondo.Banco.bloqueado
	, Banco_84_hoja                           	INTEGER      		-- 89	ComprobanteFondoModeloItem.CuentaFondo.Banco.hoja
	, Banco_84_primeraFila                    	INTEGER      		-- 90	ComprobanteFondoModeloItem.CuentaFondo.Banco.primeraFila
	, Banco_84_ultimaFila                     	INTEGER      		-- 91	ComprobanteFondoModeloItem.CuentaFondo.Banco.ultimaFila
	, Banco_84_fecha                          	VARCHAR(3)   		-- 92	ComprobanteFondoModeloItem.CuentaFondo.Banco.fecha
	, Banco_84_descripcion                    	VARCHAR(3)   		-- 93	ComprobanteFondoModeloItem.CuentaFondo.Banco.descripcion
	, Banco_84_referencia1                    	VARCHAR(3)   		-- 94	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia1
	, Banco_84_importe                        	VARCHAR(3)   		-- 95	ComprobanteFondoModeloItem.CuentaFondo.Banco.importe
	, Banco_84_referencia2                    	VARCHAR(3)   		-- 96	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia2
	, Banco_84_saldo                          	VARCHAR(3)   		-- 97	ComprobanteFondoModeloItem.CuentaFondo.Banco.saldo
	, CuentaFondo_6_cuentaBancaria            	VARCHAR(22)  		-- 98	ComprobanteFondoModeloItem.CuentaFondo.cuentaBancaria
	, CuentaFondo_6_cbu                       	VARCHAR(22)  		-- 99	ComprobanteFondoModeloItem.CuentaFondo.cbu
	, CuentaFondo_6_limiteDescubierto         	DECIMAL(13,5)		-- 100	ComprobanteFondoModeloItem.CuentaFondo.limiteDescubierto
	, CuentaFondo_6_cuentaFondoCaucion        	VARCHAR(50)  		-- 101	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_6_cuentaFondoDiferidos      	VARCHAR(50)  		-- 102	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_6_formato                   	VARCHAR(50)  		-- 103	ComprobanteFondoModeloItem.CuentaFondo.formato
	, CuentaFondoBancoCopia_104_id            	VARCHAR(36)  		-- 104	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_104_numero        	INTEGER      		-- 105	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_104_nombre        	VARCHAR(50)  		-- 106	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_6_limiteOperacionIndividual 	DECIMAL(13,5)		-- 107	ComprobanteFondoModeloItem.CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_108_id                  	VARCHAR(36)  		-- 108	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_108_numero              	INTEGER      		-- 109	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_108_nombre              	VARCHAR(50)  		-- 110	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_108_equate              	VARCHAR(30)  		-- 111	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_112_id                  	VARCHAR(36)  		-- 112	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_112_numero              	INTEGER      		-- 113	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_112_nombre              	VARCHAR(50)  		-- 114	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_115_id                  	VARCHAR(36)  		-- 115	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_115_numero              	INTEGER      		-- 116	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_115_nombre              	VARCHAR(50)  		-- 117	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_115_equate              	VARCHAR(30)  		-- 118	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_119_id                  	VARCHAR(36)  		-- 119	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_119_numero              	INTEGER      		-- 120	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_119_nombre              	VARCHAR(50)  		-- 121	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_122_id                  	VARCHAR(36)  		-- 122	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_122_numero              	INTEGER      		-- 123	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_122_nombre              	VARCHAR(50)  		-- 124	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_122_equate              	VARCHAR(30)  		-- 125	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_126_id                  	VARCHAR(36)  		-- 126	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_126_numero              	INTEGER      		-- 127	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_126_nombre              	VARCHAR(50)  		-- 128	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre

);