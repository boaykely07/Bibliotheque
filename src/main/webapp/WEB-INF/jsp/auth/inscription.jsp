<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Inscription Nouvel Adhérent</title>
    <style>
        body { font-family: sans-serif; margin: 2em; }
        .form-group { margin-bottom: 1em; }
        label { display: block; margin-bottom: 0.25em; }
        input, select { width: 300px; padding: 8px; font-size: 1em; }
        .error { color: red; border: 1px solid red; padding: 1em; margin-bottom: 1em; }
        button { padding: 10px 20px; font-size: 1em; cursor: pointer; }
    </style>
</head>
<body>
    <h1>Inscription à la Bibliothèque</h1>

    <c:if test="${not empty erreur}">
        <div class="error">
            <p><strong>Erreur :</strong> ${erreur}</p>
        </div>
    </c:if>

    <form action="/auth/inscription" method="post">
        <div class="form-group">
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" required>
        </div>
        <div class="form-group">
            <label for="prenom">Prénom :</label>
            <input type="text" id="prenom" name="prenom" required>
        </div>
        <div class="form-group">
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="motDePasse">Mot de passe :</label>
            <input type="password" id="motDePasse" name="motDePasse" required>
        </div>
        <div class="form-group">
            <label for="dateNaissance">Date de naissance :</label>
            <input type="date" id="dateNaissance" name="dateNaissance" required>
        </div>
        <div class="form-group">
            <label for="idProfil">Profil d'adhérent :</label>
            <select id="idProfil" name="idProfil" required>
                <option value="">-- Choisissez un profil --</option>
                <c:forEach var="profil" items="${profils}">
                    <option value="${profil.id}">${profil.nomProfil}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit">S'inscrire</button>
    </form>
</body>
</html>