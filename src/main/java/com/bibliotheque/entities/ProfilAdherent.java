package com.bibliotheque.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "profils_adherent")
public class ProfilAdherent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_profil")
    private Integer id;

    @Column(name = "nom_profil", nullable = false, unique = true)
    private String nomProfil;

    @Column(name = "quota_emprunts_simultanes", nullable = false)
    private int quotaEmpruntsSimultanes;

    @Column(name = "duree_pret_domicile_jours", nullable = false)
    private int dureePretDomicileJours;

    // --- Constructeurs, Getters et Setters ---

    public ProfilAdherent() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNomProfil() {
        return nomProfil;
    }

    public void setNomProfil(String nomProfil) {
        this.nomProfil = nomProfil;
    }

    public int getQuotaEmpruntsSimultanes() {
        return quotaEmpruntsSimultanes;
    }

    public void setQuotaEmpruntsSimultanes(int quotaEmpruntsSimultanes) {
        this.quotaEmpruntsSimultanes = quotaEmpruntsSimultanes;
    }

    public int getDureePretDomicileJours() {
        return dureePretDomicileJours;
    }

    public void setDureePretDomicileJours(int dureePretDomicileJours) {
        this.dureePretDomicileJours = dureePretDomicileJours;
    }

    // N'oubliez pas les autres champs si nécessaire (peut_prolonger_pret, etc.)
}