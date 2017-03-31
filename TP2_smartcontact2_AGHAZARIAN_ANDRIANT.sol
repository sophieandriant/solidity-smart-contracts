pragma solidity ^0.4.8;
contract PointFidelite {

uint numBlockFin;
string nomSociete;

// Structure de chacun des client
struct Client{
 string nom;
 address clePublique;
 uint numCarteFidelite;
 uint pointFidelite;
}

// Tableau des clients
Client[] ListeClients;

// Gérant base de donnée points de fidélité
address Gerant;

// gestin des droits : seul le gérant peut appeler la fonction
modifier isGerant(){
    if(msg.sender!=Gerant) throw;
    _;
}
 


// Constructeur du système de points de fidélités
function SystemeFidelite(uint _numBlockFin, string _nomSociete){
 Gerant = msg.sender;
 numBlockFin = _numBlockFin;
 nomSociete = _nomSociete;
}

// focntion permettant d'ajouter un client.
function ajouterClient(string _nom, address _clePublique, uint _numCarteFidelite) isGerant(){
    ListeClients.push(Client({
        nom : _nom,
        clePublique : _clePublique,
        numCarteFidelite : _numCarteFidelite,
        pointFidelite :0 }));
}


//fonction permettant de modifier le nombre de points de fidélités d'un client.
function modifierPoints(address _clePublique, uint _pointsModifier)  {
    for (uint i=0; i<= ListeClients.length; i++){
        if (_clePublique == ListeClients[i].clePublique){
            ListeClients[i].pointFidelite = ListeClients[i].pointFidelite + _pointsModifier;
        }
    }
}


// fonction qui détruit le prgramme
function kill() isGerant() {
     suicide(msg.sender);
}
}