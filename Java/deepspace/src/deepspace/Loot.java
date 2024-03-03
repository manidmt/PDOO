/**
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 * 2ºDGIIM         PDOO
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Esta clase representa el botín que se obtiene al vencer a una nave enemiga
 * Puede incluir cantidades representen un número de paquetes de suministros,
 * armas, potenciadores de escudo, hangares y/o medallas.
 */
public class Loot {
    
    private int nSupplies;
    private int nWeapons;
    private int nShields;
    private int nHangars;
    private int nMedals;
    
    private boolean getEfficient = false;
    private boolean spaceCity = false;

    /**
     * Constructor con 5 parámetros, no hay transformaciones
     * @param nSuppgiven
     * @param nWgiven
     * @param nShigiven
     * @param nHgiven
     * @param nMgiven
     * @param ef
     * @param city 
     */
    Loot (int nSuppgiven, int nWgiven, int nShigiven, int nHgiven, int nMgiven) {
        
        nSupplies = nSuppgiven;
        nWeapons = nWgiven;
        nShields = nShigiven;
        nHangars = nHgiven;
        nMedals = nMgiven;
    }

    
    /**
     * Constructor con 7 parámetros, puede haber transformaciones
     * @param nSuppgiven
     * @param nWgiven
     * @param nShigiven
     * @param nHgiven
     * @param nMgiven
     * @param ef
     * @param city 
     */
    Loot (int nSuppgiven, int nWgiven, int nShigiven, int nHgiven, int nMgiven,
          boolean ef, boolean city) {
        
        nSupplies = nSuppgiven;
        nWeapons = nWgiven;
        nShields = nShigiven;
        nHangars = nHgiven;
        nMedals = nMgiven;
        getEfficient = ef;
        spaceCity = city;
    }
    
    // Consultor público para el atributo nSupplies
    
    public int getNSupplies() { return nSupplies; }
    
    // Consultor público para el atributo nWeapons          
    
    public int getNWeapons() { return nWeapons; }
    
    // Consultor público para el atributo nShields
    
    public int getNShields() { return nShields; }
    
    // Constructor público para el atributo nHangars
    
    public int getNHangars() { return nHangars; }
    
    // Consultor público para el atributo nMedals
    
    public int getNMedals() { return nMedals; }
    
    // Consultor público para el atributo efficient
    
    public boolean getEfficient() { return getEfficient; }
    
    // Consultor público para el atributo spaceCity
    
    public boolean spaceCity() { return spaceCity; }
    
    /**
     * Método toString
     * @return String que representa el objeto Loot
     */
    @Override
    public String toString() {
        return "nSupplies: " + nSupplies + ", nWeapons: " + nWeapons +
                ", nShields: " + nShields + ", nHangars: " + nHangars +
                ", nMedals: " + nMedals + ", efficient: " + getEfficient +
                ", spaceCity: " + spaceCity;
    }
    
        LootToUI getUIversion() {
        return (new LootToUI(this));
    }
}
