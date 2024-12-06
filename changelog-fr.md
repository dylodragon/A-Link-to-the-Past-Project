# Changelog

## The Legend of Zelda A Link to the Past (Solarus Edition) 0.4.0

`Changements du 28 Novembre 2024` v0.4.0

🗺**Overworld**
- __Light Overworld__:
  * Ajout de **Desert Palace**
  * Ajout de **Tower of Hera**

🗺**Desert Palace**
- Ajout d'une clé qui tombe de la torche avec les **Peagasus Shoes**
- Ajout des **Power Gloves**
- Ajout de **Leevers Purple** & **Green**, **Mini Moldorm**, **Quicksand**, **Devalant Blue** & **Red** and **Beemos**
- Ajout du Boss **Lanmolas**, sa Récompense, son Pendentif
- Ajout d'un système pour **Secouer la Caméra** 
- Ajout de Nouveaux **Drops d'Objets** sur les **Nouveaux Ennemis** (Prizes Packs)
- Ajout de Dialogues for **Sahasrahla**, **Power Gloves**

🗺**Tower of Hera**
- Ajout de la **Moon Pearl** sans Comportement/Code
- Ajout de **Hardhat Beetle Purple** & **Green**, **Skeleton Red** and **Kodongo**
- Ajout de **Spark** and **Firebar**
- Ajout de **Bumper**
- Ajout de **Switch Star**
- Ajout du Boss **Moldorm**, sa Récompense, son Pendentif
- Ajout de Nouveaux **Drops d'Objets** sur les **Nouveaux Ennemis** (Prizes Packs)
- Ajout de Dialogues for **Sahasrahla**

🗺**Eastern Ruins**
- Ajout de **Dialogues** pour **Sahasrahla** 
-  **Sahasrahla** donne les **Pegasus Shoes** après avoir récupéré le premier Pendentif 

☠️**Ennemies Fix**
- Corrige des problèmes de timing des **Eyegore** d'endormissement et de détection

🖼️**Sprites**
- Ajout du Sprite **Soldier Archer**
- Ajout des Sprites **Leevers Purple** & **Green**, **Mini Moldorm** and **Beemos** 
- Ajout des Sprites **Kodongo**, **Hardhat Beetle Purple** & **Green** and **Skeleton Red** 
- Ajout des Sprites **Quicksand**, **Devalant Blue** & **Red**
- Ajout des Sprites **Spark** and **Firebar**
- Ajout du Sprite **Bumper**
- Ajout du **Switch Star**

📟**Script**
- Ajout de meta/__camera.lua__

🧠**Debug**
- __Secret Room__: Téléportation dans une **Pièce Secrète** avec la touche ","
- __Boss Room__: Téléportation dans une **Pièce Secrète** pour les Boss avec la touche "="
- __Enemies Room__: Téléportation dans une **Pièce Secrète** pour les Ennemies avec la touche ")"

🗃**Organization**
- Ajout d'une Secret Room/Boss/boss_choiche_room
- Ajout d'une Secret Room/Enemies/enemies_choiche_room

__--------------------------------------------------------------------------------------------------------------__

## The Legend of Zelda A Link to the Past (Solarus Edition) 0.3.0

`Changements du 20 Juin 2024` v0.3.0

🗺**Overworld**
- __Light Overworld__ : 
* Ajout de **Hyrule Castle Cave**
* Ajout de **Hyrule Castle**
* Ajout du **Secret Passage**

🗺**Link House**
- Ajout de **Gardes** amicaux bloquant l'accès à l'**Overworld** pendant l'Introduction du Jeu
- Ajout de la **Pluie**, de la **Pénombre**
- Ajout de **Bruit de la Pluie**
- Ajout de **Dialogues** des **Gardes**, du **Panneau**

🗺**Hyrule Castle**
- Ajout de **Rideaux Destructibles**
- Ajout de **Dialogues** des **Gardes**, de **Zelda**
- Ajout des différents **Soldiers Blue** & **Green**
- Ajout du **Hyrule Castle Cave** où se trouve l'**Oncle**
- Ajout de la **Barrière Electrique** enmpêchant d'aller à la **Hyrule Tower**
- Ajout du **Boomerang**
- Ajout du **Mini-Boss** **Chevalier à Fléau** qui garde la **Princesse Zelda**
- Ajout de la quête d'**Escorte de Zelda** du Château au Sanctuaire
- Ajout du **Blason Poussable** avec Zelda pour entrée dans le **Passage Secret**

🗺**Secret Passage**
- Ajout des **Rats**, **Chauve-souris** & **Serpents**,
- Ajout des **Leviers à Tirer**

🗺**Sanctuary**
- Ajout des **Dialogues** de **Zelda** et le **Prêtre**
- Ajout du **Réceptable de Coeur** dans le coffre

🗺**Maison**
- __Maison de Link__ : Link démarre endormi dans son lit, Zelda nous parle par télépathie et l'Oncle de Link sort dehors

📱**HUD**
- Ajout de la **Musique** pour les Menus **Title Screen** et **Savegames** 

