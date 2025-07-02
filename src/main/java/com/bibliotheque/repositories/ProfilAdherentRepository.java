package com.bibliotheque.repositories;

import com.bibliotheque.entities.ProfilAdherent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProfilAdherentRepository extends JpaRepository<ProfilAdherent, Integer> {
}