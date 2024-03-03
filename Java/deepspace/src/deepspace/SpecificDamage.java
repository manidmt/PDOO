/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

import java.util.ArrayList;

/**
 * Esta clase hereda de la clase Damage
 * Cada instancia indicará la perdida de una cantidad de potenciadores de escudo 
 * y un conjunto de tipos de armas concretas que se deben eliminar
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class SpecificDamage extends Damage {
    
    private ArrayList<WeaponType> weapons = null;
    
    /**
     * Constructor
     * @param w Colección de WeaponType
     * @param s Número de escudos
     */
    SpecificDamage(ArrayList<WeaponType> w, int s) {
        super(s);
        weapons = w;
    }
    
    /**
     * Método de copia
     * @return nueva instancia SpecificDamage de estado igual a la implícita
     */
    @Override
    public SpecificDamage copy() {
        return new SpecificDamage(getWeapons(), getNShields());
    }
    
    @Override
    public DamageToUI getUIversion() {
        return new SpecificDamageToUI(this);
    }
    
    /**
     * Devuelve el índice de la posición de la primera arma de la colección de
     * armas (primer parámetro) cuyo tipo coincida con el tipo indicado por el
     * segundo parámetro
     * Devuelve -1 si no hay ninguna arma en la colección del tipo indicado por 
     * el segundo parámetro
     * @param w Colección de armas
     * @param t Tipo de arma a buscar en la colección
     * @return índice de la primera arma tipo t / -1 si no hay ninguna
     */
    private int arrayContainsType(ArrayList<Weapon> w, WeaponType t) {
        int rvalue = -1;
        for (int i=0; i<w.size() && rvalue == -1; i++) {
            if (w.get(i).getType() == t) { rvalue = i; }
        }
        
        return rvalue;
    }
    
    
    @Override
    public SpecificDamage adjust(ArrayList<Weapon> w, ArrayList<ShieldBooster> s) {
        
        ArrayList<Weapon> w_copy = new ArrayList<>(w);
        ArrayList<WeaponType> weapons_new = new ArrayList<>();
        int index;
        for (int i=0; i<weapons.size(); i++) {
            if ((index = arrayContainsType(w_copy, weapons.get(i))) != -1) {
                weapons_new.add(w_copy.get(index).getType());
                w_copy.remove(index);
            }
        }
        
        return new SpecificDamage(weapons_new, super.adjustNShields(s));
    }
    
    @Override
    public void discardWeapon(Weapon w) {
        if (weapons != null)
            if (!weapons.isEmpty()) 
                weapons.removeIf( x -> x == w.getType());
    }    
    
    @Override
    public boolean hasNoEffect() {
        return (super.hasNoEffect() && (weapons == null || weapons.isEmpty()));
    }    
    
    /**
     * Consultor de la colección de tipos de armas
     * @return copia de weapons
     */
    public ArrayList<WeaponType> getWeapons() {
        return weapons;
    }

    @Override
    public String toString() {
        return super.toString() + ", weapons: " + weapons.toString();
    }    
    
    
}