📟**Script**
- Ajout de meta/__map.lua__
- Ajout de __ceilling_drop_manager.lua__
- Ajout de __electric_barrier.lua__

🗃**Organisation**
- Ajout d'une Dossier de **/devdate** pour les **Développeur **

__--------------------------------------------------------------------------------------------------------------__

## The Legend of Zelda A Link to the Past (Solarus Edition) 0.2.0

`Changements du 28 Mars 2024` v0.2.0  

🗺**Overworld**
- __Light Overworld__ : 
* Ajout du **Eastern Palace**
* Ajout du **Sanctuary**

🗺**Eastern Palace**
- Ajout d'un Système pour les Transitions de Map (Séparateur qui reset de certains ennemis)
- Ajout de l'**Arc** et des **Pegassus Boots**
- Ajout du Systèmes de Gestion des Salles Sombres et de leurs éclairages (Torche/Lanterne)
- Ajout des **EyeGores Red** & **Green**, **Evil Tiles**, **Skeletons**, et **Canonballs**
- Ajout du Boss **Armos Knight**, sa Récompense, son Pendentif
- Metatables de gestion des **Switch**, des **Small Keys** & **Boss Keys**
- Ajout d'un Système de Gestion des **Drops d'Objets** sur les Ennemis (Prizes Packs)
- Ajout Dialogues de **Sahasrahla**, de l'**Arc**, des **Rubis**, des **Coffres**, des **Small Keys** & **Boss Keys** 

🎮**GameFix**
- Correction du Crash de Game Over

📱**HUD**
- Adaptation du HUD, des Menus pour le format **A Link to the Past** (256x224)

🗃**Organisation**
- Créations des **BluePrints** pour les **Light Dungeons** dans les TileSets
- Mise à jour des Tilesets (pour **Sanctuary**)
- Ajout d'une Dossier de **Ressources/Images** pour les **Artworks**

__--------------------------------------------------------------------------------------------------------------__

## The Legend of Zelda A Link to the Past (Solarus Edition) 0.1.2

`Changements du 23 Février 2024` v0.1.2 (hotfix)

🗺**Overworld**
- __Light Overworld__ : 
- Correction des Bancs de KaKaRiKo
- Correction d'une Superposition de Tiles Décoratives au dessus de Link House

- __Dark Overworld__ : Liens de toutes les Maisons avec le Dark World

🗺**KaKaRiKo Village**
- Correction d'un Jumper qui faisait SoftLock dans un Mur

🗺**Library**
- Correction d'une Tile dans Library

🎮**GameFix**
- Correction d'une Bug avec le Joystick des Manettes dans les Menus (Le Sélecteur ne s'affole plus)
- Correction de Choix Décalé dans le *game_manager.lua*
- Correction des points de vie du Joueur dans le Savegame

📱**HUD**
- Correction des Points de vie afficher dans le HUD

🗃**Organisation**
- Créations des BluePrints pour les Light Dungeons dans les TileSets
- Créations des Dossiers All Floors et Map All Floors pour les Light Dungeons

__--------------------------------------------------------------------------------------------------------------__

`Changements du 21 Janvier 2022` v0.1.1 (hotfix)

🗺**Overworld**
- __Light Overworld__ : Liens de toutes les Grottes, Maisons et Dunjon avec le Light World
- __Dark Overworld__ : Liens de toutes les Maisons avec le Dark World

🗃**Organisation**
- Création des Fichiers .dat pour les Maisons du Light World et du Dark World
- Création des Fichiers .dat pour les Grottes du Light World et du Dark World
- Création des Fichiers .dat pour les Donjons du Light World et du Dark World

__--------------------------------------------------------------------------------------------------------------__

`Changements du 14 Janvier 2022` v0.1.0  

🗺**Overworld**
- __Light Overworld__ : Création de la carte générale 
* Répartition de l'Overworld en différente zone, jouable dans une moindre mesure (sans ennemis)

🗺**Maison**
- __Maison de Link__ : Première map intérieur, la maison de link qui donne sur le monde extérieur

📟**Script**
- Ajout de __Debug.lua__
- Ajout de __Console.lua__
- Ajout de 3 "Custom Entity" pour les Grosses Pierres Blanches, Noires, et Fracassable.

🧠**Debug**
- __Secret Room__ : Salle secrète avec pleins d'objets, de téléporteur vers les différentes zones, maisons, grottes, et donjons pour faciliter les tests 
- Reprise des Scripts Debug/Console de The Only One Projet

🗃**Organisation**
- Création des Dossiers dans data/maps A Link to the Past
    * Répartition des deux mondes Light et Dark Overworld
    * Répartition des Overworld, Maisons, Grottes, Donjons
- Création des Dossiers dans data/maps Archived
    * Répartition des Secret Room et des Owerworlds
    * Répartition Secret Dimension, Overworld, Maisons, Grottes, Donjons
- Ajout et Modification des Logos/Icônes et Artwork
- Ajout et Description du ReadMe
