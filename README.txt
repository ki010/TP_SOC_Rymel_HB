Le tutoriel fourni nous guide dans le développement d'un composant sur Qsys. 


Les composants Qsys sont des modules ou circuits implementant une certaine fonctionnalité et qui possedent des interfaces externes 
permettant la communication. Il y a plusieurs types d'interfaces dites Avalon, dont certaines qui sont requises comme la Avalon Clock 
Interface pour le signal d'horloge et la Avalon Reset Interface permettant la commande ou reception d'un signal de reset. 

Dans notre cas, le composant à réaliser est basé sur un Avalon Memory-Mapped Interface qui est une interface de lecture et écriture à adresses. 
Ce composant est un registre sur 16 bits pouvant être vu de l'extérieur, lu et écrit comme un périphérique esclave. Comme sorties possibles, 
des afficheurs LEDs ou 7-segments, comme nous pouvons le voir dans le diagramme reg16_avalon_interface.png.

Pour ce projet, nous partons du Qsys réalisé précédemment constitué d’un processeur Nios II, d’une mémoire interne On-Chip, ainsi que des 
interfaces d’horloge et de reset. Ces éléments forment la base minimale du système embarqué : le processeur exécutera le programme logiciel, 
la mémoire servira au stockage des instructions et des données, et l’Avalon Interconnect assurera la communication entre les différents composants. 


L’interface Avalon-MM fonctionne comme un protocole de communication de type bus selon un modèle maître-esclave. Dans ce système, 
le processeur Nios II est le maître et initie donc les transactions de lecture et d'écriture sur le bus Avalon. Le composant reg16_avalon_interface
agit comme un périphérique esclave mémoire-mappé; il répond aux accès qui lui sont adressés.

L’interaction est synchronisée par le signal clock. Les échanges sont organisés en transactions, évaluées selon le protocole Avalon-MM et 
synchronisées sur l’horloge. Le signal resetn permet de remettre le registre à zéro entre les transactions. Il est synchronisé au fron 
montant de la clock. Les signaux read et write servent à lancer la lecture d'une valeur stockée ou l'écriture quand le registre sera rempli. 

Lors d’une écriture, le processeur place la donnée à stocker sur writedata[15:0]. Le composant modifie son registre s'il reçoit Write mais que si
chipselect est également actif, car ce signal indique que la transaction concerne bien cet esclave sur le bus. Le signal byteenable[1:0] précise 
ensuite quels octets du registre doivent être mis à jour : byteenable[0] correspond à l'octet bas Q[7:0], byteenable[1] à l'octet haut Q[15:8]. 

Enfin, la valeur stockée dans le registre est également exportée vers l’extérieur du système Qsys par le signal Q_export[15:0], à travers une 
interface Avalon Conduit. Cette sortie peut servir à afficher directement la valeur sur des LEDs ou des afficheurs 7 segments, mais elle peut aussi 
être utilisée comme mot de commande pour une logique externe. Par exemple, dans une application de commande moteur.


