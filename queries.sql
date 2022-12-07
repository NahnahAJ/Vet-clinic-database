/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE NAME LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE DATE_OF_BIRTH BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT* FROM animals WHERE NEUTERED = TRUE AND ESCAPE_ATTEMPTS < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT * FROM animals WHERE NAME IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT NAME, ESCAPE_ATTEMPTS FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE NEUTERED = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE NAME NOT IN ('Gabumon');

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- start a transaction
BEGIN;
-- Update the animals table
UPDATE ANIMALS
-- Inside a transaction update the animals table by setting the species column to unspecified. 
SET species = 'unspecified';
SELECT species FROM animals; -- verify that change was made
-- rollback the change
ROLLBACK;
SELECT species FROM animals; -- verify that change was undone



-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE ANIMALS SET SPECIES = 'digimon' WHERE NAME LIKE '%mon';
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE ANIMALS SET SPECIES = 'pokemon' WHERE species IS NULL;
SELECT species from animals; -- verify that change was made
-- Commit the transaction.
COMMIT;
-- Verify that change was made and persists after commit.
SELECT species from animals;



-- Inside a transaction:
BEGIN;
-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
DELETE FROM animals; 
-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
SELECT * FROM animals; -- verify that change was made
-- rollback the change
ROLLBACK;
SELECT * FROM animals; -- verify that change was undone



-- Inside a transaction:
BEGIN TRANSACTION;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth >= '2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT SAVEPOINT_ONE;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE ANIMALS SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT_ONE;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE ANIMALS SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM ANIMALS; --verify that the changes were made
-- Commit transaction
COMMIT;
SELECT * FROM ANIMALS; -- verify that the changes were undone


-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
