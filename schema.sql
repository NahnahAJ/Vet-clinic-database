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

-- Add a column species of type string to your animals table. Modify your schema.sql file.
ALTER TABLE animals ADD species varchar(255);

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(255) NOT NULL,
  age INT NOT NULL,
  PRIMARY KEY (id)
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT const_one 
FOREIGN KEY (species_id) 
REFERENCES species (id)
ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT const_two 
FOREIGN KEY (owner_id) 
REFERENCES owners (id)
ON DELETE CASCADE;

-- Create a table named vets with the following columns:
CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations(
  species_id INT REFERENCES species (id) ON DELETE CASCADE,
  vets_id INT REFERENCES vets (id) ON DELETE CASCADE,
  PRIMARY KEY (species_id, vets_id)
);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits(
  id INTEGER GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
  vets_id INT REFERENCES vets(id) ON DELETE CASCADE,
  date_of_visit DATE,
  PRIMARY KEY (id)
);
