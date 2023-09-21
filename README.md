# DnD SpellBook

*DnD SpellBook* est disponible en ligne [ici](https://wiwerod.shinyapps.io/DnDSpellbook/)


## Description 

**DnD SpellBook** est une application web qui vous permet de visualiser l'ensemble des sorts officiellement disponibles pour le célèbre jeu de rôle *Dungeons and Dragons* à l'aide de différents outils.

![image](https://user-images.githubusercontent.com/82593320/121702389-1fc6d780-cad2-11eb-957a-22427c424066.png)

### Spell Tree

Cet outil vous permet d'obtenir une visualisation en arbre des différents sorts disponibles en partant de la classe qui vous intéresse, puis du niveau de du sort pour terminer sur le type de sort (école de magie). Il est possible de passer librement et facilement d'une classe à l'autre, ou même d'ouvrir plusieurs *branches* à la fois pour avoir une représentation claire et complète des sorts disponibles par niveau et par type de sort. 

![image](https://user-images.githubusercontent.com/82309920/123537863-03fa3d00-d732-11eb-8e8e-160596a2d0ec.png)
*Ci-dessus un abre montrant les sorts disponibles de la classe du "Warlock" du niveau 1, de l'école de magie de la "divination" et ceux du niveau 6, de l'école de magie de la "necromancie"*

### Spell Comparator 

Cet outil vous permet de comparer deux sorts (une description des sorts est alors affichée) l'un avec l'autre en utilisant les différents boutons en haut de l'outil relatifs à la classe recherchée, du niveau du sort et du sort visé. Suivant les règles officielles, le nombre de sorts qu'un personnage peut apprendre par niveau est limité. Cet outil peut donc s'avérer très utile en cas d'hésitation entre deux sorts particuliers pour réussir à faire le choix le plus optimisé (l'outil montrant également quelle autre classe peut apprendre le sort visé).

![image](https://user-images.githubusercontent.com/82593320/121791208-aa4d2b00-cbe7-11eb-854a-d4c17cd4beb3.png)
*Ci-dessus la comparaison entre deux sort dits "de contrôle" (ayant le même but) avec une liste des autres classes pouvant apprendre l'un ou l'autre sort*

### Spell Extractor 

Finalement le dernier outil vous permet de rechercher précisement un sort en particulier (une description du sort est alors affichée) sur la base de son temps d'incantation, de sa classe, de sa durée, de son niveau d'acquisition ou encore de son type (école de magie). 

![image](https://user-images.githubusercontent.com/82593320/121752473-794df700-cb10-11eb-8c5c-09e47124402c.png)
*Ci-dessus le résultat d'une recherche en spécifiant tous les sorts contenant le mot "beam", qui sont lancés de manière instantanée et de l'école de magie de l'"Evocation"*

De plus, le bouton *Select columns* vous donne la possiblité d'afficher uniquement certains détails d'un sort afin d'épurer votre recherche (de même que le bouton *Show entries* vous permet d'épurer encore davantage le nombre de résultats obtenus).

Il est également possible à l'aide des autres boutons: *CSV, Excel, PDF* d'exporter la liste des sorts sous ces différents formats à votre convenance. 

## Ressources 

### Données

La liste des sorts provient de la base de donnée utilisée pour le projet *dnd5e* et est disponible sur [Github](https://github.com/dndManager/dnd5e).

L'image du squelette en haut à gauche est téléchargeable [ici](https://openclipart.org/download/224584/FightingSkeleton.svg).

La vidéo sur la page d'acceuil peut être visionnée originalement sur *Youtube* à cette [adresse](https://www.youtube.com/watch?v=ANdG2DGm0CQ).

### Traitement

Concernant le traitement, la base de donnée est premièrement réduite au dimensions utiles tels que : le nom du sort, sa description, son temps de lancement, sa classe, sa durée, son niveau et son type (école de magie). On extrait ensuite l'information des différentes classes dans de nouvelles colonnes (détection de virgule dans la colonnes et isolation des mots-clés). On ajoute ensuite la catégorie *"all"* pour les sorts qui sont disponibles à toutes les classes. Le traitement est finalement fini par une renomination des niveaux de scores : par exemple le niveau de 0 devient *"cantrip"* pour mieux refléter les règles du livre.

Aucun autre traitement est nécessaire, le reste se déroule lors de l'exécution (cf. fichier server.R)

### Merci !
