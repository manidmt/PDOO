/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

import java.util.ArrayList;

/**
 * Esta clase hereda de la clase Damage
 * Cada instancia indicará la perdida de una cantidad de potenciadores de escudo
 * y una cantidad de armas
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class NumericDamage extends Damage {
    
    private int nWeapons;
    
    /**
     * Constructor
     * @param w Número de armas
     * @param s Número de escudos
     */
    NumericDamage(int w, int s) {
        super(s);
        nWeapons = w;
    }
    
    /**
     * Método de copia
     * @return nueva instancia NumericDamage de estado igual a la implícita
     */
    @Override
    public NumericDamage copy() {
        return new NumericDamage(getNWeapons(), getNShields());
    }
    
    @Override
    public DamageToUI getUIversion() {
        return new NumericDamageToUI(this);
    }
    
    @Override
    public NumericDamage adjust(ArrayList<Weapon> w, ArrayList<ShieldBooster> s) {   
        return new NumericDamage(Integer.min(nWeapons, w.size()),
                                 adjustNShields(s));
    }
    
    @Override
    public void discardWeapon(Weapon w) {
        nWeapons = Integer.max(0, nWeapons--);
    }    

    @Override
    public boolean hasNoEffect() {
        return (super.hasNoEffect() && nWeapons==0);
    }

    /**
     * Consultor del número de armas
     * @return nWeapons
     */
    public int getNWeapons() {
        return nWeapons;
    }

    @Override
    public String toString() {
        return super.toString() + ", nWeapons: " + nWeapons;
    }    
    
}
