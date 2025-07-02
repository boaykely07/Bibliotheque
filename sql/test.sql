-- #############################################################
-- ##      JEU DE DONNÉES DE TEST POUR LA BIBLIOTHÈQUE      ##
-- #############################################################

-- 1. Insertion dans les tables de référence (sans dépendances)
-- ==============================================================

-- Profils pour les différents types d'adhérents
INSERT INTO Profils_Adherent (nom_profil, quota_emprunts_simultanes, duree_pret_domicile_jours, duree_pret_sur_place_heures, peut_prolonger_pret, jours_penalite_par_retard) VALUES
('etudiant', 3, 21, 3, TRUE, 1),
('professeur', 5, 14, 2, TRUE, 1),
('professionnel', 10, 42, 8, TRUE, 2),
('anonyme', 15, 28, 5, FALSE, 3);

-- Quelques auteurs
INSERT INTO Auteurs (nom, prenom) VALUES
('Hugo', 'Victor'),
('Camus', 'Albert'),
('Rowling', 'J.K.'),
('Orwell', 'George'),
('Asimov', 'Isaac'),
('Tolkien', 'J.R.R.');

-- Quelques éditeurs
INSERT INTO Editeurs (nom) VALUES
('Gallimard'),
('Flammarion'),
('Hachette Livre'),
('Penguin Books'),
('Éditions de Minuit');

-- Quelques catégories de livres
INSERT INTO Categories (nom) VALUES
('Roman'),
('Science-Fiction'),
('Fantastique'),
('Biographie'),
('Histoire'),
('Jeunesse'),
('Essai');

-- Jours fériés pour le calcul des dates de retour
INSERT INTO Jours_Feries (date_ferie, description) VALUES
('2024-01-01', 'Jour de l''An'),
('2024-05-01', 'Fête du Travail'),
('2024-07-14', 'Fête Nationale'),
('2024-08-15', 'Assomption'),
('2024-11-01', 'Toussaint'),
('2024-12-25', 'Noël');

-- Statuts possibles pour une réservation
INSERT INTO Statuts_Reservation (code_statut) VALUES
('EN_ATTENTE'),  -- L'adhérent attend qu'un exemplaire se libère
('DISPONIBLE'),  -- Un exemplaire est disponible pour l'adhérent
('ANNULEE'),     -- L'adhérent ou un bibliothécaire a annulé la demande
('EXPIREE');     -- L'adhérent n'a pas retiré le livre à temps

-- Utilisateurs (qui seront ensuite liés à des adhérents ou des bibliothécaires)
INSERT INTO Utilisateurs (email, mot_de_passe_hash) VALUES
('jean.dupont@email.com', 'hash_fictif_pour_jean'),
('marie.curie@email.com', 'hash_fictif_pour_marie'),
('paul.martin@email.com', 'hash_fictif_pour_paul'),
('alice.bibliothecaire@lib.com', 'hash_fictif_pour_alice'),
('bob.admin@lib.com', 'hash_fictif_pour_bob');


-- 2. Insertion dans les tables principales
-- ==============================================================

-- Livres (référençant les éditeurs)
-- Note: les id_editeur correspondent à ceux insérés ci-dessus (1: Gallimard, 2: Flammarion, etc.)
INSERT INTO Livres (titre, isbn, annee_publication, resume, id_editeur) VALUES
('Les Misérables', '978-2070360025', 1862, 'Un roman historique et social sur la vie de Jean Valjean.', 1),
('L''Étranger', '978-2070360026', 1942, 'L''histoire de Meursault, un homme indifférent au monde qui l''entoure.', 1),
('1984', '978-0451524935', 1949, 'Une dystopie sur une société sous surveillance constante par Big Brother.', 4),
('Harry Potter à l''école des sorciers', '978-2070518425', 1997, 'Le début des aventures d''un jeune sorcier à Poudlard.', 1),
('Fondation', '978-2070415756', 1951, 'Un empire galactique en déclin et le plan d''un scientifique pour préserver le savoir.', 3),
('Le Seigneur des Anneaux', '978-2075134045', 1954, 'La quête pour détruire un anneau de pouvoir maléfique.', 3);


