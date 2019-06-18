


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