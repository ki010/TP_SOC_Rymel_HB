Le tutoriel fourni nous guide dans le developpement d'un composant sur Qsys. 

Les composants Qsys sont des modules ou circuits implementant une certant fonctionnalité et qui possedent des interfaces externes 
permettant la communication. Il y a plusieurs types d'interfaces dites Avalon, dont certaines qui sont requises comme la Avalon Clock 
Interface pour le signal d'horloge et la Avalon Reset Intrface permettant la commande ou reception d'un signal de reset. 

Dans notre cas, le composant à réaliser est basé sur un Avalon Memory-Mapped Interface qui est une interface de lecture et écriture
à adresses. Ce composant est un registre sur 16 bits pouvant être vu de l'extérieur, lu et écrit comme un périphérique esclave.
Comme sorties possibles, des afficheurs LEDs ou 7-segments, comme nous pouvons le voir dans le diagramme reg16_avalon_interface.png.

