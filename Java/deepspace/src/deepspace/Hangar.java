/* @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 * 2ºDGIIM         PDOO
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package deepspace;

import java.util.ArrayList;

/**
 * Esta clase representa el Hangar y sus múltiples atributos así como el espacio
 * del que se dispone y las armas que se tienen
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */

public class Hangar {
    
    private int maxElements;
    
    // Atributos de referencia
    
    private ArrayList<Weapon> weapons = new ArrayList<>();
    private ArrayList<ShieldBooster> shieldBoosters = new ArrayList<>();
    
    /**
     * Constructor con parámetros
     * @param capacity número máximo de elementos del hangar
     */
    Hangar(int capacity) { maxElements = capacity; }
    
    /**
     * Constructor de copia
     * @param h Hangar a copiar
     */
    Hangar(Hangar h) {
        maxElements = h.maxElements;
        weapons = h.getWeapons();
        shieldBoosters = h.getShieldBoosters();
    }
    
    HangarToUI getUIversion() {
        return (new HangarToUI(this));
    }    
    
    /**
     * Indica si hay espacio disponible en el Hangar
     * @return Devuelve true si el número de elementos es menor que maxElements
     * y false si es igual
     */   
    private boolean spaceAvailable() {
        return (weapons.size()+shieldBoosters.size() < maxElements);
    }

      
    /**
     * Añade el arma al Hangar si queda espacio
     * @param w Arma a añadir
     * @return true (se ha añadido) / false (no se ha podido añadir)
     */    
    public boolean addWeapon(Weapon w) {
        if (spaceAvailable())
            return weapons.add(w);
       
        return false;
    }
    
    /**
     * Añade el potenciador de escudo al Hangar si queda espacio
     * @param s Potenciador de escudo a añadir
     * @return true (se ha añadido) / false (no se ha podido añadir)
     */
    public boolean addShieldBooster(ShieldBooster s) {
        if (spaceAvailable())
            return shieldBoosters.add(s);
        
        return false;
    }
    
    /**
     * Consultor de maxElements (capacidad del hangar)
     * @return maxElements
     */
    public int getMaxElements() { return maxElements; }   
    
    /**
     * Consultor de shieldBoosters (colección de potenciadores de escudo)
     * @return shieldBoosters
     */    
    public ArrayList<ShieldBooster> getShieldBoosters() {
        return shieldBoosters;
    }
        
    /**
     * Consultor de weapons (colección de armas)
     * @return weapons
     */    
    public ArrayList<Weapon> getWeapons() {
        return weapons;
    }
        
    /**
     * Elimina el potenciador de escudo número s del hangar y lo devuelve,
     * siempre que este exista, si el índice suministrado es incorrecto
     * devuelve null.
     * @param s índice del shieldBooster a eliminar
     * @return elemento eliminado / null si no se pudo eliminar
     */    
    public ShieldBooster removeShieldBooster(int s) {
        if (0 <= s && s < shieldBoosters.size()) {
            return shieldBoosters.remove(s); // devuelve el obj, eliminado
        }
        return null; 
    }
    
    /**
     * Elimina el arma número w del hangar y la devuelve, siempre que esta
     * exista, si el índice suministrado es incorrecto devuelve null.
     * @param w índice del arma a eliminar
     * @return elemento eliminado / null si no se pudo eliminar
     */ 
    public Weapon removeWeapon(int w) {
        if (0 <= w && w < weapons.size()) {
            return weapons.remove(w);
        }
        return null; 
    } 
    
    @Override
    public String toString(){
        String result;
        
        result =  "maxElements: " + maxElements;
        if (weapons != null)
                result += ", weapons:" + weapons.toString();
        if (shieldBoosters != null)
                result +=  ", shieldBoosters: " + shieldBoosters.toString();
        return result;
    }
}