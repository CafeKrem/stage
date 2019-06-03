# Rapport hebdomadaire 
# Dutriez Clement 

## info stage 
* tuteur de stage : Cyril Ferlicot-Delbecque 
* lieu de stage : Inria
* équipe RMoD ,équipe de recherche dans le génie logiciel , notamment sur 2 axes (merci google , je vais voir avec Stéphane des qu’il aura le temps pour comprendre un peu mieux leur recherches ) :
	* réingénierie  :
		* analyse de code/architecture (Moose )
		* qualité du code  
	* langage objet orienté réflexivité :
		* Trait 
		* Reflexivité  
* sujet de stage:  développement d’interfaces graphiques avec Spec  ( une framework  écrit en pharo )
* listing des projet 
	* migration des interfaces de refactoring  **review it**
	* migration du SystemReporter (une fenêtre qui donne des info sur le système ) **STOP** 
	* migration du CriticBrowser (interface utilise pour verifier que certain package verifie certaine regle donne a la creation de la class ) **EN COURS**
		* UIManager seras remplacer plus tard par un composant Spec.je suis abonné à l’issue sur ce probleme 
	* Merlin ( un outils qui permettras de créer des wizard plus facilement dans Moose  )  **PAS ENCORE COMMENCER**


## Semaine du 8 Avril


* pair programming avec mon tuteur de stage , ce que j’en tire
	* meilleur utilisation du débogueur pharo et de l’IDE de manière générale  
	* compréhension global de spec 2
	* utilisation de git (rédaction d’issue , le coté OpenDev)
	* formation sur spec 2
	* fin de semaine 1er projet :
		* migration de leur ancienne interface de refactoring vers Spec 2

## Semaine du 14 Avril 


* continue sur le projet de migration
* pair programming avec mon tuteur de stage :
	* découverte de  Moose ( plateforme d’analyse de projet informatique  ) 
		* formation sur les meta-modèle , comment faire des requettes sur des arbres de contenance et de dépendances
		* https://moosequery.ferlicot.fr/ 
	* Téléscope (outil de visualisation)
* commence à prendre des note sur spec (quel widget , layout ) pour servir de base de test
 le projet de doctorat de Benoit ,membre de l’équipe RMoD. 
* migration des outils de refactoring interrompu , besoin de composant qui ne sont pas encore intégré  
* (vendredi 19 Avril) je commence à travailler sur la migration du systemReporter 
* certaines classes que je devais migrais on était stoppé étant donné qu’il manque certain composant dans Spec 2  
* (vendredi 19 Avril) Je commence à travailler sur CriticBrowser  

## Semaine du 22 Avril


* j’ai changer ma méthode de travaille que j’essaie de suivre au mieux , suite au conseil de mon frère ,  la voici(je ferai un point la semaine d'après sur l'efficacité de cette méthode ): 
	1- ecrire une documentation (comportement de la class , responsabilite , y a t-il des éléments obsolète ? , roadMap du travail de migration)
	2- ecrire les test (une partie assez dur en fonction des class (je ne voit pas forcément comment tester certaine class ))
	3- migration 
* je continue la migration du criticBrowser
* mon tuteur de stage a fini d’implémenter le composant qui me manquer dès que j’ai fini la migration du CriticBrowser je finirai les projets laissé en suspens
* sprint (phase on l’on corrige le maximum d’issue possible et ça permet de bosser sur autre chose ) avec Pierre , membre de l'équipe RMoD , stagiaire de master , sur l'amélioration de l’AST de pharo.

## Smaine du 29 Avril

* continue la migration du CriticBrowser 
* review du CriticBrowser avec mon tuteur de stage  :
	* Cyril , mon tuteur de stage  , m’as proposer d’extraire certain fonctionnalité afin qu’elle soit plus flexible et maintenable afin d’eviter une class trop grosse 
	* Cyril m’as proposer au lieu de desactiver le button lorsqu’il ne rentre pas dans le cas d’utilisation de laisser l’utilisateur clicker dessus mais juste lui afficher un popup qui dit comment ‘activer’ ce button
* vendredi : conference avec une equipe qui vient de brussels 

## Semaine du 6 Mai

* utilisation de Mocketery (framework de Mock)
* continue CriticsBrowser
* erreur de ma part j’ai report une issue qui avait deja etait report
* 1er contribution a Spec  
* aide Dayne , une stagiaire de master , menbre de l’equipe , sur l'interface de dcTest  

## semaine du 13 Mai

* je continue la migration du criticBrowser
* j'ai fait du pair Programming avec Benoit , un doctorant qui travail sur l'autmatisation de la migration d'interface , nous avons donc travailler sur l'automatisation de la migration de Spec 1 vers Spec 2 . c'est resultat seront donc publier dans un article de recherche pour  [IWST](http://esug.org/wiki/pier/Conferences/2018/International-Workshop-IWST_18)  , j'ecrirais un paragraphe dans cette article  
* j'ai decidé de faire une petite pause du CriticBrowser et de reprendre un projet plus petit (interface de refactoring). le CriticBrowser que je reprendrais apres avoir finie cette tache

## semaine 20 Mai

* interface de refactoring fini review en cours ,  erreur dans mon code:
	* typologie 
* je continue le CriticBrowser :
	* test en cours 
	* je dois changer un des composant de l'interface par un système d'onglet ( exemple navigateur web )
* vendredi : Pharo Sprint / Moose dojo ( la même chose que Pharo sprint )
	* moose dojo avec Benoit: on a travailler sur les moosemodel (ce qui va permettre de définir la sémentique du language qu'on souhaite analyser)
* une étudiante de Google summer of school ,  une sorte de concours qui permet à l'inria d'obtenir des étudiant qui travaillerons pour eux mais payé par google , va vérifier la qualité de mon code avant d'être intégré à pharo

## semaine du 27 Mai

* semaine de 3 jours INRIA fait le pont 
* Objectif: 
	* finir le CriticBrowser , plus que certain element à tester 
 	* rédiger une partie de l'article pour Benoit , le doctorant que j'ai aider pour la rédaction de son article de recherche pour [IWST](http://esug.org/wiki/pier/Conferences/2018/International-Workshop-IWST_18)
* Pair programming avec Hugo , un stagiaire de Licence Informatique de Lille. J'ai donc migrer l'interface qu'il utilisé vers Spec.
* Je continue toujour la migration du CriticBrowser 
	* j'extrait des composant qui ne respect pas les principes SOLID 
* rédaction de l'article de recherche 

## semaine du 3 Juin 

* Objectif:
	* finir le BISettingPreviewer , projet avec Hugo Lasnier
	* finir d'écrire l'article pour Benoît 
	* avancer le plus possible sur le CriticBrowser
 

