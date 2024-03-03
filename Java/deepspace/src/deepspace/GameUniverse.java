/* @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 * 2ºDGIIM         PDOO
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

import java.util.ArrayList;

/**
 * Esta clase representa el universo de juego
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class GameUniverse {
    
    private static final int WIN = 10;
    private int currentStationIndex;
    private int turns;
    private boolean haveSpaceCity;
    
    // Atributos de referencia
    
    private GameStateController gameState = null;
    private Dice dice = null;
    private SpaceStation currentStation = null;
    private ArrayList<SpaceStation> spaceStations = null;
    private EnemyStarShip currentEnemy = null;
    
    public GameUniverse() {
        currentStationIndex = -1;
        turns = 0;
        gameState = new GameStateController();
        dice = new Dice();
        currentStation = null;
        spaceStations  = null;
        currentEnemy = null;
        haveSpaceCity = false;
    }
    
    /**
     * Se realiza un combate entre la estación espacial y el enemigo que se 
     * reciben como parámetros. Se sigue el procedimiento descrito en las reglas
     * del juego: sorteo de quién dispara primero, posibilidad de escapar, 
     * asignación del botín, anotación del daño pendiente, etc. Se devuelve el 
     * resultado del combate.
     * @param station Espación espacial participante en el combate
     * @param enemy Enemigo participante en el combate
     * @return El resultado del combate
     */
    CombatResult combat(SpaceStation station, EnemyStarShip enemy) {
        CombatResult combatResult;
        boolean enemyWins;

        if (dice.firstShot() == GameCharacter.ENEMYSTARSHIP){
            float fire = enemy.fire();
            ShotResult result = station.receiveShot(fire);

            if (result == ShotResult.RESIST){
                fire = station.fire();
                result = station.receiveShot(fire);
                enemyWins = (result == ShotResult.RESIST);
            }
            else    enemyWins = true;
        }
        else{
            float fire = station.fire();
            ShotResult result = enemy.receiveShot(fire);
            enemyWins = (result == ShotResult.RESIST);
        }

        if (enemyWins){
            if (!dice.spaceStationMoves(station.getSpeed())){
                station.setPendingDamage(enemy.getDamage());
                combatResult = CombatResult.ENEMYWINS;
            } else{
                station.move();
                combatResult = CombatResult.STATIONESCAPES;
            }
        }
        else{
            Loot aLoot = enemy.getLoot();
            Transformation t = station.setLoot(aLoot);
            combatResult = CombatResult.STATIONWINS;
            
            if (t == Transformation.GETEFFICIENT) {
                makeStationEfficient();
                combatResult = CombatResult.STATIONWINSANDCONVERTS;
            } else if (t == Transformation.SPACECITY) {
                createSpaceCity();
                combatResult = CombatResult.STATIONWINSANDCONVERTS;
            }   
        }
        
        gameState.next(turns, spaceStations.size());
        return combatResult;
    }
    
    /**
     * Si la aplicación se encuentra en un estado en donde el combatir está 
     * permitido, se realiza un combate entre la estación espacial que tiene el 
     * turno y el enemigo actual. Se devuelve el resultado del combate.
     * @return El resultado del combate.
     */
    public CombatResult combat() {
        GameState state = getState();
        if (state == GameState.BEFORECOMBAT || state == GameState.INIT)
            return combat(currentStation, currentEnemy);
        else
            return CombatResult.NOCOMBAT;
    }

    /**
     * Fija la referencia del hangar de la estación actual a null para indicar
     * que no se dispone del mismo.
     * Delega en el método homónimo de la estación espacial que tenga el turno
     * siempre que el estado del juego sea INIT o AFTERCOMBAT
     */    
    public void discardHangar() {
        GameState state = getState();
        if (state == GameState.INIT || state == GameState.AFTERCOMBAT) {
            currentStation.discardHangar();
        }
    }
    
    /** 
     * Delega en el método homónimo de la estación espacial que tenga el turno
     * siempre que el estado del juego sea INIT o AFTERCOMBAT
     */
    public void discardShieldBooster(int i) {
        GameState state = getState();
        if (state == GameState.INIT || state == GameState.AFTERCOMBAT) {
            currentStation.discardShieldBooster(i);
        }
    }
    
    /**
     * Si se dispone de hangar en la estación espacial actual, se solicita al
     * mismo descartar el potenciador de escudo con índice i.
     * Delega en el método homónimo de la estación espacial que tenga el turno
     * siempre que el estado del juego sea INIT o AFTERCOMBAT
     * @param i índice en el hangar del potenciador a descartar
     */
    public void discardShieldBoosterInHangar(int i) {
        GameState state = getState();
        if (state == GameState.INIT || state == GameState.AFTERCOMBAT) {
            currentStation.discardShieldBoosterInHangar(i);
        }
    }
    
    /**
     * Delega en el método homónimo de la estación espacial que tenga el turno
     * siempre que el estado del juego sea INIT o AFTERCOMBAT
     */
    public void discardWeapon(int i) {
        GameState state = getState(); 
        if (state == GameState.INIT || state == GameState.AFTERCOMBAT) {
            currentStation.discardWeapon(i);
        }
    }
    
    /**
     * Si se dispone de hangar en la estación espacial actual, se solicita al
     * mismo descartar el arma con índice i.
     * Delega en el método homónimo de la estación espacial que tenga el turno
     * siempre que el estado del juego sea INIT o AFTERCOMBAT
     * @param i índice en el hangar del arma a descartar
     */ 
    public void discardWeaponInHangar(int i) {
        GameState state = getState();
        if (state == GameState.INIT || state == GameState.AFTERCOMBAT) {
            currentStation.discardWeaponInHangar(i);
        }
    }
    
    /**
     * Consultor del estado del juego
     * @return gameState.getState
     */
    public GameState getState() {
        return gameState.getState();
    }
    
    public GameUniverseToUI getUIversion() {
        return (new GameUniverseToUI(currentStation, currentEnemy));
    }
    
    /**
     * Devuelve true si la estación espacial que tiene el turno ha llegado al 
     * número de medallas necesarias para ganar.
     * @return true (la estación espacial ha ganado) / false (no ha ganado)
     */
    public boolean haveAWinner() {
        return (currentStation.getNMedals() >= WIN);
    }
    
    /**
     * Este método inicia una partida. 
     * Recibe una colección con los nombres de los jugadores. Para cada jugador, 
     * se crea una estación espacial y se equipa con suministros, hangares, armas 
     * y potenciadores de escudos tomados de los mazos de cartas correspondientes. 
     * Se sortea qué jugador comienza la partida, se establece el primer enemigo y
     * comienza el primer turno.
     * @param names coleccion de nombres de jugadores.
     */
    public void init(ArrayList<String> names) {
        if (getState() == GameState.CANNOTPLAY){
            spaceStations = new ArrayList<>();
            CardDealer dealer = CardDealer.getInstance();
            for (int i = 0; i < names.size(); i++){
                SpaceStation station = new SpaceStation(names.get(i), dealer.nextSuppliesPackage());
                spaceStations.add(station);
                Loot lo = new Loot(0, dice.initWithNWeapons(), dice.initWithNShields(), dice.initWithNHangars(), 0);
                station.setLoot(lo);
            }
            currentStationIndex = dice.whoStarts(names.size());
            currentStation = spaceStations.get(currentStationIndex);
            currentEnemy = dealer.nextEnemy();
            gameState.next(turns, spaceStations.size());
        }
    }
    
    /**
     * Se intenta montar el potenciador de escudo con el índice i dentro del
     * hangar de la estación actual.
     * Delega en el método homónimo de la estación espacial que tenga el turno
     * siempre que el estado del juego sea INIT o AFTERCOMBAT
     * @param i índice en el hangar del potenciador de escudo que queremos
     * añadir a la colección de potenciadores en uso
     */
    public void mountShieldBooster(int i) {
        GameState state = getState();
        if (state == GameState.INIT || state == GameState.AFTERCOMBAT) {
            currentStation.mountShieldBooster(i);
        }
    }
    
    /**
     * Se intenta montar el arma con el índice i dentro del hangar.
     * Delega en el método homónimo de la estación espacial que tenga el turno
     * siempre que el estado del juego sea INIT o AFTERCOMBAT
     * @param i índice en el hangar del arma que queremos añadir a la colección
     * de armas en uso
     */
    public void mountWeapon(int i) {
        GameState state = getState();
        if (state == GameState.INIT || state == GameState.AFTERCOMBAT) {
            currentStation.mountWeapon(i);
        }
    }
    
    /**
     * Se comprueba que el jugador actual no tiene ningún daño pendiente de cumplir, 
     * en cuyo caso se realiza un cambio de turno al siguiente jugador con un 
     * nuevo enemigo con quien combatir, devolviendo true. Se devuelve false en otro caso.
     * @return True si no tiene daño pendiente que cumplir, false en caso contrario.
     */
    public boolean nextTurn() {
        if (getState() == GameState.AFTERCOMBAT){
            if (currentStation.validState()){
                currentStationIndex = (currentStationIndex+1)%spaceStations.size();
                turns++;
                currentStation = spaceStations.get(currentStationIndex);
                currentStation.cleanUpMountedItems();
                CardDealer dealer = CardDealer.getInstance();
                currentEnemy = dealer.nextEnemy();
                gameState.next(turns, spaceStations.size());
                
                return true;
            }
            return false; 
        }
        return false;
    }
    
    private void makeStationEfficient() {
        currentStation = new PowerEfficientSpaceStation(currentStation);
        if (dice.extraEfficiency())
            currentStation = new BetaPowerEfficientSpaceStation(currentStation);
        spaceStations.set(currentStationIndex, currentStation);
    }
    
    private void createSpaceCity() {
        if (!haveSpaceCity) {
            ArrayList<SpaceStation> otras = new ArrayList<>(spaceStations);
            otras.remove(currentStation);
            currentStation = new SpaceCity(currentStation, otras);
            haveSpaceCity = true;
            spaceStations.set(currentStationIndex, currentStation);
        }
    }
    
    @Override
    public String toString(){
        String result;
        
        result = "currentStationIndex: " + currentStationIndex;
        result +=  ", turns: "  + turns + ", gameState: " + gameState;
        if (currentStation != null) 
                result += ", currentStation: " + currentStation.toString();
        if (spaceStations != null) 
                result += ", spaceStations: " + spaceStations.toString();
        if (currentEnemy != null) 
                result += ", currentEnemy: " + currentEnemy.toString();
        return result;
    }
}