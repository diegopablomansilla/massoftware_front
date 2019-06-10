


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Usuario



DROP FUNCTION IF EXISTS massoftware.f_Usuario (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Usuario (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.Usuario AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Usuario.id        AS Usuario_id    	-- 0	.id   		VARCHAR(36)
				, Usuario.numero    AS Usuario_numero	-- 1	.numero		INTEGER
				, Usuario.nombre    AS Usuario_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.Usuario

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Usuario.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Usuario.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Usuario.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Usuario.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_UsuarioById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_UsuarioById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Usuario AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Usuario ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona



DROP FUNCTION IF EXISTS massoftware.f_Zona (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3
	, codigoArg4    VARCHAR(3) 	-- 4
	, nombreArg5    VARCHAR(50)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3
	, codigoArg4    VARCHAR(3) 	-- 4
	, nombreArg5    VARCHAR(50)	-- 5

) RETURNS SETOF massoftware.Zona AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Zona.id              AS Zona_id          	-- 0	.id         		VARCHAR(36)
				, Zona.codigo          AS Zona_codigo      	-- 1	.codigo     		VARCHAR(3)
				, Zona.nombre          AS Zona_nombre      	-- 2	.nombre     		VARCHAR(50)
				, Zona.bonificacion    AS Zona_bonificacion	-- 3	.bonificacion		DECIMAL(13,5)
				, Zona.recargo         AS Zona_recargo     	-- 4	.recargo    		DECIMAL(13,5)

		FROM	massoftware.Zona

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Zona.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg4 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg4)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg4 = REPLACE(codigoArg4, '''', '''''');
		codigoArg4 = LOWER(TRIM(codigoArg4));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(Zona.codigo) = ''' || codigoArg4 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg5)) > 0 THEN
		nombreArg5 = REPLACE(nombreArg5, '''', '''''');
		nombreArg5 = LOWER(TRIM(nombreArg5));
		nombreArg5 = TRANSLATE(nombreArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Zona.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_ZonaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ZonaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Zona AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Zona ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais



DROP FUNCTION IF EXISTS massoftware.f_Pais (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7

) RETURNS SETOF massoftware.Pais AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Pais.id             AS Pais_id         	-- 0	.id        		VARCHAR(36)
				, Pais.numero         AS Pais_numero     	-- 1	.numero    		INTEGER
				, Pais.nombre         AS Pais_nombre     	-- 2	.nombre    		VARCHAR(50)
				, Pais.abreviatura    AS Pais_abreviatura	-- 3	.abreviatura		VARCHAR(5)

		FROM	massoftware.Pais

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Pais.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Pais.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Pais.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Pais.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg7)) > 0 THEN
		abreviaturaArg7 = REPLACE(abreviaturaArg7, '''', '''''');
		abreviaturaArg7 = LOWER(TRIM(abreviaturaArg7));
		abreviaturaArg7 = TRANSLATE(abreviaturaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Pais.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_PaisById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PaisById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Pais AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Pais ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia



DROP FUNCTION IF EXISTS massoftware.f_Provincia (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7
	, paisArg8          VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7
	, paisArg8          VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.Provincia AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Provincia.id                      AS Provincia_id                  	-- 0	.id                 		VARCHAR(36)
				, Provincia.numero                  AS Provincia_numero              	-- 1	.numero             		INTEGER
				, Provincia.nombre                  AS Provincia_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Provincia.abreviatura             AS Provincia_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Provincia.numeroAFIP              AS Provincia_numeroAFIP          	-- 4	.numeroAFIP         		INTEGER
				, Provincia.numeroIngresosBrutos    AS Provincia_numeroIngresosBrutos	-- 5	.numeroIngresosBrutos		INTEGER
				, Provincia.numeroRENATEA           AS Provincia_numeroRENATEA       	-- 6	.numeroRENATEA      		INTEGER
				, Provincia.pais                    AS Provincia_pais                	-- 7	.pais               		VARCHAR(36)	Pais.id

		FROM	massoftware.Provincia

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Provincia.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg7)) > 0 THEN
		abreviaturaArg7 = REPLACE(abreviaturaArg7, '''', '''''');
		abreviaturaArg7 = LOWER(TRIM(abreviaturaArg7));
		abreviaturaArg7 = TRANSLATE(abreviaturaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND paisArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(paisArg8)) > 0 THEN
		paisArg8 = REPLACE(paisArg8, '''', '''''');
		paisArg8 = LOWER(TRIM(paisArg8));
		paisArg8 = TRANSLATE(paisArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(paisArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.pais),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Provincia AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Provincia ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Provincia_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7
	, paisArg8          VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7
	, paisArg8          VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Provincia_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Provincia.id                      AS Provincia_id                  	-- 0	.id                 		VARCHAR(36)
				, Provincia.numero                  AS Provincia_numero              	-- 1	.numero             		INTEGER
				, Provincia.nombre                  AS Provincia_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Provincia.abreviatura             AS Provincia_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Provincia.numeroAFIP              AS Provincia_numeroAFIP          	-- 4	.numeroAFIP         		INTEGER
				, Provincia.numeroIngresosBrutos    AS Provincia_numeroIngresosBrutos	-- 5	.numeroIngresosBrutos		INTEGER
				, Provincia.numeroRENATEA           AS Provincia_numeroRENATEA       	-- 6	.numeroRENATEA      		INTEGER
				, Pais_7.id                         AS Pais_7_id                     	-- 7	.Pais.id            		VARCHAR(36)
				, Pais_7.numero                     AS Pais_7_numero                 	-- 8	.Pais.numero        		INTEGER
				, Pais_7.nombre                     AS Pais_7_nombre                 	-- 9	.Pais.nombre        		VARCHAR(50)
				, Pais_7.abreviatura                AS Pais_7_abreviatura            	-- 10	.Pais.abreviatura   		VARCHAR(5)

		FROM	massoftware.Provincia
			LEFT JOIN massoftware.Pais AS Pais_7        ON Provincia.pais = Pais_7.id 	-- 7 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Provincia.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg7)) > 0 THEN
		abreviaturaArg7 = REPLACE(abreviaturaArg7, '''', '''''');
		abreviaturaArg7 = LOWER(TRIM(abreviaturaArg7));
		abreviaturaArg7 = TRANSLATE(abreviaturaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND paisArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(paisArg8)) > 0 THEN
		paisArg8 = REPLACE(paisArg8, '''', '''''');
		paisArg8 = LOWER(TRIM(paisArg8));
		paisArg8 = TRANSLATE(paisArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(paisArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.pais),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Provincia_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Provincia_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad



DROP FUNCTION IF EXISTS massoftware.f_Ciudad (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6
	, provinciaArg7    VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6
	, provinciaArg7    VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.Ciudad AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Ciudad.id              AS Ciudad_id          	-- 0	.id         		VARCHAR(36)
				, Ciudad.numero          AS Ciudad_numero      	-- 1	.numero     		INTEGER
				, Ciudad.nombre          AS Ciudad_nombre      	-- 2	.nombre     		VARCHAR(50)
				, Ciudad.departamento    AS Ciudad_departamento	-- 3	.departamento		VARCHAR(50)
				, Ciudad.numeroAFIP      AS Ciudad_numeroAFIP  	-- 4	.numeroAFIP 		INTEGER
				, Ciudad.provincia       AS Ciudad_provincia   	-- 5	.provincia  		VARCHAR(36)	Provincia.id

		FROM	massoftware.Ciudad

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND provinciaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(provinciaArg7)) > 0 THEN
		provinciaArg7 = REPLACE(provinciaArg7, '''', '''''');
		provinciaArg7 = LOWER(TRIM(provinciaArg7));
		provinciaArg7 = TRANSLATE(provinciaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(provinciaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.provincia),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CiudadById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Ciudad AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ciudad ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Ciudad_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6
	, provinciaArg7    VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6
	, provinciaArg7    VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_Ciudad_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Ciudad.id                            AS Ciudad_id                       	-- 0	.id                           		VARCHAR(36)
				, Ciudad.numero                        AS Ciudad_numero                   	-- 1	.numero                       		INTEGER
				, Ciudad.nombre                        AS Ciudad_nombre                   	-- 2	.nombre                       		VARCHAR(50)
				, Ciudad.departamento                  AS Ciudad_departamento             	-- 3	.departamento                 		VARCHAR(50)
				, Ciudad.numeroAFIP                    AS Ciudad_numeroAFIP               	-- 4	.numeroAFIP                   		INTEGER
				, Provincia_5.id                       AS Provincia_5_id                  	-- 5	.Provincia.id                 		VARCHAR(36)
				, Provincia_5.numero                   AS Provincia_5_numero              	-- 6	.Provincia.numero             		INTEGER
				, Provincia_5.nombre                   AS Provincia_5_nombre              	-- 7	.Provincia.nombre             		VARCHAR(50)
				, Provincia_5.abreviatura              AS Provincia_5_abreviatura         	-- 8	.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_5.numeroAFIP               AS Provincia_5_numeroAFIP          	-- 9	.Provincia.numeroAFIP         		INTEGER
				, Provincia_5.numeroIngresosBrutos     AS Provincia_5_numeroIngresosBrutos	-- 10	.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_5.numeroRENATEA            AS Provincia_5_numeroRENATEA       	-- 11	.Provincia.numeroRENATEA      		INTEGER
				, Provincia_5.pais                     AS Provincia_5_pais                	-- 12	.Provincia.pais               		VARCHAR(36)	Pais.id

		FROM	massoftware.Ciudad
			LEFT JOIN massoftware.Provincia AS Provincia_5        ON Ciudad.provincia = Provincia_5.id 	-- 5 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND provinciaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(provinciaArg7)) > 0 THEN
		provinciaArg7 = REPLACE(provinciaArg7, '''', '''''');
		provinciaArg7 = LOWER(TRIM(provinciaArg7));
		provinciaArg7 = TRANSLATE(provinciaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(provinciaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.provincia),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CiudadById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Ciudad_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ciudad_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Ciudad_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6
	, provinciaArg7    VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6
	, provinciaArg7    VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_Ciudad_2 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Ciudad.id                            AS Ciudad_id                       	-- 0	.id                           		VARCHAR(36)
				, Ciudad.numero                        AS Ciudad_numero                   	-- 1	.numero                       		INTEGER
				, Ciudad.nombre                        AS Ciudad_nombre                   	-- 2	.nombre                       		VARCHAR(50)
				, Ciudad.departamento                  AS Ciudad_departamento             	-- 3	.departamento                 		VARCHAR(50)
				, Ciudad.numeroAFIP                    AS Ciudad_numeroAFIP               	-- 4	.numeroAFIP                   		INTEGER
				, Provincia_5.id                       AS Provincia_5_id                  	-- 5	.Provincia.id                 		VARCHAR(36)
				, Provincia_5.numero                   AS Provincia_5_numero              	-- 6	.Provincia.numero             		INTEGER
				, Provincia_5.nombre                   AS Provincia_5_nombre              	-- 7	.Provincia.nombre             		VARCHAR(50)
				, Provincia_5.abreviatura              AS Provincia_5_abreviatura         	-- 8	.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_5.numeroAFIP               AS Provincia_5_numeroAFIP          	-- 9	.Provincia.numeroAFIP         		INTEGER
				, Provincia_5.numeroIngresosBrutos     AS Provincia_5_numeroIngresosBrutos	-- 10	.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_5.numeroRENATEA            AS Provincia_5_numeroRENATEA       	-- 11	.Provincia.numeroRENATEA      		INTEGER
				, Pais_12.id                           AS Pais_12_id                      	-- 12	.Provincia.Pais.id            		VARCHAR(36)
				, Pais_12.numero                       AS Pais_12_numero                  	-- 13	.Provincia.Pais.numero        		INTEGER
				, Pais_12.nombre                       AS Pais_12_nombre                  	-- 14	.Provincia.Pais.nombre        		VARCHAR(50)
				, Pais_12.abreviatura                  AS Pais_12_abreviatura             	-- 15	.Provincia.Pais.abreviatura   		VARCHAR(5)

		FROM	massoftware.Ciudad
			LEFT JOIN massoftware.Provincia AS Provincia_5        ON Ciudad.provincia = Provincia_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.Pais AS Pais_12            ON Provincia_5.pais = Pais_12.id 	-- 12 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND provinciaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(provinciaArg7)) > 0 THEN
		provinciaArg7 = REPLACE(provinciaArg7, '''', '''''');
		provinciaArg7 = LOWER(TRIM(provinciaArg7));
		provinciaArg7 = TRANSLATE(provinciaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(provinciaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.provincia),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CiudadById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Ciudad_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ciudad_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal



DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.CodigoPostal AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  CodigoPostal.id             AS CodigoPostal_id         	-- 0	.id        		VARCHAR(36)
				, CodigoPostal.codigo         AS CodigoPostal_codigo     	-- 1	.codigo    		VARCHAR(12)
				, CodigoPostal.numero         AS CodigoPostal_numero     	-- 2	.numero    		INTEGER
				, CodigoPostal.nombreCalle    AS CodigoPostal_nombreCalle	-- 3	.nombreCalle		VARCHAR(200)
				, CodigoPostal.numeroCalle    AS CodigoPostal_numeroCalle	-- 4	.numeroCalle		VARCHAR(20)
				, CodigoPostal.ciudad         AS CodigoPostal_ciudad     	-- 5	.ciudad    		VARCHAR(36)	Ciudad.id

		FROM	massoftware.CodigoPostal

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg4 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg4)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg4 = REPLACE(codigoArg4, '''', '''''');
		codigoArg4 = LOWER(TRIM(codigoArg4));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg4 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg7)) > 0 THEN
		ciudadArg7 = REPLACE(ciudadArg7, '''', '''''');
		ciudadArg7 = LOWER(TRIM(ciudadArg7));
		ciudadArg7 = TRANSLATE(ciudadArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CodigoPostal AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_CodigoPostal_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  CodigoPostal.id             AS CodigoPostal_id         	-- 0	.id                		VARCHAR(36)
				, CodigoPostal.codigo         AS CodigoPostal_codigo     	-- 1	.codigo            		VARCHAR(12)
				, CodigoPostal.numero         AS CodigoPostal_numero     	-- 2	.numero            		INTEGER
				, CodigoPostal.nombreCalle    AS CodigoPostal_nombreCalle	-- 3	.nombreCalle       		VARCHAR(200)
				, CodigoPostal.numeroCalle    AS CodigoPostal_numeroCalle	-- 4	.numeroCalle       		VARCHAR(20)
				, Ciudad_5.id                 AS Ciudad_5_id             	-- 5	.Ciudad.id         		VARCHAR(36)
				, Ciudad_5.numero             AS Ciudad_5_numero         	-- 6	.Ciudad.numero     		INTEGER
				, Ciudad_5.nombre             AS Ciudad_5_nombre         	-- 7	.Ciudad.nombre     		VARCHAR(50)
				, Ciudad_5.departamento       AS Ciudad_5_departamento   	-- 8	.Ciudad.departamento		VARCHAR(50)
				, Ciudad_5.numeroAFIP         AS Ciudad_5_numeroAFIP     	-- 9	.Ciudad.numeroAFIP 		INTEGER
				, Ciudad_5.provincia          AS Ciudad_5_provincia      	-- 10	.Ciudad.provincia  		VARCHAR(36)	Provincia.id

		FROM	massoftware.CodigoPostal
			LEFT JOIN massoftware.Ciudad AS Ciudad_5        ON CodigoPostal.ciudad = Ciudad_5.id 	-- 5 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg4 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg4)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg4 = REPLACE(codigoArg4, '''', '''''');
		codigoArg4 = LOWER(TRIM(codigoArg4));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg4 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg7)) > 0 THEN
		ciudadArg7 = REPLACE(ciudadArg7, '''', '''''');
		ciudadArg7 = LOWER(TRIM(ciudadArg7));
		ciudadArg7 = TRANSLATE(ciudadArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CodigoPostal_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_CodigoPostal_2 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  CodigoPostal.id                       AS CodigoPostal_id                  	-- 0	.id                                  		VARCHAR(36)
				, CodigoPostal.codigo                   AS CodigoPostal_codigo              	-- 1	.codigo                              		VARCHAR(12)
				, CodigoPostal.numero                   AS CodigoPostal_numero              	-- 2	.numero                              		INTEGER
				, CodigoPostal.nombreCalle              AS CodigoPostal_nombreCalle         	-- 3	.nombreCalle                         		VARCHAR(200)
				, CodigoPostal.numeroCalle              AS CodigoPostal_numeroCalle         	-- 4	.numeroCalle                         		VARCHAR(20)
				, Ciudad_5.id                           AS Ciudad_5_id                      	-- 5	.Ciudad.id                           		VARCHAR(36)
				, Ciudad_5.numero                       AS Ciudad_5_numero                  	-- 6	.Ciudad.numero                       		INTEGER
				, Ciudad_5.nombre                       AS Ciudad_5_nombre                  	-- 7	.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_5.departamento                 AS Ciudad_5_departamento            	-- 8	.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_5.numeroAFIP                   AS Ciudad_5_numeroAFIP              	-- 9	.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_10.id                       AS Provincia_10_id                  	-- 10	.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_10.numero                   AS Provincia_10_numero              	-- 11	.Ciudad.Provincia.numero             		INTEGER
				, Provincia_10.nombre                   AS Provincia_10_nombre              	-- 12	.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_10.abreviatura              AS Provincia_10_abreviatura         	-- 13	.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_10.numeroAFIP               AS Provincia_10_numeroAFIP          	-- 14	.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_10.numeroIngresosBrutos     AS Provincia_10_numeroIngresosBrutos	-- 15	.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_10.numeroRENATEA            AS Provincia_10_numeroRENATEA       	-- 16	.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Provincia_10.pais                     AS Provincia_10_pais                	-- 17	.Ciudad.Provincia.pais               		VARCHAR(36)	Pais.id

		FROM	massoftware.CodigoPostal
			LEFT JOIN massoftware.Ciudad AS Ciudad_5               ON CodigoPostal.ciudad = Ciudad_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_10           ON Ciudad_5.provincia = Provincia_10.id 	-- 10 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg4 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg4)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg4 = REPLACE(codigoArg4, '''', '''''');
		codigoArg4 = LOWER(TRIM(codigoArg4));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg4 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg7)) > 0 THEN
		ciudadArg7 = REPLACE(ciudadArg7, '''', '''''');
		ciudadArg7 = LOWER(TRIM(ciudadArg7));
		ciudadArg7 = TRANSLATE(ciudadArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CodigoPostal_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_3 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_3 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, codigoArg4       VARCHAR(12)	-- 4
	, numeroFromArg5   INTEGER    	-- 5
	, numeroToArg6     INTEGER    	-- 6
	, ciudadArg7       VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_CodigoPostal_3 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  CodigoPostal.id                       AS CodigoPostal_id                  	-- 0	.id                                  		VARCHAR(36)
				, CodigoPostal.codigo                   AS CodigoPostal_codigo              	-- 1	.codigo                              		VARCHAR(12)
				, CodigoPostal.numero                   AS CodigoPostal_numero              	-- 2	.numero                              		INTEGER
				, CodigoPostal.nombreCalle              AS CodigoPostal_nombreCalle         	-- 3	.nombreCalle                         		VARCHAR(200)
				, CodigoPostal.numeroCalle              AS CodigoPostal_numeroCalle         	-- 4	.numeroCalle                         		VARCHAR(20)
				, Ciudad_5.id                           AS Ciudad_5_id                      	-- 5	.Ciudad.id                           		VARCHAR(36)
				, Ciudad_5.numero                       AS Ciudad_5_numero                  	-- 6	.Ciudad.numero                       		INTEGER
				, Ciudad_5.nombre                       AS Ciudad_5_nombre                  	-- 7	.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_5.departamento                 AS Ciudad_5_departamento            	-- 8	.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_5.numeroAFIP                   AS Ciudad_5_numeroAFIP              	-- 9	.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_10.id                       AS Provincia_10_id                  	-- 10	.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_10.numero                   AS Provincia_10_numero              	-- 11	.Ciudad.Provincia.numero             		INTEGER
				, Provincia_10.nombre                   AS Provincia_10_nombre              	-- 12	.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_10.abreviatura              AS Provincia_10_abreviatura         	-- 13	.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_10.numeroAFIP               AS Provincia_10_numeroAFIP          	-- 14	.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_10.numeroIngresosBrutos     AS Provincia_10_numeroIngresosBrutos	-- 15	.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_10.numeroRENATEA            AS Provincia_10_numeroRENATEA       	-- 16	.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Pais_17.id                            AS Pais_17_id                       	-- 17	.Ciudad.Provincia.Pais.id            		VARCHAR(36)
				, Pais_17.numero                        AS Pais_17_numero                   	-- 18	.Ciudad.Provincia.Pais.numero        		INTEGER
				, Pais_17.nombre                        AS Pais_17_nombre                   	-- 19	.Ciudad.Provincia.Pais.nombre        		VARCHAR(50)
				, Pais_17.abreviatura                   AS Pais_17_abreviatura              	-- 20	.Ciudad.Provincia.Pais.abreviatura   		VARCHAR(5)

		FROM	massoftware.CodigoPostal
			LEFT JOIN massoftware.Ciudad AS Ciudad_5               ON CodigoPostal.ciudad = Ciudad_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_10           ON Ciudad_5.provincia = Provincia_10.id 	-- 10 LEFT LEVEL: 2
					LEFT JOIN massoftware.Pais AS Pais_17               ON Provincia_10.pais = Pais_17.id 	-- 17 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg4 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg4)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg4 = REPLACE(codigoArg4, '''', '''''');
		codigoArg4 = LOWER(TRIM(codigoArg4));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg4 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg7)) > 0 THEN
		ciudadArg7 = REPLACE(ciudadArg7, '''', '''''');
		ciudadArg7 = LOWER(TRIM(ciudadArg7));
		ciudadArg7 = TRANSLATE(ciudadArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CodigoPostal_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal_3 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte



DROP FUNCTION IF EXISTS massoftware.f_Transporte (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.Transporte AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                AS Transporte_id            	-- 0	.id           		VARCHAR(36)
				, Transporte.numero            AS Transporte_numero        	-- 1	.numero       		INTEGER
				, Transporte.nombre            AS Transporte_nombre        	-- 2	.nombre       		VARCHAR(50)
				, Transporte.cuit              AS Transporte_cuit          	-- 3	.cuit         		BIGINT
				, Transporte.ingresosBrutos    AS Transporte_ingresosBrutos	-- 4	.ingresosBrutos		VARCHAR(13)
				, Transporte.telefono          AS Transporte_telefono      	-- 5	.telefono     		VARCHAR(50)
				, Transporte.fax               AS Transporte_fax           	-- 6	.fax          		VARCHAR(50)
				, Transporte.codigoPostal      AS Transporte_codigoPostal  	-- 7	.codigoPostal 		VARCHAR(36)	CodigoPostal.id
				, Transporte.domicilio         AS Transporte_domicilio     	-- 8	.domicilio    		VARCHAR(150)
				, Transporte.comentario        AS Transporte_comentario    	-- 9	.comentario   		VARCHAR(300)

		FROM	massoftware.Transporte

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Transporte AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Transporte_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.t_Transporte_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                  AS Transporte_id             	-- 0	.id                     		VARCHAR(36)
				, Transporte.numero              AS Transporte_numero         	-- 1	.numero                 		INTEGER
				, Transporte.nombre              AS Transporte_nombre         	-- 2	.nombre                 		VARCHAR(50)
				, Transporte.cuit                AS Transporte_cuit           	-- 3	.cuit                   		BIGINT
				, Transporte.ingresosBrutos      AS Transporte_ingresosBrutos 	-- 4	.ingresosBrutos         		VARCHAR(13)
				, Transporte.telefono            AS Transporte_telefono       	-- 5	.telefono               		VARCHAR(50)
				, Transporte.fax                 AS Transporte_fax            	-- 6	.fax                    		VARCHAR(50)
				, CodigoPostal_7.id              AS CodigoPostal_7_id         	-- 7	.CodigoPostal.id        		VARCHAR(36)
				, CodigoPostal_7.codigo          AS CodigoPostal_7_codigo     	-- 8	.CodigoPostal.codigo    		VARCHAR(12)
				, CodigoPostal_7.numero          AS CodigoPostal_7_numero     	-- 9	.CodigoPostal.numero    		INTEGER
				, CodigoPostal_7.nombreCalle     AS CodigoPostal_7_nombreCalle	-- 10	.CodigoPostal.nombreCalle		VARCHAR(200)
				, CodigoPostal_7.numeroCalle     AS CodigoPostal_7_numeroCalle	-- 11	.CodigoPostal.numeroCalle		VARCHAR(20)
				, CodigoPostal_7.ciudad          AS CodigoPostal_7_ciudad     	-- 12	.CodigoPostal.ciudad    		VARCHAR(36)	Ciudad.id
				, Transporte.domicilio           AS Transporte_domicilio      	-- 13	.domicilio              		VARCHAR(150)
				, Transporte.comentario          AS Transporte_comentario     	-- 14	.comentario             		VARCHAR(300)

		FROM	massoftware.Transporte
			LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_7        ON Transporte.codigoPostal = CodigoPostal_7.id 	-- 7 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Transporte_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte_1 ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Transporte_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.t_Transporte_2 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                  AS Transporte_id             	-- 0	.id                             		VARCHAR(36)
				, Transporte.numero              AS Transporte_numero         	-- 1	.numero                         		INTEGER
				, Transporte.nombre              AS Transporte_nombre         	-- 2	.nombre                         		VARCHAR(50)
				, Transporte.cuit                AS Transporte_cuit           	-- 3	.cuit                           		BIGINT
				, Transporte.ingresosBrutos      AS Transporte_ingresosBrutos 	-- 4	.ingresosBrutos                 		VARCHAR(13)
				, Transporte.telefono            AS Transporte_telefono       	-- 5	.telefono                       		VARCHAR(50)
				, Transporte.fax                 AS Transporte_fax            	-- 6	.fax                            		VARCHAR(50)
				, CodigoPostal_7.id              AS CodigoPostal_7_id         	-- 7	.CodigoPostal.id                		VARCHAR(36)
				, CodigoPostal_7.codigo          AS CodigoPostal_7_codigo     	-- 8	.CodigoPostal.codigo            		VARCHAR(12)
				, CodigoPostal_7.numero          AS CodigoPostal_7_numero     	-- 9	.CodigoPostal.numero            		INTEGER
				, CodigoPostal_7.nombreCalle     AS CodigoPostal_7_nombreCalle	-- 10	.CodigoPostal.nombreCalle       		VARCHAR(200)
				, CodigoPostal_7.numeroCalle     AS CodigoPostal_7_numeroCalle	-- 11	.CodigoPostal.numeroCalle       		VARCHAR(20)
				, Ciudad_12.id                   AS Ciudad_12_id              	-- 12	.CodigoPostal.Ciudad.id         		VARCHAR(36)
				, Ciudad_12.numero               AS Ciudad_12_numero          	-- 13	.CodigoPostal.Ciudad.numero     		INTEGER
				, Ciudad_12.nombre               AS Ciudad_12_nombre          	-- 14	.CodigoPostal.Ciudad.nombre     		VARCHAR(50)
				, Ciudad_12.departamento         AS Ciudad_12_departamento    	-- 15	.CodigoPostal.Ciudad.departamento		VARCHAR(50)
				, Ciudad_12.numeroAFIP           AS Ciudad_12_numeroAFIP      	-- 16	.CodigoPostal.Ciudad.numeroAFIP 		INTEGER
				, Ciudad_12.provincia            AS Ciudad_12_provincia       	-- 17	.CodigoPostal.Ciudad.provincia  		VARCHAR(36)	Provincia.id
				, Transporte.domicilio           AS Transporte_domicilio      	-- 18	.domicilio                      		VARCHAR(150)
				, Transporte.comentario          AS Transporte_comentario     	-- 19	.comentario                     		VARCHAR(300)

		FROM	massoftware.Transporte
			LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_7        ON Transporte.codigoPostal = CodigoPostal_7.id 	-- 7 LEFT LEVEL: 1
				LEFT JOIN massoftware.Ciudad AS Ciudad_12             ON CodigoPostal_7.ciudad = Ciudad_12.id 	-- 12 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Transporte_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte_2 ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Transporte_3 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_3 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.t_Transporte_3 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                         AS Transporte_id                    	-- 0	.id                                               		VARCHAR(36)
				, Transporte.numero                     AS Transporte_numero                	-- 1	.numero                                           		INTEGER
				, Transporte.nombre                     AS Transporte_nombre                	-- 2	.nombre                                           		VARCHAR(50)
				, Transporte.cuit                       AS Transporte_cuit                  	-- 3	.cuit                                             		BIGINT
				, Transporte.ingresosBrutos             AS Transporte_ingresosBrutos        	-- 4	.ingresosBrutos                                   		VARCHAR(13)
				, Transporte.telefono                   AS Transporte_telefono              	-- 5	.telefono                                         		VARCHAR(50)
				, Transporte.fax                        AS Transporte_fax                   	-- 6	.fax                                              		VARCHAR(50)
				, CodigoPostal_7.id                     AS CodigoPostal_7_id                	-- 7	.CodigoPostal.id                                  		VARCHAR(36)
				, CodigoPostal_7.codigo                 AS CodigoPostal_7_codigo            	-- 8	.CodigoPostal.codigo                              		VARCHAR(12)
				, CodigoPostal_7.numero                 AS CodigoPostal_7_numero            	-- 9	.CodigoPostal.numero                              		INTEGER
				, CodigoPostal_7.nombreCalle            AS CodigoPostal_7_nombreCalle       	-- 10	.CodigoPostal.nombreCalle                         		VARCHAR(200)
				, CodigoPostal_7.numeroCalle            AS CodigoPostal_7_numeroCalle       	-- 11	.CodigoPostal.numeroCalle                         		VARCHAR(20)
				, Ciudad_12.id                          AS Ciudad_12_id                     	-- 12	.CodigoPostal.Ciudad.id                           		VARCHAR(36)
				, Ciudad_12.numero                      AS Ciudad_12_numero                 	-- 13	.CodigoPostal.Ciudad.numero                       		INTEGER
				, Ciudad_12.nombre                      AS Ciudad_12_nombre                 	-- 14	.CodigoPostal.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_12.departamento                AS Ciudad_12_departamento           	-- 15	.CodigoPostal.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_12.numeroAFIP                  AS Ciudad_12_numeroAFIP             	-- 16	.CodigoPostal.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_17.id                       AS Provincia_17_id                  	-- 17	.CodigoPostal.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_17.numero                   AS Provincia_17_numero              	-- 18	.CodigoPostal.Ciudad.Provincia.numero             		INTEGER
				, Provincia_17.nombre                   AS Provincia_17_nombre              	-- 19	.CodigoPostal.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_17.abreviatura              AS Provincia_17_abreviatura         	-- 20	.CodigoPostal.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_17.numeroAFIP               AS Provincia_17_numeroAFIP          	-- 21	.CodigoPostal.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_17.numeroIngresosBrutos     AS Provincia_17_numeroIngresosBrutos	-- 22	.CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_17.numeroRENATEA            AS Provincia_17_numeroRENATEA       	-- 23	.CodigoPostal.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Provincia_17.pais                     AS Provincia_17_pais                	-- 24	.CodigoPostal.Ciudad.Provincia.pais               		VARCHAR(36)	Pais.id
				, Transporte.domicilio                  AS Transporte_domicilio             	-- 25	.domicilio                                        		VARCHAR(150)
				, Transporte.comentario                 AS Transporte_comentario            	-- 26	.comentario                                       		VARCHAR(300)

		FROM	massoftware.Transporte
			LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_7            ON Transporte.codigoPostal = CodigoPostal_7.id 	-- 7 LEFT LEVEL: 1
				LEFT JOIN massoftware.Ciudad AS Ciudad_12                 ON CodigoPostal_7.ciudad = Ciudad_12.id 	-- 12 LEFT LEVEL: 2
					LEFT JOIN massoftware.Provincia AS Provincia_17             ON Ciudad_12.provincia = Provincia_17.id 	-- 17 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Transporte_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte_3 ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga



DROP FUNCTION IF EXISTS massoftware.f_Carga (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.Carga AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Carga.id            AS Carga_id        	-- 0	.id       		VARCHAR(36)
				, Carga.numero        AS Carga_numero    	-- 1	.numero   		INTEGER
				, Carga.nombre        AS Carga_nombre    	-- 2	.nombre   		VARCHAR(50)
				, Carga.transporte    AS Carga_transporte	-- 3	.transporte		VARCHAR(36)	Transporte.id

		FROM	massoftware.Carga

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CargaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Carga AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Carga_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_1 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.t_Carga_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Carga.id                       AS Carga_id                   	-- 0	.id                      		VARCHAR(36)
				, Carga.numero                   AS Carga_numero               	-- 1	.numero                  		INTEGER
				, Carga.nombre                   AS Carga_nombre               	-- 2	.nombre                  		VARCHAR(50)
				, Transporte_3.id                AS Transporte_3_id            	-- 3	.Transporte.id           		VARCHAR(36)
				, Transporte_3.numero            AS Transporte_3_numero        	-- 4	.Transporte.numero       		INTEGER
				, Transporte_3.nombre            AS Transporte_3_nombre        	-- 5	.Transporte.nombre       		VARCHAR(50)
				, Transporte_3.cuit              AS Transporte_3_cuit          	-- 6	.Transporte.cuit         		BIGINT
				, Transporte_3.ingresosBrutos    AS Transporte_3_ingresosBrutos	-- 7	.Transporte.ingresosBrutos		VARCHAR(13)
				, Transporte_3.telefono          AS Transporte_3_telefono      	-- 8	.Transporte.telefono     		VARCHAR(50)
				, Transporte_3.fax               AS Transporte_3_fax           	-- 9	.Transporte.fax          		VARCHAR(50)
				, Transporte_3.codigoPostal      AS Transporte_3_codigoPostal  	-- 10	.Transporte.codigoPostal 		VARCHAR(36)	CodigoPostal.id
				, Transporte_3.domicilio         AS Transporte_3_domicilio     	-- 11	.Transporte.domicilio    		VARCHAR(150)
				, Transporte_3.comentario        AS Transporte_3_comentario    	-- 12	.Transporte.comentario   		VARCHAR(300)

		FROM	massoftware.Carga
			LEFT JOIN massoftware.Transporte AS Transporte_3        ON Carga.transporte = Transporte_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CargaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Carga_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga_1 ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Carga_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_2 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.t_Carga_2 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Carga.id                        AS Carga_id                   	-- 0	.id                                		VARCHAR(36)
				, Carga.numero                    AS Carga_numero               	-- 1	.numero                            		INTEGER
				, Carga.nombre                    AS Carga_nombre               	-- 2	.nombre                            		VARCHAR(50)
				, Transporte_3.id                 AS Transporte_3_id            	-- 3	.Transporte.id                     		VARCHAR(36)
				, Transporte_3.numero             AS Transporte_3_numero        	-- 4	.Transporte.numero                 		INTEGER
				, Transporte_3.nombre             AS Transporte_3_nombre        	-- 5	.Transporte.nombre                 		VARCHAR(50)
				, Transporte_3.cuit               AS Transporte_3_cuit          	-- 6	.Transporte.cuit                   		BIGINT
				, Transporte_3.ingresosBrutos     AS Transporte_3_ingresosBrutos	-- 7	.Transporte.ingresosBrutos         		VARCHAR(13)
				, Transporte_3.telefono           AS Transporte_3_telefono      	-- 8	.Transporte.telefono               		VARCHAR(50)
				, Transporte_3.fax                AS Transporte_3_fax           	-- 9	.Transporte.fax                    		VARCHAR(50)
				, CodigoPostal_10.id              AS CodigoPostal_10_id         	-- 10	.Transporte.CodigoPostal.id        		VARCHAR(36)
				, CodigoPostal_10.codigo          AS CodigoPostal_10_codigo     	-- 11	.Transporte.CodigoPostal.codigo    		VARCHAR(12)
				, CodigoPostal_10.numero          AS CodigoPostal_10_numero     	-- 12	.Transporte.CodigoPostal.numero    		INTEGER
				, CodigoPostal_10.nombreCalle     AS CodigoPostal_10_nombreCalle	-- 13	.Transporte.CodigoPostal.nombreCalle		VARCHAR(200)
				, CodigoPostal_10.numeroCalle     AS CodigoPostal_10_numeroCalle	-- 14	.Transporte.CodigoPostal.numeroCalle		VARCHAR(20)
				, CodigoPostal_10.ciudad          AS CodigoPostal_10_ciudad     	-- 15	.Transporte.CodigoPostal.ciudad    		VARCHAR(36)	Ciudad.id
				, Transporte_3.domicilio          AS Transporte_3_domicilio     	-- 16	.Transporte.domicilio              		VARCHAR(150)
				, Transporte_3.comentario         AS Transporte_3_comentario    	-- 17	.Transporte.comentario             		VARCHAR(300)

		FROM	massoftware.Carga
			LEFT JOIN massoftware.Transporte AS Transporte_3              ON Carga.transporte = Transporte_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_10           ON Transporte_3.codigoPostal = CodigoPostal_10.id 	-- 10 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CargaById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Carga_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga_2 ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Carga_3 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_3 (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.t_Carga_3 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Carga.id                        AS Carga_id                   	-- 0	.id                                        		VARCHAR(36)
				, Carga.numero                    AS Carga_numero               	-- 1	.numero                                    		INTEGER
				, Carga.nombre                    AS Carga_nombre               	-- 2	.nombre                                    		VARCHAR(50)
				, Transporte_3.id                 AS Transporte_3_id            	-- 3	.Transporte.id                             		VARCHAR(36)
				, Transporte_3.numero             AS Transporte_3_numero        	-- 4	.Transporte.numero                         		INTEGER
				, Transporte_3.nombre             AS Transporte_3_nombre        	-- 5	.Transporte.nombre                         		VARCHAR(50)
				, Transporte_3.cuit               AS Transporte_3_cuit          	-- 6	.Transporte.cuit                           		BIGINT
				, Transporte_3.ingresosBrutos     AS Transporte_3_ingresosBrutos	-- 7	.Transporte.ingresosBrutos                 		VARCHAR(13)
				, Transporte_3.telefono           AS Transporte_3_telefono      	-- 8	.Transporte.telefono                       		VARCHAR(50)
				, Transporte_3.fax                AS Transporte_3_fax           	-- 9	.Transporte.fax                            		VARCHAR(50)
				, CodigoPostal_10.id              AS CodigoPostal_10_id         	-- 10	.Transporte.CodigoPostal.id                		VARCHAR(36)
				, CodigoPostal_10.codigo          AS CodigoPostal_10_codigo     	-- 11	.Transporte.CodigoPostal.codigo            		VARCHAR(12)
				, CodigoPostal_10.numero          AS CodigoPostal_10_numero     	-- 12	.Transporte.CodigoPostal.numero            		INTEGER
				, CodigoPostal_10.nombreCalle     AS CodigoPostal_10_nombreCalle	-- 13	.Transporte.CodigoPostal.nombreCalle       		VARCHAR(200)
				, CodigoPostal_10.numeroCalle     AS CodigoPostal_10_numeroCalle	-- 14	.Transporte.CodigoPostal.numeroCalle       		VARCHAR(20)
				, Ciudad_15.id                    AS Ciudad_15_id               	-- 15	.Transporte.CodigoPostal.Ciudad.id         		VARCHAR(36)
				, Ciudad_15.numero                AS Ciudad_15_numero           	-- 16	.Transporte.CodigoPostal.Ciudad.numero     		INTEGER
				, Ciudad_15.nombre                AS Ciudad_15_nombre           	-- 17	.Transporte.CodigoPostal.Ciudad.nombre     		VARCHAR(50)
				, Ciudad_15.departamento          AS Ciudad_15_departamento     	-- 18	.Transporte.CodigoPostal.Ciudad.departamento		VARCHAR(50)
				, Ciudad_15.numeroAFIP            AS Ciudad_15_numeroAFIP       	-- 19	.Transporte.CodigoPostal.Ciudad.numeroAFIP 		INTEGER
				, Ciudad_15.provincia             AS Ciudad_15_provincia        	-- 20	.Transporte.CodigoPostal.Ciudad.provincia  		VARCHAR(36)	Provincia.id
				, Transporte_3.domicilio          AS Transporte_3_domicilio     	-- 21	.Transporte.domicilio                      		VARCHAR(150)
				, Transporte_3.comentario         AS Transporte_3_comentario    	-- 22	.Transporte.comentario                     		VARCHAR(300)

		FROM	massoftware.Carga
			LEFT JOIN massoftware.Transporte AS Transporte_3              ON Carga.transporte = Transporte_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_10           ON Transporte_3.codigoPostal = CodigoPostal_10.id 	-- 10 LEFT LEVEL: 2
					LEFT JOIN massoftware.Ciudad AS Ciudad_15                ON CodigoPostal_10.ciudad = Ciudad_15.id 	-- 15 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_CargaById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Carga_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga_3 ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa



DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) RETURNS SETOF massoftware.TransporteTarifa AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  TransporteTarifa.id                         AS TransporteTarifa_id                     	-- 0	.id                    		VARCHAR(36)
				, TransporteTarifa.numero                     AS TransporteTarifa_numero                 	-- 1	.numero                		INTEGER
				, TransporteTarifa.carga                      AS TransporteTarifa_carga                  	-- 2	.carga                 		VARCHAR(36)	Carga.id
				, TransporteTarifa.ciudad                     AS TransporteTarifa_ciudad                 	-- 3	.ciudad                		VARCHAR(36)	Ciudad.id
				, TransporteTarifa.precioFlete                AS TransporteTarifa_precioFlete            	-- 4	.precioFlete           		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion    AS TransporteTarifa_precioUnidadFacturacion	-- 5	.precioUnidadFacturacion		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock          AS TransporteTarifa_precioUnidadStock      	-- 6	.precioUnidadStock     		DECIMAL(13,5)
				, TransporteTarifa.precioBultos               AS TransporteTarifa_precioBultos           	-- 7	.precioBultos          		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega       AS TransporteTarifa_importeMinimoEntrega   	-- 8	.importeMinimoEntrega  		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga         AS TransporteTarifa_importeMinimoCarga     	-- 9	.importeMinimoCarga    		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TransporteTarifa AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa ( idArg , null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_1 (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_1 (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) RETURNS SETOF massoftware.t_TransporteTarifa_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                    		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id              		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero          		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre          		VARCHAR(50)
				, Carga_2.transporte                           AS Carga_2_transporte                      	-- 5	.Carga.transporte      		VARCHAR(36)	Transporte.id
				, Ciudad_6.id                                  AS Ciudad_6_id                             	-- 6	.Ciudad.id             		VARCHAR(36)
				, Ciudad_6.numero                              AS Ciudad_6_numero                         	-- 7	.Ciudad.numero         		INTEGER
				, Ciudad_6.nombre                              AS Ciudad_6_nombre                         	-- 8	.Ciudad.nombre         		VARCHAR(50)
				, Ciudad_6.departamento                        AS Ciudad_6_departamento                   	-- 9	.Ciudad.departamento   		VARCHAR(50)
				, Ciudad_6.numeroAFIP                          AS Ciudad_6_numeroAFIP                     	-- 10	.Ciudad.numeroAFIP     		INTEGER
				, Ciudad_6.provincia                           AS Ciudad_6_provincia                      	-- 11	.Ciudad.provincia      		VARCHAR(36)	Provincia.id
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 12	.precioFlete           		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 13	.precioUnidadFacturacion		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 14	.precioUnidadStock     		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 15	.precioBultos          		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 16	.importeMinimoEntrega  		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 17	.importeMinimoCarga    		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2         ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
			LEFT JOIN massoftware.Ciudad AS Ciudad_6        ON TransporteTarifa.ciudad = Ciudad_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_1 ( idArg , null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_2 (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_2 (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) RETURNS SETOF massoftware.t_TransporteTarifa_2 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                                  		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                              		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id                            		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero                        		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre                        		VARCHAR(50)
				, Transporte_5.id                              AS Transporte_5_id                         	-- 5	.Carga.Transporte.id                 		VARCHAR(36)
				, Transporte_5.numero                          AS Transporte_5_numero                     	-- 6	.Carga.Transporte.numero             		INTEGER
				, Transporte_5.nombre                          AS Transporte_5_nombre                     	-- 7	.Carga.Transporte.nombre             		VARCHAR(50)
				, Transporte_5.cuit                            AS Transporte_5_cuit                       	-- 8	.Carga.Transporte.cuit               		BIGINT
				, Transporte_5.ingresosBrutos                  AS Transporte_5_ingresosBrutos             	-- 9	.Carga.Transporte.ingresosBrutos     		VARCHAR(13)
				, Transporte_5.telefono                        AS Transporte_5_telefono                   	-- 10	.Carga.Transporte.telefono           		VARCHAR(50)
				, Transporte_5.fax                             AS Transporte_5_fax                        	-- 11	.Carga.Transporte.fax                		VARCHAR(50)
				, Transporte_5.codigoPostal                    AS Transporte_5_codigoPostal               	-- 12	.Carga.Transporte.codigoPostal       		VARCHAR(36)	CodigoPostal.id
				, Transporte_5.domicilio                       AS Transporte_5_domicilio                  	-- 13	.Carga.Transporte.domicilio          		VARCHAR(150)
				, Transporte_5.comentario                      AS Transporte_5_comentario                 	-- 14	.Carga.Transporte.comentario         		VARCHAR(300)
				, Ciudad_15.id                                 AS Ciudad_15_id                            	-- 15	.Ciudad.id                           		VARCHAR(36)
				, Ciudad_15.numero                             AS Ciudad_15_numero                        	-- 16	.Ciudad.numero                       		INTEGER
				, Ciudad_15.nombre                             AS Ciudad_15_nombre                        	-- 17	.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_15.departamento                       AS Ciudad_15_departamento                  	-- 18	.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_15.numeroAFIP                         AS Ciudad_15_numeroAFIP                    	-- 19	.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_20.id                              AS Provincia_20_id                         	-- 20	.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_20.numero                          AS Provincia_20_numero                     	-- 21	.Ciudad.Provincia.numero             		INTEGER
				, Provincia_20.nombre                          AS Provincia_20_nombre                     	-- 22	.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_20.abreviatura                     AS Provincia_20_abreviatura                	-- 23	.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_20.numeroAFIP                      AS Provincia_20_numeroAFIP                 	-- 24	.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_20.numeroIngresosBrutos            AS Provincia_20_numeroIngresosBrutos       	-- 25	.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_20.numeroRENATEA                   AS Provincia_20_numeroRENATEA              	-- 26	.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Provincia_20.pais                            AS Provincia_20_pais                       	-- 27	.Ciudad.Provincia.pais               		VARCHAR(36)	Pais.id
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 28	.precioFlete                         		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 29	.precioUnidadFacturacion             		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 30	.precioUnidadStock                   		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 31	.precioBultos                        		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 32	.importeMinimoEntrega                		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 33	.importeMinimoCarga                  		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2                ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.Transporte AS Transporte_5           ON Carga_2.transporte = Transporte_5.id 	-- 5 LEFT LEVEL: 2
			LEFT JOIN massoftware.Ciudad AS Ciudad_15               ON TransporteTarifa.ciudad = Ciudad_15.id 	-- 15 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_20           ON Ciudad_15.provincia = Provincia_20.id 	-- 20 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_2 ( idArg , null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_3 (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_3 (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3

) RETURNS SETOF massoftware.t_TransporteTarifa_3 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                                      		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                                  		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id                                		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero                            		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre                            		VARCHAR(50)
				, Transporte_5.id                              AS Transporte_5_id                         	-- 5	.Carga.Transporte.id                     		VARCHAR(36)
				, Transporte_5.numero                          AS Transporte_5_numero                     	-- 6	.Carga.Transporte.numero                 		INTEGER
				, Transporte_5.nombre                          AS Transporte_5_nombre                     	-- 7	.Carga.Transporte.nombre                 		VARCHAR(50)
				, Transporte_5.cuit                            AS Transporte_5_cuit                       	-- 8	.Carga.Transporte.cuit                   		BIGINT
				, Transporte_5.ingresosBrutos                  AS Transporte_5_ingresosBrutos             	-- 9	.Carga.Transporte.ingresosBrutos         		VARCHAR(13)
				, Transporte_5.telefono                        AS Transporte_5_telefono                   	-- 10	.Carga.Transporte.telefono               		VARCHAR(50)
				, Transporte_5.fax                             AS Transporte_5_fax                        	-- 11	.Carga.Transporte.fax                    		VARCHAR(50)
				, CodigoPostal_12.id                           AS CodigoPostal_12_id                      	-- 12	.Carga.Transporte.CodigoPostal.id        		VARCHAR(36)
				, CodigoPostal_12.codigo                       AS CodigoPostal_12_codigo                  	-- 13	.Carga.Transporte.CodigoPostal.codigo    		VARCHAR(12)
				, CodigoPostal_12.numero                       AS CodigoPostal_12_numero                  	-- 14	.Carga.Transporte.CodigoPostal.numero    		INTEGER
				, CodigoPostal_12.nombreCalle                  AS CodigoPostal_12_nombreCalle             	-- 15	.Carga.Transporte.CodigoPostal.nombreCalle		VARCHAR(200)
				, CodigoPostal_12.numeroCalle                  AS CodigoPostal_12_numeroCalle             	-- 16	.Carga.Transporte.CodigoPostal.numeroCalle		VARCHAR(20)
				, CodigoPostal_12.ciudad                       AS CodigoPostal_12_ciudad                  	-- 17	.Carga.Transporte.CodigoPostal.ciudad    		VARCHAR(36)	Ciudad.id
				, Transporte_5.domicilio                       AS Transporte_5_domicilio                  	-- 18	.Carga.Transporte.domicilio              		VARCHAR(150)
				, Transporte_5.comentario                      AS Transporte_5_comentario                 	-- 19	.Carga.Transporte.comentario             		VARCHAR(300)
				, Ciudad_20.id                                 AS Ciudad_20_id                            	-- 20	.Ciudad.id                               		VARCHAR(36)
				, Ciudad_20.numero                             AS Ciudad_20_numero                        	-- 21	.Ciudad.numero                           		INTEGER
				, Ciudad_20.nombre                             AS Ciudad_20_nombre                        	-- 22	.Ciudad.nombre                           		VARCHAR(50)
				, Ciudad_20.departamento                       AS Ciudad_20_departamento                  	-- 23	.Ciudad.departamento                     		VARCHAR(50)
				, Ciudad_20.numeroAFIP                         AS Ciudad_20_numeroAFIP                    	-- 24	.Ciudad.numeroAFIP                       		INTEGER
				, Provincia_25.id                              AS Provincia_25_id                         	-- 25	.Ciudad.Provincia.id                     		VARCHAR(36)
				, Provincia_25.numero                          AS Provincia_25_numero                     	-- 26	.Ciudad.Provincia.numero                 		INTEGER
				, Provincia_25.nombre                          AS Provincia_25_nombre                     	-- 27	.Ciudad.Provincia.nombre                 		VARCHAR(50)
				, Provincia_25.abreviatura                     AS Provincia_25_abreviatura                	-- 28	.Ciudad.Provincia.abreviatura            		VARCHAR(5)
				, Provincia_25.numeroAFIP                      AS Provincia_25_numeroAFIP                 	-- 29	.Ciudad.Provincia.numeroAFIP             		INTEGER
				, Provincia_25.numeroIngresosBrutos            AS Provincia_25_numeroIngresosBrutos       	-- 30	.Ciudad.Provincia.numeroIngresosBrutos   		INTEGER
				, Provincia_25.numeroRENATEA                   AS Provincia_25_numeroRENATEA              	-- 31	.Ciudad.Provincia.numeroRENATEA          		INTEGER
				, Pais_32.id                                   AS Pais_32_id                              	-- 32	.Ciudad.Provincia.Pais.id                		VARCHAR(36)
				, Pais_32.numero                               AS Pais_32_numero                          	-- 33	.Ciudad.Provincia.Pais.numero            		INTEGER
				, Pais_32.nombre                               AS Pais_32_nombre                          	-- 34	.Ciudad.Provincia.Pais.nombre            		VARCHAR(50)
				, Pais_32.abreviatura                          AS Pais_32_abreviatura                     	-- 35	.Ciudad.Provincia.Pais.abreviatura       		VARCHAR(5)
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 36	.precioFlete                             		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 37	.precioUnidadFacturacion                 		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 38	.precioUnidadStock                       		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 39	.precioBultos                            		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 40	.importeMinimoEntrega                    		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 41	.importeMinimoCarga                      		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2                      ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.Transporte AS Transporte_5                ON Carga_2.transporte = Transporte_5.id 	-- 5 LEFT LEVEL: 2
					LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_12             ON Transporte_5.codigoPostal = CodigoPostal_12.id 	-- 12 LEFT LEVEL: 3
			LEFT JOIN massoftware.Ciudad AS Ciudad_20                    ON TransporteTarifa.ciudad = Ciudad_20.id 	-- 20 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_25                 ON Ciudad_20.provincia = Provincia_25.id 	-- 25 LEFT LEVEL: 2
					LEFT JOIN massoftware.Pais AS Pais_32                     ON Provincia_25.pais = Pais_32.id 	-- 32 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_3 ( idArg , null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP



DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.TipoDocumentoAFIP AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  TipoDocumentoAFIP.id        AS TipoDocumentoAFIP_id    	-- 0	.id   		VARCHAR(36)
				, TipoDocumentoAFIP.numero    AS TipoDocumentoAFIP_numero	-- 1	.numero		INTEGER
				, TipoDocumentoAFIP.nombre    AS TipoDocumentoAFIP_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.TipoDocumentoAFIP

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TipoDocumentoAFIP.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoDocumentoAFIP.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoDocumentoAFIP.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TipoDocumentoAFIP.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIPById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIPById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TipoDocumentoAFIP AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TipoDocumentoAFIP ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP



DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3
	, codigoArg4    VARCHAR(3) 	-- 4
	, nombreArg5    VARCHAR(50)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP (

	  idArg0        VARCHAR(36)	-- 0
	, orderByArg1   INTEGER    	-- 1
	, limitArg2     BIGINT     	-- 2
	, offSetArg3    BIGINT     	-- 3
	, codigoArg4    VARCHAR(3) 	-- 4
	, nombreArg5    VARCHAR(50)	-- 5

) RETURNS SETOF massoftware.MonedaAFIP AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  MonedaAFIP.id        AS MonedaAFIP_id    	-- 0	.id   		VARCHAR(36)
				, MonedaAFIP.codigo    AS MonedaAFIP_codigo	-- 1	.codigo		VARCHAR(3)
				, MonedaAFIP.nombre    AS MonedaAFIP_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.MonedaAFIP

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaAFIP.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg4 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg4)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg4 = REPLACE(codigoArg4, '''', '''''');
		codigoArg4 = LOWER(TRIM(codigoArg4));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(MonedaAFIP.codigo) = ''' || codigoArg4 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg5)) > 0 THEN
		nombreArg5 = REPLACE(nombreArg5, '''', '''''');
		nombreArg5 = LOWER(TRIM(nombreArg5));
		nombreArg5 = TRANSLATE(nombreArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaAFIP.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIPById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIPById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MonedaAFIP AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaAFIP ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda



DROP FUNCTION IF EXISTS massoftware.f_Moneda (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7

) RETURNS SETOF massoftware.Moneda AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Moneda.id                      AS Moneda_id                  	-- 0	.id                 		VARCHAR(36)
				, Moneda.numero                  AS Moneda_numero              	-- 1	.numero             		INTEGER
				, Moneda.nombre                  AS Moneda_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Moneda.abreviatura             AS Moneda_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Moneda.cotizacion              AS Moneda_cotizacion          	-- 4	.cotizacion         		DECIMAL(13,5)
				, Moneda.cotizacionFecha         AS Moneda_cotizacionFecha     	-- 5	.cotizacionFecha    		TIMESTAMP
				, Moneda.controlActualizacion    AS Moneda_controlActualizacion	-- 6	.controlActualizacion		BOOLEAN
				, Moneda.monedaAFIP              AS Moneda_monedaAFIP          	-- 7	.monedaAFIP         		VARCHAR(36)	MonedaAFIP.id

		FROM	massoftware.Moneda

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Moneda.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg7)) > 0 THEN
		abreviaturaArg7 = REPLACE(abreviaturaArg7, '''', '''''');
		abreviaturaArg7 = LOWER(TRIM(abreviaturaArg7));
		abreviaturaArg7 = TRANSLATE(abreviaturaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_MonedaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Moneda AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Moneda ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_Moneda_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, limitArg2         BIGINT     	-- 2
	, offSetArg3        BIGINT     	-- 3
	, numeroFromArg4    INTEGER    	-- 4
	, numeroToArg5      INTEGER    	-- 5
	, nombreArg6        VARCHAR(50)	-- 6
	, abreviaturaArg7   VARCHAR(5) 	-- 7

) RETURNS SETOF massoftware.t_Moneda_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Moneda.id                      AS Moneda_id                  	-- 0	.id                 		VARCHAR(36)
				, Moneda.numero                  AS Moneda_numero              	-- 1	.numero             		INTEGER
				, Moneda.nombre                  AS Moneda_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Moneda.abreviatura             AS Moneda_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Moneda.cotizacion              AS Moneda_cotizacion          	-- 4	.cotizacion         		DECIMAL(13,5)
				, Moneda.cotizacionFecha         AS Moneda_cotizacionFecha     	-- 5	.cotizacionFecha    		TIMESTAMP
				, Moneda.controlActualizacion    AS Moneda_controlActualizacion	-- 6	.controlActualizacion		BOOLEAN
				, MonedaAFIP_7.id                AS MonedaAFIP_7_id            	-- 7	.MonedaAFIP.id      		VARCHAR(36)
				, MonedaAFIP_7.codigo            AS MonedaAFIP_7_codigo        	-- 8	.MonedaAFIP.codigo  		VARCHAR(3)
				, MonedaAFIP_7.nombre            AS MonedaAFIP_7_nombre        	-- 9	.MonedaAFIP.nombre  		VARCHAR(50)

		FROM	massoftware.Moneda
			LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_7        ON Moneda.monedaAFIP = MonedaAFIP_7.id 	-- 7 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Moneda.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg7)) > 0 THEN
		abreviaturaArg7 = REPLACE(abreviaturaArg7, '''', '''''');
		abreviaturaArg7 = LOWER(TRIM(abreviaturaArg7));
		abreviaturaArg7 = TRANSLATE(abreviaturaArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_MonedaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Moneda_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Moneda_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo



DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.NotaCreditoMotivo AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  NotaCreditoMotivo.id        AS NotaCreditoMotivo_id    	-- 0	.id   		VARCHAR(36)
				, NotaCreditoMotivo.numero    AS NotaCreditoMotivo_numero	-- 1	.numero		INTEGER
				, NotaCreditoMotivo.nombre    AS NotaCreditoMotivo_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.NotaCreditoMotivo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' NotaCreditoMotivo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' NotaCreditoMotivo.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' NotaCreditoMotivo.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(NotaCreditoMotivo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.NotaCreditoMotivo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_NotaCreditoMotivo ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario



DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.MotivoComentario AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  MotivoComentario.id        AS MotivoComentario_id    	-- 0	.id   		VARCHAR(36)
				, MotivoComentario.numero    AS MotivoComentario_numero	-- 1	.numero		INTEGER
				, MotivoComentario.nombre    AS MotivoComentario_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.MotivoComentario

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MotivoComentario.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoComentario.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoComentario.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoComentario.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_MotivoComentarioById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentarioById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MotivoComentario AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MotivoComentario ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoCliente                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoCliente



DROP FUNCTION IF EXISTS massoftware.f_TipoCliente (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoCliente (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.TipoCliente AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  TipoCliente.id        AS TipoCliente_id    	-- 0	.id   		VARCHAR(36)
				, TipoCliente.numero    AS TipoCliente_numero	-- 1	.numero		INTEGER
				, TipoCliente.nombre    AS TipoCliente_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.TipoCliente

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TipoCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoCliente.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoCliente.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TipoCliente.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TipoClienteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoClienteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TipoCliente AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TipoCliente ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente



DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente (

	  idArg0           VARCHAR(36)	-- 0
	, orderByArg1      INTEGER    	-- 1
	, limitArg2        BIGINT     	-- 2
	, offSetArg3       BIGINT     	-- 3
	, numeroFromArg4   INTEGER    	-- 4
	, numeroToArg5     INTEGER    	-- 5
	, nombreArg6       VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.ClasificacionCliente AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  ClasificacionCliente.id        AS ClasificacionCliente_id    	-- 0	.id   		VARCHAR(36)
				, ClasificacionCliente.numero    AS ClasificacionCliente_numero	-- 1	.numero		INTEGER
				, ClasificacionCliente.nombre    AS ClasificacionCliente_nombre	-- 2	.nombre		VARCHAR(50)
				, ClasificacionCliente.color     AS ClasificacionCliente_color 	-- 3	.color		INTEGER

		FROM	massoftware.ClasificacionCliente

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ClasificacionCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ClasificacionCliente.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ClasificacionCliente.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ClasificacionCliente.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_ClasificacionClienteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionClienteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.ClasificacionCliente AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ClasificacionCliente ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente



DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, limitArg2                  BIGINT     	-- 2
	, offSetArg3                 BIGINT     	-- 3
	, numeroFromArg4             INTEGER    	-- 4
	, numeroToArg5               INTEGER    	-- 5
	, nombreArg6                 VARCHAR(50)	-- 6
	, clasificacionClienteArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, limitArg2                  BIGINT     	-- 2
	, offSetArg3                 BIGINT     	-- 3
	, numeroFromArg4             INTEGER    	-- 4
	, numeroToArg5               INTEGER    	-- 5
	, nombreArg6                 VARCHAR(50)	-- 6
	, clasificacionClienteArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.MotivoBloqueoCliente AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  MotivoBloqueoCliente.id                      AS MotivoBloqueoCliente_id                  	-- 0	.id                 		VARCHAR(36)
				, MotivoBloqueoCliente.numero                  AS MotivoBloqueoCliente_numero              	-- 1	.numero             		INTEGER
				, MotivoBloqueoCliente.nombre                  AS MotivoBloqueoCliente_nombre              	-- 2	.nombre             		VARCHAR(50)
				, MotivoBloqueoCliente.clasificacionCliente    AS MotivoBloqueoCliente_clasificacionCliente	-- 3	.clasificacionCliente		VARCHAR(36)	ClasificacionCliente.id

		FROM	massoftware.MotivoBloqueoCliente

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND clasificacionClienteArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 THEN
		clasificacionClienteArg7 = REPLACE(clasificacionClienteArg7, '''', '''''');
		clasificacionClienteArg7 = LOWER(TRIM(clasificacionClienteArg7));
		clasificacionClienteArg7 = TRANSLATE(clasificacionClienteArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(clasificacionClienteArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.clasificacionCliente),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MotivoBloqueoCliente AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MotivoBloqueoCliente ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_1 (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, limitArg2                  BIGINT     	-- 2
	, offSetArg3                 BIGINT     	-- 3
	, numeroFromArg4             INTEGER    	-- 4
	, numeroToArg5               INTEGER    	-- 5
	, nombreArg6                 VARCHAR(50)	-- 6
	, clasificacionClienteArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_1 (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, limitArg2                  BIGINT     	-- 2
	, offSetArg3                 BIGINT     	-- 3
	, numeroFromArg4             INTEGER    	-- 4
	, numeroToArg5               INTEGER    	-- 5
	, nombreArg6                 VARCHAR(50)	-- 6
	, clasificacionClienteArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_MotivoBloqueoCliente_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  MotivoBloqueoCliente.id          AS MotivoBloqueoCliente_id      	-- 0	.id                        		VARCHAR(36)
				, MotivoBloqueoCliente.numero      AS MotivoBloqueoCliente_numero  	-- 1	.numero                    		INTEGER
				, MotivoBloqueoCliente.nombre      AS MotivoBloqueoCliente_nombre  	-- 2	.nombre                    		VARCHAR(50)
				, ClasificacionCliente_3.id        AS ClasificacionCliente_3_id    	-- 3	.ClasificacionCliente.id   		VARCHAR(36)
				, ClasificacionCliente_3.numero    AS ClasificacionCliente_3_numero	-- 4	.ClasificacionCliente.numero		INTEGER
				, ClasificacionCliente_3.nombre    AS ClasificacionCliente_3_nombre	-- 5	.ClasificacionCliente.nombre		VARCHAR(50)
				, ClasificacionCliente_3.color     AS ClasificacionCliente_3_color 	-- 6	.ClasificacionCliente.color		INTEGER

		FROM	massoftware.MotivoBloqueoCliente
			LEFT JOIN massoftware.ClasificacionCliente AS ClasificacionCliente_3        ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg4 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero >= ' || numeroFromArg4;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero <= ' || numeroToArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND clasificacionClienteArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 THEN
		clasificacionClienteArg7 = REPLACE(clasificacionClienteArg7, '''', '''''');
		clasificacionClienteArg7 = LOWER(TRIM(clasificacionClienteArg7));
		clasificacionClienteArg7 = TRANSLATE(clasificacionClienteArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(clasificacionClienteArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.clasificacionCliente),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	EXECUTE sqlSrc;

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_MotivoBloqueoCliente_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MotivoBloqueoCliente_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;