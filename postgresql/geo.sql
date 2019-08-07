DROP TABLE IF EXISTS geo.Continent CASCADE;

CREATE TABLE geo.Continent
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),		
	
    -- Code
	code VARCHAR(2) NOT NULL, 
    
	-- Name
	name VARCHAR(50) NOT NULL
    
);

DROP TABLE IF EXISTS geo.Country CASCADE;

CREATE TABLE geo.Country
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),		
	
    -- Code
	code VARCHAR(2) NOT NULL, 
    
	-- Name
	name VARCHAR(50) NOT NULL, 	
	
	-- Continent
	continent VARCHAR(36)  NOT NULL  REFERENCES geo.Continent (id)
);