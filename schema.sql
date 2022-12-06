/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name VARCHAR(250),
    id INT GENERATED ALWAYS AS IDENTITY,
    date_of_birth date,
    escape_attempts INT,
    neutered BIT,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);
