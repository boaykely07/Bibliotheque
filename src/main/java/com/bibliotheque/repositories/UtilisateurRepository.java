package com.bibliotheque.repositories;

import com.bibliotheque.entities.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UtilisateurRepository extends JpaRepository<Utilisateur, Integer> {
    // Méthode pour vérifier si un email existe déjà
    Optional<Utilisateur> findByEmail(String email);
}