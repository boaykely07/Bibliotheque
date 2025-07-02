package com.bibliotheque.entities;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "adherents")
public class Adherent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_adherent")
    private Integer id;

    @OneToOne(cascade = CascadeType.ALL) // Si on supprime un Adherent, son Utilisateur lié est aussi supprimé
    @JoinColumn(name = "id_utilisateur", referencedColumnName = "id_utilisateur")
    private Utilisateur utilisateur;

    @Column(name = "nom", nullable = false)
    private String nom;

    @Column(name = "prenom", nullable = false)
    private String prenom;

    @Column(name = "date_naissance", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dateNaissance;

    @Column(name = "date_inscription", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dateInscription;

    @ManyToOne
    @JoinColumn(name = "id_profil", nullable = false)
    private ProfilAdherent profil;

    // --- Constructeurs, Getters et Setters ---

    public Adherent() {
    }

    @PrePersist
    protected void onPersist() {
        if (this.dateInscription == null) {
            this.dateInscription = new Date();
        }
    }

    // Getters et Setters pour tous les champs...
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public Date getDateInscription() {
        return dateInscription;
    }

    public void setDateInscription(Date dateInscription) {
        this.dateInscription = dateInscription;
    }

    public ProfilAdherent getProfil() {
        return profil;
    }

    public void setProfil(ProfilAdherent profil) {
        this.profil = profil;
    }
}