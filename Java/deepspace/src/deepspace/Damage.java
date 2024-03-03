/**
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 * 2ºDGIIM         PDOO
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

import java.util.ArrayList;

/**
 * Clase abstracta cuyas instancias representan el daño producido a una estación
 * espacial por una nave enemiga cuando se pierde un combate.
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public abstract class Damage {
    
    int nShields;
       
    /**
     * Constructor
     */
    Damage(int s) {
        nShields = s;
    }
    
    /**
     * Método de copia
     * @return nueva instancia Damage de estado igual a la implícita
     */
    public abstract Damage copy();
    
    public abstract DamageToUI getUIversion();
    
    /**
     * Método auxiliar para adjust.
     * Devuelve el mínimo entre el número recibido y nShields
     * @param shields número de escudos al que ajustar el Damage
     * @return mínimo entre el número recibido y nShields
     */
    int adjustNShields(ArrayList<ShieldBooster> shields) {
        return Integer.min(nShields, shields.size());
    }    
    
    /**
     * Devuelve una versión ajustada del objeto a las colecciones de armas y
     * potenciadores de escudos suministradas como parámetro.
     * Partiendo del daño representado por el objeto que recibe este mensaje, se
     * devuelve una copia del mismo pero reducida si es necesario para que no
     * implique perder armas o potenciadores de escudos que no están en las
     * colecciones de los parámetros
     * @param w colección de armas del jugador
     * @param s colección de potenciadores de escudo del jugador
     * @return copia ajustada de la instancia Damage
     */
    public abstract Damage adjust(ArrayList<Weapon> w, ArrayList<ShieldBooster> s);
    
    /**
     * Si la instancia dispone de una lista de tipos concretos de armas, intenta
     * eliminar el tipo del arma pasada como parámetro de esa lista
     * En otro caso simplemente decrementa en una unidad el contador de armas
     * que deben ser eliminadas.
     * Ese contador no puede ser inferior a cero en ningún caso.
     * @param w 
     */
    public abstract void discardWeapon(Weapon w);
    
    
    /**
     * Decrementa en una unidad el número de potenciadores de escudo que deben
     * ser eliminados.
     * Ese contador no puede ser inferior a cero en ningún caso.
     */
    public void discardShieldBooster() {
        nShields = Integer.max(nShields-1, 0);
    }
    
    /**
     * Devuelve true si el daño representado no tiene ningún efecto
     * Esto quiere decir que no implica la pérdida de ningún tipo de accesorio
     * (armas o potenciadores de escudo).
     * @return true si no se pierden accesorios / false en caso contrario
     */
    public boolean hasNoEffect() {
        return nShields == 0;
    }
    
    /**
     * Consultor del número de escudos
     * @return nShields
     */
    public int getNShields() {
        return nShields;
    }
       
    
    @Override
    public String toString() {
        return "nShields: " + nShields;
    }
}
