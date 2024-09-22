# 2048 Game - Flutter

Un jeu 2048 simple et amusant, développé avec **Flutter**. Le projet reprend le célèbre jeu 2048 où le joueur doit combiner des tuiles avec des valeurs identiques pour obtenir la tuile 2048 ou même aller au-delà !

## Fonctionnalités

- **Glisser pour déplacer les tuiles** : Les utilisateurs peuvent faire glisser les tuiles dans quatre directions (haut, bas, gauche, droite) pour les combiner.
- **Calcul automatique du score** : Le score augmente chaque fois que des tuiles sont combinées.
- **Rejouer** : Un bouton "Recommencer" permet de redémarrer une nouvelle partie.
- **Détection de la fin de partie** : Le jeu affiche une popup lorsque plus aucun mouvement n'est possible.

## Installation

Pour exécuter ce projet localement, il faut avoir installé Flutter sur sa machine. Suis ces étapes :

### Prérequis

- Flutter SDK
- Un émulateur Android ou iOS, ou un appareil physique connecté

### Étapes d'installation

1. Clone ce dépôt Git :
   ```bash
   git clone https://github.com/UnboringCompany/2048_project.git
   ```

2. Navigue dans le dossier du projet :
   ```bash
   cd 2048_project/projet_cours
   ```

3. Installe les dépendances nécessaires :
   ```bash
   flutter pub get
   ```

4. Exécute l'application sur un émulateur ou un appareil connecté :
   ```bash
   flutter run
   ```

## Architecture du projet

- **main.dart** : Point d'entrée de l'application. Il initialise le `ChangeNotifierProvider` pour la gestion du score et affiche la grille de jeu via `GameGrid`.
- **game_grid.dart** : Contient la logique du jeu, y compris la gestion des mouvements, la fusion des tuiles, et l'ajout de nouvelles tuiles après chaque déplacement.
- **score_model.dart** : Modèle de score qui utilise `ChangeNotifier` pour mettre à jour et notifier l'interface utilisateur à chaque modification du score.

## Utilisation

- **Glisser les tuiles** : Utilise des gestes pour déplacer les tuiles. Les tuiles de même valeur fusionnent lorsqu'elles se rencontrent, et la nouvelle tuile prend la somme des deux.
- **Recommencer** : Utilise le bouton "Recommencer" pour réinitialiser la partie.

## Dépendances

Le projet utilise les dépendances suivantes :

- [provider](https://pub.dev/packages/provider) : Pour la gestion d'état de l'application.
- [audioplayers](https://pub.dev/packages/audioplayers) : Pour jouer des sons à chaque mouvement de tuile.

Installe-les avec la commande suivante :

```bash
flutter pub get
```
