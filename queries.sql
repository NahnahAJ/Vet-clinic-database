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

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT A.name AS animal_name, O.full_name AS owner_name FROM animals A JOIN owners O ON A.owner_id = O.id WHERE O.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name AS animal_name, S.name AS animal_type FROM animals A JOIN species S ON A.species_id = S.id WHERE S.id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT O.full_name AS owner_name, A.name AS animals FROM owners O LEFT JOIN animals A ON A.owner_id = O.id;

-- How many animals are there per species?
SELECT COUNT(species_id) FROM animals GROUP BY species_id;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name AS animal_name, S.name AS animal_species FROM animals A JOIN species S ON A.id = S.id WHERE A.owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell');

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name AS animal_name, O.full_name AS owner_name, A.escape_attempts FROM animals A LEFT JOIN owners O ON A.id = O.id WHERE full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT COUNT(*) FROM animals GROUP BY owner_id;




-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT A.name AS animal_name, V.date_of_visit 
FROM visits V 
JOIN animals A ON V.animal_id = A.id 
WHERE V.vets_id = 1 ORDER BY V.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) FROM visits WHERE vets_id = 2

-- List all vets and their specialties, including vets with no specialties.
SELECT V.name AS vet_name, S.vets_id, SP.name AS specialization, S.species_id AS specialization_id 
FROM specializations S 
RIGHT JOIN vets V ON V.id = S.vets_id 
LEFT JOIN species SP ON SP.id = S.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT * FROM visits V WHERE V.vets_id = 3 AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT A.name AS animal_name, COUNT(V.animal_id) AS Number_of_visits 
FROM visits V JOIN animals A ON A.id = V.animal_id 
GROUP BY animal_name ORDER BY number_of_visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name AS animal_name, V.date_of_visit 
FROM animals A JOIN visits V ON A.id = V.animal_id 
WHERE vets_id = 2 ORDER BY date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT A.name as animal_name, A.date_of_birth, A.neutered, A.weight_kg, V.date_of_visit, vets.name AS vet_name, SP.name AS specialization
FROM animals A 
JOIN visits V ON A.id = V.animal_id 
JOIN vets ON V.vets_id = vets.id 
JOIN specializations S ON S.vets_id = V.vets_id
JOIN species SP ON SP.id = S.species_id
ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name AS vet_name, vets.id as vets_id, COUNT(vets.name) AS Number_of_visits, SP.name AS specialization FROM animals A                
LEFT JOIN visits V ON A.id = V.animal_id 
LEFT JOIN vets ON V.vets_id = vets.id 
LEFT JOIN specializations S ON S.vets_id = V.vets_id
LEFT JOIN species SP ON SP.id = S.species_id
WHERE SP.name IS NULL
GROUP BY vets.name, SP.name, vets.id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT A.species_id AS specialties_id, S.name AS specialties, COUNT(A.species_id) AS species_count 
FROM visits V  
JOIN animals A ON V.animal_id = A.id
JOIN species S ON A.species_id = S.id
where V.vets_id = 2  
GROUP BY species_id, S.name 
ORDER BY species_count DESC LIMIT 1;


