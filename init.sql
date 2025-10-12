-- 1. Create the organizations table

-- Replaced PostgreSQL 'text' and 'COLLATE' with MySQL 'VARCHAR'.
-- Removed the PostgreSQL-specific 'public.' schema prefix.
CREATE TABLE IF NOT EXISTS organizations (
    organization_id VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    contact_name VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(255),
    -- CONSTRAINT organizations_pkey is optional; PRIMARY KEY is sufficient.
    PRIMARY KEY (organization_id)
);

-- 2. Create the licenses table

CREATE TABLE IF NOT EXISTS licenses (
    license_id VARCHAR(255) NOT NULL,
    organization_id VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    product_name VARCHAR(255) NOT NULL,
    license_type VARCHAR(255) NOT NULL,
    comment VARCHAR(255),
    PRIMARY KEY (license_id),
    -- Corrected FOREIGN KEY syntax for MySQL
    CONSTRAINT licenses_organization_id_fkey 
        FOREIGN KEY (organization_id)
        -- Removed the 'public.' schema prefix and the PostgreSQL-specific 'MATCH SIMPLE' and 'NOT VALID' clauses.
        REFERENCES organizations (organization_id) 
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


-- 3. Grant Permissions (Optional but necessary if user 'mysql' is used)

-- NOTE: This assumes your application connects using the user 'mysql'.
-- If your application connects as 'root' (as per your docker-compose environment), 
-- these commands may be unnecessary as 'root' already has full permissions.

-- The original ALTER TABLE ... GRANT syntax was incorrect; 
-- GRANT is a separate command run directly.

GRANT ALL PRIVILEGES ON ostock_dev.organizations TO 'mysql'@'%';
GRANT ALL PRIVILEGES ON ostock_dev.licenses TO 'mysql'@'%';

FLUSH PRIVILEGES;