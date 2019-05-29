
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TransporteTarifa;

-- SELECT * FROM massoftware.TransporteTarifa LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TransporteTarifa;

-- SELECT * FROM massoftware.TransporteTarifa WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TransporteTarifaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TransporteTarifaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TransporteTarifaById('xxx');

-- SELECT * FROM massoftware.d_TransporteTarifaById((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF precioFleteArg IS NULL THEN

		precioFleteArg = 0;

	END IF;

	IF precioUnidadFacturacionArg IS NULL THEN

		precioUnidadFacturacionArg = 0;

	END IF;

	IF precioUnidadStockArg IS NULL THEN

		precioUnidadStockArg = 0;

	END IF;

	IF precioBultosArg IS NULL THEN

		precioBultosArg = 0;

	END IF;

	IF importeMinimoEntregaArg IS NULL THEN

		importeMinimoEntregaArg = 0;

	END IF;

	IF importeMinimoCargaArg IS NULL THEN

		importeMinimoCargaArg = 0;

	END IF;

	INSERT INTO massoftware.TransporteTarifa(id, numero, carga, ciudad, precioFlete, precioUnidadFacturacion, precioUnidadStock, precioBultos, importeMinimoEntrega, importeMinimoCarga) VALUES (idArg, numeroArg, cargaArg, ciudadArg, precioFleteArg, precioUnidadFacturacionArg, precioUnidadStockArg, precioBultosArg, importeMinimoEntregaArg, importeMinimoCargaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TransporteTarifa(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TransporteTarifa SET 
		  numero = numeroArg
		, carga = cargaArg
		, ciudad = ciudadArg
		, precioFlete = precioFleteArg
		, precioUnidadFacturacion = precioUnidadFacturacionArg
		, precioUnidadStock = precioUnidadStockArg
		, precioBultos = precioBultosArg
		, importeMinimoEntrega = importeMinimoEntregaArg
		, importeMinimoCarga = importeMinimoCargaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TransporteTarifa(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
);

*/