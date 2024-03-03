/**
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 * 2ºDGIIM         PDOO
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Esta clase representa una nave enemiga
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class EnemyStarShip implements SpaceFighter {
    
    private float ammoPower;
    private String name;
    private float shieldPower;
    
    // Atributos de referencia
    
    private Loot loot;
    private Damage damage;
    
    /**
     * Construstor con parámetros
     * @param n name
     * @param a ammoPower
     * @param s shieldPower
     * @param l loot
     * @param d damage
     */
    EnemyStarShip(String n, float a, float s, Loot l, Damage d) {
        name = n;
        ammoPower = a;
        shieldPower = s;
        loot = l;
        damage = d.copy();
    }
    
    EnemyStarShip(EnemyStarShip e) {
        ammoPower = e.ammoPower;
        name = e.name;
        shieldPower = e.shieldPower;
        loot = e.loot;
        damage = e.damage.copy();
    }
    
    EnemyToUI getUIversion() {
        return (new EnemyToUI(this));
    }
    
    /**
     * Devuelve el nivel de energía de disparo de la nave enemiga
     * @return ammoPower
     */
    @Override
    public float fire() {
        return ammoPower;
    }
    
    /**
     * Consultor del nivel de energía de disparo
     * @return ammoPower
     */
    public float getAmmoPower() {
        return ammoPower;
    }
    
    /**
     * Consultor del daño
     * @return damage
     */
    public Damage getDamage() {
        return damage.copy();
    }
    
    /**
     * Consultor del botín
     * @return loot
     */
    public Loot getLoot() {
        return loot;
    }
    
    /**
     * Consultor del nombre de la nave enemiga
     * @return name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Consultor del nivel de energía del escudo
     * @return shieldPower
     */
    public float getShieldPower() {
        return shieldPower;
    }
    
    
    /**
     * Devuelve el nivel de energía del escudo de la nave enemiga
     * @return shieldPower
     */
    @Override
    public float protection() {
        return shieldPower;
    }
    
    /**
     * Devuelve el resultado que se produce al recibir un disparo de una
     * determinada potencia (pasada como parámetro).
     * Si el nivel de la protección de los escudos es menor que la intensidad
     * del disparo, la nave enemiga no resiste (DONOTRESIST). En caso contrario
     * resiste el disparo (RESIST). Se devuelve el resultado producido por el
     * disparo recibido
     * @param shot Potencia del disparo
     * @return RESIST (la nave enemiga resiste) / DONOTRESIST (no resiste)
     */
    @Override
    public ShotResult receiveShot(float shot) {
        ShotResult rvalue = ShotResult.RESIST;
        if (shieldPower < shot) {
            rvalue = ShotResult.DONOTRESIST;
        }
        return rvalue;
    }
    
    @Override
    public String toString(){
        return "ammoPower: " + ammoPower + ", name: " + name + ", shieldPower: "
                + shieldPower + ", loot: " + loot.toString() + ", damage: "
                + damage.toString();
    }
}
