/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
-- INSERT 0 1     

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8);
-- INSERT 0 1

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
-- INSERT 0 1

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11);
-- INSERT 0 1

-- Animal: His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false, -11);

-- Animal: Her name is Plantmon. She was born on Nov 15th, 2021, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);

-- Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to escape 3 times.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);

-- Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true, -45);

-- Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);

-- Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);

-- Animal: His name is Ditto. He was born on May 14th, 2022, and currently weighs 22kg. He is neutered and he has tried to escape 4 times.
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);


-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);

-- Jennifer Orwell 19 years old.
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);

-- Bob 45 years old.
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);

-- Melody Pond 77 years old.
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);

-- Dean Winchester 14 years old.
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);

-- Jodie Whittaker 38 years old.
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert the following data into the species table:
-- Pokemon
INSERT into species (name) VALUES ('Pokemon');

-- Digimon
INSERT into species (name) VALUES ('Digimon');


-- Modify your inserted animals so it includes the species_id value:
BEGIN;
-- If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = 2 WHERE NAME LIKE '%mon%';
-- All other animals are Pokemon
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
SELECT species_id from animals; -- verify that change was made
-- Commit the transaction.
COMMIT;
-- Verify that change was made and persists after commit.
SELECT species_id from animals;


-- Modify your inserted animals to include owner information (owner_id):
BEGIN TRANSACTION;
-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' or name = 'Plantmon';
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';
SELECT owner_id from animals; -- verify that change was made
-- Commit the transaction.
COMMIT;
-- Verify that change was made and persists after commit.
SELECT owner_id from animals;




-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');

-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');

-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');

-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');



-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations(species_id, vets_id) VALUES (1, 1);
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations(species_id, vets_id) VALUES (2, 3);
INSERT INTO specializations(species_id, vets_id) VALUES (1, 3);
-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations(species_id, vets_id) VALUES (2, 4);



-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (1, 1, '2020-05-24');

-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (1, 3, '2020-06-22');

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (2, 4, '2021-02-02');

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (3, 2, '2020-01-05');

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (3, 2, '2020-03-08');

-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (3, 2, '2020-05-14');

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (4, 3, '2021-05-04');

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (5, 4, '2021-02-24');

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (6, 2, '2019-12-21');

-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (6, 1, '2020-08-10');

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (6, 2, '2021-04-07');

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (7, 3, '2019-09-29');

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (8, 4, '2020-10-03');

-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (8, 4, '2020-11-04');

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (9, 2, '2019-01-24');

-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (9, 2, '2019-05-15');

-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (9, 2, '2020-02-27');

-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (9, 2, '2020-08-03');

-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (10, 3, '2020-05-24');

-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits(animal_id, vets_id, date_of_visit) VALUES (10, 1, '2021-01-11');


-- VET CLINIC DATABASE: DATABASE PERFORMANCE AUDIT

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

-- explain analyze SELECT COUNT(*) FROM visits where animal_id = 4