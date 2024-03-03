/*
@authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
2ºDGIIM         PDOO


 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Esta clase representa a las armas de las que puede disponer una estación
 * espacial para potenciar su energía al disparar.
 */
public class Weapon implements CombatElement {
    
    private String name;
    private WeaponType type = null;
    private int uses;
    
    /**
     * Constructor con parámetros, visibilidad de paquete
     * @param name_
     * @param type_
     * @param uses_ 
     */
    public Weapon (String name_, WeaponType type_, int uses_) {
        name = name_;
        type = type_;
        uses = uses_;
    }
    
     /**
      * Constructor de copia
      * @param w Instancia Weapon a copiar
      */
    Weapon (Weapon w) {
        name = w.name;
        type = w.type;
        uses = w.uses;
    }

    /**
     * Consultor público del atributo type (tipo de arma)
     * @return type 
     */
    public WeaponType getType() {
        return type;
    }
    
    /**
     * Consultor público del atributo uses (usos del arma)
     * @return uses
     */
    @Override
    public int getUses() {
        return uses;
    }
    
    /**
     * Método que devuelve la potencia de disparo del arma
     * @return power indicado por el tipo de arma (type)
     */
    public float power() {
        return type.getPower();
    }
    
    /**
     * Si el valor del atributo uses es mayor que 0, lo decrementa en una
     * unidad y devuelve el valor del atributo boost
     * Devuelve el valor 1.0 en otro caso.
     */
    @Override
    public float useIt() {
        if (uses > 0) {
            uses--;
            return power();
        } else {
            return (float)1.0;
        }
    }
    
    /**
     * Método toString
     * @return String que representa el objeto Weapon
     */
    @Override
    public String toString() {
        
        return "name: " + name + ", type: " + type + ", uses: " + uses;
    }
    
    WeaponToUI getUIversion() {
        return (new WeaponToUI(this));
    }
}