-- 3. Insertion dans les tables liées aux utilisateurs
-- ==============================================================

-- Adhérents (référençant Utilisateurs et Profils_Adherent)
-- Note: id_utilisateur 1,2,3 et id_profil 1,2,3
INSERT INTO Adherents (id_utilisateur, nom, prenom, date_naissance, date_inscription, id_profil) VALUES
(1, 'Dupont', 'Jean', '1990-05-15', '2022-01-10', 1), -- Adhérent Standard
(2, 'Curie', 'Marie', '1985-11-20', '2021-09-01', 3), -- Chercheur
(3, 'Martin', 'Paul', '2010-08-30', '2023-03-25', 2); -- Adhérent Jeune

-- Bibliothécaires (référençant Utilisateurs)
-- Note: id_utilisateur 4,5
INSERT INTO Bibliothecaires (id_utilisateur, nom, prenom, matricule) VALUES
(4, 'Bernard', 'Alice', 'BIBLIO-001'),
(5, 'Leclerc', 'Bob', 'BIBLIO-002');


-- 4. Insertion dans les tables de liaison
-- ==============================================================

-- Association Livres <-> Auteurs
INSERT INTO Livres_Auteurs (id_livre, id_auteur) VALUES
(1, 1), -- Les Misérables <-> Victor Hugo
(2, 2), -- L'Étranger <-> Albert Camus
(3, 4), -- 1984 <-> George Orwell
(4, 3), -- Harry Potter <-> J.K. Rowling
(5, 5), -- Fondation <-> Isaac Asimov
(6, 6); -- Le Seigneur des Anneaux <-> J.R.R. Tolkien

-- Association Livres <-> Catégories (un livre peut avoir plusieurs catégories)
INSERT INTO Livres_Categories (id_livre, id_categorie) VALUES
(1, 1), (1, 5), -- Les Misérables -> Roman, Histoire
(2, 1), (2, 7), -- L'Étranger -> Roman, Essai
(3, 1), (3, 2), -- 1984 -> Roman, Science-Fiction
(4, 3), (4, 6), -- Harry Potter -> Fantastique, Jeunesse
(5, 2), -- Fondation -> Science-Fiction
(6, 3); -- Le Seigneur des Anneaux -> Fantastique


-- 5. Insertion dans les tables de "transactions" (sauf Emprunts/Reservations)
-- ==============================================================

-- Quantité d'exemplaires pour chaque livre
INSERT INTO Exemplaires (id_livre, quantite) VALUES
(1, 5),  -- 5 exemplaires des Misérables
(2, 3),  -- 3 exemplaires de L'Étranger
(3, 7),  -- 7 exemplaires de 1984
(4, 10), -- 10 exemplaires de Harry Potter
(5, 4),  -- 4 exemplaires de Fondation
(6, 6);  -- 6 exemplaires du Seigneur des Anneaux

-- Abonnements pour les adhérents
-- Note: id_adherent 1,2,3
INSERT INTO Abonnements (id_adherent, date_debut, date_fin) VALUES
(1, '2024-01-10', '2025-01-09'),
(2, '2023-09-01', '2024-08-31'),
(3, '2024-03-25', '2025-03-24');

-- Droits d'emprunt spécifiques
-- Ex: Harry Potter (id_livre 4) est réservé aux personnes de 10 ans et plus pour le profil Jeune (id_profil 2)
INSERT INTO Droits_Emprunt_Specifiques (id_livre, id_profil, age, emprunt_domicile_autorise) VALUES
(4, 2, 10, TRUE); -- Harry Potter, Profil Jeune, age min 10 ans, emprunt à domicile autorisé

-- Ex: Les chercheurs (id_profil 3) ne peuvent pas emprunter "Le Seigneur des Anneaux" (id_livre 6) à domicile
INSERT INTO Droits_Emprunt_Specifiques (id_livre, id_profil, age, emprunt_domicile_autorise) VALUES
(6, 3, NULL, FALSE); -- Le Seigneur des Anneaux, Profil Chercheur, pas d'âge min, emprunt domicile non autorisé
