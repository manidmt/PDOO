/**
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 * 2ºDGIIM         PDOO
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

import java.util.ArrayList;

/**
 * Esta clase representa una estación espacial
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class SpaceStation implements SpaceFighter {
    
    // Máxima cantidad de unidades de combustible que puede tener una estación
    // espacial
    private static final float MAXFUEL = 100f;
    // Unidades de escudo que se pierden por cada unidad de potencia de disparo
    // recibido
    private static final float SHIELDLOSSPERUNITSHOT = 0.1f;
    
    private float ammoPower;
    private float fuelUnits;
    private String name;
    private int nMedals;
    private float shieldPower;
    
    // Atributos de referencia
    
    private Damage pendingDamage = null;
    private ArrayList<Weapon> weapons = null;
    private ArrayList<ShieldBooster> shieldBoosters = null;
    private Hangar hangar = null; 
    
    
    /**
     * Fija la cantidad de combustible al valor pasado como parámetro sin que
     * nunca se exceda del límite
     * @param f cantidad de combustible a fijar
     */
    private void assignFuelValue(float f) {
        fuelUnits = Math.min(f, MAXFUEL);
        fuelUnits = Math.max(fuelUnits, 0.0f);
    }
    
    /**
     * Si el daño pendiente (pendingDamage) no tiene efecto fija la referencia
     * al mismo a null.
     */
    private void cleanPendingDamage() {
        if (pendingDamage.hasNoEffect()) {
            pendingDamage = null;
        }
    }
    
    /**
     * Constructor con parámetros
     * @param n Nombre de la estación espacial
     * @param supplies Paquete de suministros
     */
    SpaceStation(String n, SuppliesPackage supplies) {
        name = n;
        ammoPower = supplies.getAmmoPower();
        assignFuelValue(supplies.getFuelUnits());
        shieldPower = supplies.getShielPower();
        nMedals = 0;
        pendingDamage = null;
        weapons = new ArrayList<>();
        shieldBoosters = new ArrayList<>();
        hangar = null;
    }
    
    /**
     * Constructor de copia
     * @param station Estación a copiar
     */
    SpaceStation(SpaceStation station) {
        name = station.getName();
        ammoPower = station.getAmmoPower();
        assignFuelValue(station.getFuelUnits());
        shieldPower = station.getShieldPower();
        nMedals = station.getNMedals();
        pendingDamage = station.getPendingDamage();
        weapons = station.getWeapons();
        shieldBoosters = station.getShieldBoosters();
        receiveHangar(station.getHangar());
    }
    
    /**
     * Eliminar todas las armas y los potenciadores de escudo montados a las que
     * no les queden usos.
     */
    public void cleanUpMountedItems() {
        weapons.removeIf(w -> (w.getUses() <= 0));
        shieldBoosters.removeIf(s -> (s.getUses() <= 0));
    }
    
    /**
     * Fija la referencia del hangar a null para indicar que no se dispone del
     * mismo.
     */
    public void discardHangar() {
        hangar = null;
    }
    
    /**
     * Se intenta descartar el potenciador de escudo con índice i de la
     * colección de potenciadores de escudo en uso.
     * Además de perder el potenciador de escudo, se debe actualizar el daño 
     * pendiente (pendingDamage) si es que se tiene alguno.
     * @param i índice del escudo a descartar
     */
    public void discardShieldBooster(int i) {
        if (i >= 0 && i < shieldBoosters.size()){
            ShieldBooster s = shieldBoosters.remove(i);
            if (pendingDamage != null && s != null){
                pendingDamage.discardShieldBooster();
                cleanPendingDamage();
            }
        }
    }
    
    /**
     * Si se dispone de hangar, se solicita al mismo descartar el potenciador de
     * escudo con índice i.
     * @param i índice en el hangar del potenciador a descartar
     */
    public void discardShieldBoosterInHangar(int i) {
        if (hangar != null) { hangar.removeShieldBooster(i); }
    }
    
    /**
     * Se intenta descartar el arma con índice i de la colección de armas en uso.
     * Además de perder el arma, se debe actualizar el daño pendiente 
     * (pendingDamage) si es que se tiene alguno.
     * @param i índice del arma a descartar
     */
    public void discardWeapon(int i) {
        if (i >= 0 && i < weapons.size()){
            Weapon w = weapons.remove(i);
            if (pendingDamage != null && w!=null){
                pendingDamage.discardWeapon(w);
                cleanPendingDamage();
            }
        }
    }
    
    /**
     * Si se dispone de hangar, se solicita al mismo descartar el arma con
     * índice i.
     * @param i índice en el hangar del arma a descartar
     */    
    public void discardWeaponInHangar(int i) {
        if (hangar != null) { hangar.removeWeapon(i); }
    }
    
    /**
     * Realiza un disparo y se devuelve la energía o potencia del mismo.
     * Para ello se multiplica la potencia de disparo por los factores  
     * potenciadores proporcionados por todas las armas.
     * @return factor*ammoPower
     */
    @Override
    public float fire() {
        float factor = 1.0f;
        for (Weapon w : weapons) factor*= w.useIt();

        return (factor*ammoPower);
    }
    
    /**
     * Consultor de la energía de disparo
     * @return ammoPower
     */
    public float getAmmoPower() {
        return ammoPower;
    }
    
    /**
     * Consultor de las unidades de combustible
     * @return fuelUnits
     */
    public float getFuelUnits() {
        return fuelUnits;
    }
    
    /**
     * Consultor del hangar de la estación espacial
     * @return hangar (copia)
     */
    public Hangar getHangar() {
        return hangar;
    }
    
    /**
     * Consultor del nombre de la estación espacial
     * @return name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Consultor del número de medallas
     * @return nMedals
     */
    public int getNMedals() {
        return nMedals;
    }
    
    /**
     * Consultor del daño pendiente de la estación espacial
     * @return pendingDamage
     */
    public Damage getPendingDamage() {
        return pendingDamage;
    }
    
    /**
     * Consultor de la colección de potenciadores de escudo en uso.
     * @return  shieldBoosters
     */
    public ArrayList<ShieldBooster> getShieldBoosters() {
        return shieldBoosters;
    }
    
    /**
     * Consultor de la energía del escudo de la estación espacial.
     * @return shieldPower
     */
    public float getShieldPower() {
        return shieldPower;
    }
    
    /**
     * Devuelve la velocidad de la estación espacial.
     * Esta se calcula como la fracción entre las unidades de combustible de las
     * que dispone en la actualidad la estación espacial respecto al máximo
     * unidades de combustible que es posible almacenar. La velocidad se
     * representa por tanto como un número del intervalo [0,1].
     * @return velocidad
     */
    public float getSpeed() {
        return ((float)fuelUnits/MAXFUEL);
    }
    
    
    public SpaceStationToUI getUIversion() {
        return (new SpaceStationToUI(this));
    }
    
    /**
     * Consultor de la colección de armas en uso.
     * @return weapons
     */
    public ArrayList<Weapon> getWeapons() {
        return weapons;
    }
    
    /**
     * Se intenta montar el potenciador de escudo con el índice i dentro del
     * hangar.
     * Si se dispone de hangar, se le indica que elimine el potenciador de
     * escudo de esa posición y si esta operación tiene éxito (el hangar
     * proporciona el potenciador), se añade el mismo a la colección de
     * potenciadores en uso.
     * @param i índice en el hangar del potenciador de escudo que queremos
     * añadir a la colección de potenciadores en uso
     */
    public void mountShieldBooster(int i) {
        if (hangar != null) {
            ShieldBooster s = hangar.removeShieldBooster(i);
            if (s != null) {
                shieldBoosters.add(s);
            }
        }
    }
    
    /**
     * Se intenta montar el arma con el índice i dentro del hangar.
     * Si se dispone de hangar, se le indica que elimine el arma de esa posición
     * y si esta operación tiene éxito (el hangar proporciona el arma), se añade
     * el arma a la colección de armas en uso.
     * @param i índice en el hangar del arma que queremos añadir a la colección
     * de armas en uso
     */
    public void mountWeapon(int i) {
        if (hangar != null) {
            Weapon w = hangar.removeWeapon(i);
            if (w != null) {
                weapons.add(w);
            }
        }
    }
    
    /**
     * Decremento de unidades de combustible disponibles a causa de un
     * desplazamiento.
     * Al número de las unidades almacenadas se les resta una
     * fracción de las mismas que es igual a la velocidad de la estación. Las
     * unidades de combustible no pueden ser inferiores a 0.
     */
    public void move() {
        assignFuelValue(fuelUnits-(getSpeed()*fuelUnits));
    }
    
    /**
     *  Se usa el escudo de protección y se devuelve la energía del mismo.
     * Para ello se multiplica la potencia del escudo por los factores 
     * potenciadores proporcionados por todos los potenciadores de escudos 
     * de los que se dispone
     * @return factor*shieldPower
     */
    @Override
    public float protection() {
        float factor = 1;
        for (ShieldBooster s : shieldBoosters) {
            factor *= s.useIt();
        }

        return (factor*shieldPower);
    }
    
    /**
     * Si no se dispone de hangar, el parámetro pasa a ser el hangar de la
     * estación espacial.
     * Si ya se dispone de hangar esta operación no tiene efecto.
     * @param h Hangar a añadir
     */
    public void receiveHangar(Hangar h) {
        if (hangar == null && h != null) {
            hangar = new Hangar(h);
        }
    }
    
    /**
     * Si se dispone de hangar, devuelve el resultado de intentar añadir el
     * potenciador de escudo al mismo.
     * Si no se dispone de hangar devuelve false
     * @param s Potenciador de escudo a añadir
     * @return true (se añade) / false (no se puede añadir)
     */
    public boolean receiveShieldBooster(ShieldBooster s) {
        if (hangar != null) {
            return hangar.addShieldBooster(s);
        }
        return false;
    }
    
    /**
     * Realiza las operaciones relacionadas con la recepción del impacto de un 
     * disparo enemigo.
     * Ello implica decrementar la potencia del escudo en función de la 
     * energía del disparo recibido como parámetro y devolver el resultado de si 
     * se ha resistido el disparo o no.
     * @param shot disparo enemigo sobre en base al cual se realizan las operaciones.
     * @return ShotResult.RESIST si se resiste el disparo,  ShotResult.DONOTRESIST
     *  en caso contrario.
     */
    @Override
    public ShotResult receiveShot(float shot) {
        if (protection() >= shot){
            shieldPower = Math.max(0f, shieldPower-SHIELDLOSSPERUNITSHOT*shot);
            return ShotResult.RESIST;
        }
        else{
            shieldPower = 0f;
            return ShotResult.DONOTRESIST;
        }
    }
    
    /**
     * La potencia de disparo, la del escudo y las unidades de combustible se
     * incrementan con el contenido del paquete de suministro.
     * @param s Suministros recibidos
     */
    public void receiveSupplies(SuppliesPackage s) {
        ammoPower+=s.getAmmoPower();
        shieldPower+=s.getShielPower();
        assignFuelValue(fuelUnits+s.getFuelUnits());
    }
    
    /**
     * Si se dispone de hangar, devuelve el resultado de intentar añadir el arma
     * al mismo. Si no se dispone de hangar devuelve false
     * @param w Arma a añadir al hangar
     * @return true (se añade) / false (no se puede añadir)
     */
    public boolean receiveWeapon(Weapon w) {
        if (hangar != null) {
            return hangar.addWeapon(w);
        }
        return false;
    }
    
    /**
     * Recepción de un botín. Por cada elemento que indique el botín (pasado 
     * como parámetro) se le pide a CardDealer un elemento de ese tipo y se 
     * intenta almacenar con el método receive*() correspondiente. Para las 
     * medallas, simplemente se incrementa su número según lo que indique el botín.
     * @param loot botín que se recive
     */
    public Transformation setLoot(Loot loot) {
        
        CardDealer dealer = CardDealer.getInstance();
        
        if(loot.getNHangars() > 0)
            receiveHangar(dealer.nextHangar());
        
        for (int i=0; i<loot.getNSupplies(); i++)
            receiveSupplies(dealer.nextSuppliesPackage());
        
        for (int i=0; i<loot.getNWeapons(); i++)
            receiveWeapon(dealer.nextWeapon());
        
        for (int i=0; i<loot.getNShields(); i++){
            receiveShieldBooster(dealer.nextShieldBooster());
        }
        
        nMedals+= loot.getNMedals();
        
        if (loot.getEfficient())
            return Transformation.GETEFFICIENT;
        else if (loot.spaceCity())
            return Transformation.SPACECITY;
        else
            return Transformation.NOTRANSFORM;
    }
    
    /**
     * Se calcula el parámetro ajustado (adjust) a la lista de armas y
     * potenciadores de escudo de la estación y se almacena el resultado en el
     * atributo correspondiente.
     * @param d Daño
     */
    public void setPendingDamage(Damage d) {
        pendingDamage = d.adjust(weapons, shieldBoosters);
    }
    
    /**
     * Devuelve true si la estación espacial está en un estado válido.
     * Eso implica que o bien no se tiene ningún daño pendiente o que este no
     * tiene efecto.
     * @return 
     */
    public boolean validState() {
        return (pendingDamage == null || pendingDamage.hasNoEffect());
    }
    
    public String toString(){
        String result;
        
        result = "ammoPower: " + ammoPower + ", fuelUnits: " + fuelUnits + ", name: "
                + name + ", nMedals: " + nMedals + ", shieldPower: " + shieldPower;
        if (pendingDamage != null)
                result += ", pendingDamage: " + pendingDamage.toString();
        if (weapons != null)
                result += ", weapons:" + weapons.toString();
        if (shieldBoosters != null)
                result +=  ", shieldBoosters: " + shieldBoosters.toString();
        if (hangar != null)
                result += ", hangar: " + hangar;
        return result;
    }
    
} 