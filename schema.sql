/* Database schema to keep the structure of entire database. */
-- Add a column species of type string to your animals table. Modify your schema.sql file.

CREATE TABLE animals (
    name VARCHAR(250),
    id INT GENERATED ALWAYS AS IDENTITY,
    date_of_birth date,
    escape_attempts INT,
    neutered BIT,
    weight_kg DECIMAL,
    species VARCHAR(250),
    PRIMARY KEY(id)
);
