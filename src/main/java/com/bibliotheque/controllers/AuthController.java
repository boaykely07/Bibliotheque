package com.bibliotheque.controllers;

import com.bibliotheque.entities.Adherent;
import com.bibliotheque.entities.ProfilAdherent;
import com.bibliotheque.entities.Utilisateur;
import com.bibliotheque.repositories.AdherentRepository;
import com.bibliotheque.repositories.ProfilAdherentRepository;
import com.bibliotheque.repositories.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/auth") // Toutes les URL de ce contrôleur commenceront par /auth
public class AuthController {

    @Autowired
    private ProfilAdherentRepository profilAdherentRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private AdherentRepository adherentRepository;


    @GetMapping("/inscription")
    public String showInscriptionForm(Model model) {
        // On récupère la liste de tous les profils pour les afficher dans le formulaire
        List<ProfilAdherent> profils = profilAdherentRepository.findAll();
        model.addAttribute("profils", profils);
        return "auth/inscription"; // Affiche le fichier /WEB-INF/jsp/auth/inscription.jsp
    }

    // Méthode pour TRAITER le formulaire d'inscription
    @PostMapping("/inscription")
    public String processInscription(
            @RequestParam String nom,
            @RequestParam String prenom,
            @RequestParam String email,
            @RequestParam String motDePasse,
            @RequestParam("dateNaissance") String dateNaissanceStr,
            @RequestParam("idProfil") Integer idProfil,
            Model model) {

        // 1. Vérifier si l'email existe déjà
        if (utilisateurRepository.findByEmail(email).isPresent()) {
            model.addAttribute("erreur", "Cette adresse email est déjà utilisée.");
            // Recharger la liste des profils avant de réafficher la page
            List<ProfilAdherent> profils = profilAdherentRepository.findAll();
            model.addAttribute("profils", profils);
            return "auth/inscription";
        }
        
        // 2. Récupérer le profil choisi
        Optional<ProfilAdherent> profilOpt = profilAdherentRepository.findById(idProfil);
        if (profilOpt.isEmpty()) {
            model.addAttribute("erreur", "Le profil sélectionné est invalide.");
            List<ProfilAdherent> profils = profilAdherentRepository.findAll();
            model.addAttribute("profils", profils);
            return "auth/inscription";
        }
        
        // 3. Créer les objets Utilisateur et Adherent
        Utilisateur nouvelUtilisateur = new Utilisateur();
        nouvelUtilisateur.setEmail(email);
        // ATTENTION : Le mot de passe doit être "hashé" avant d'être stocké !
        // Pour ce test, on le stocke en clair, mais il faudra utiliser Spring Security plus tard.
        nouvelUtilisateur.setMotDePasseHash(motDePasse); 

        Adherent nouvelAdherent = new Adherent();
        nouvelAdherent.setNom(nom);
        nouvelAdherent.setPrenom(prenom);
        nouvelAdherent.setUtilisateur(nouvelUtilisateur);
        nouvelAdherent.setProfil(profilOpt.get());

        // Convertir la date de naissance
        try {
            Date dateNaissance = new SimpleDateFormat("yyyy-MM-dd").parse(dateNaissanceStr);
            nouvelAdherent.setDateNaissance(dateNaissance);
        } catch (ParseException e) {
             model.addAttribute("erreur", "Format de date de naissance invalide.");
             List<ProfilAdherent> profils = profilAdherentRepository.findAll();
             model.addAttribute("profils", profils);
             return "auth/inscription";
        }
        
        // 4. Sauvegarder l'adhérent (l'utilisateur sera sauvegardé en cascade)
        adherentRepository.save(nouvelAdherent);
        
        // 5. Rediriger vers une page de succès
        return "redirect:/auth/inscription-succes";
    }

    @GetMapping("/inscription-succes")
    public String showInscriptionSuccess() {
        return "auth/inscription-succes"; // Affiche /WEB-INF/jsp/auth/inscription-succes.jsp
    }
}