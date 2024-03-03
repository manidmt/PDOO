/*
@authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
2ºDGIIM         PDOO


 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Esta clase representa a los potenciadores de escudo que pueden tener las
 * estaciones espaciales.
 */
class ShieldBooster implements CombatElement {       // Visibilidad de paquete
    
    private String name;
    private float boost;
    private int uses;
    
    // Constructor con visibilad de paquete que recibe como parámetro un
    // valor para cada uno de los atributos de la clase.
    
    ShieldBooster (String namegiven, float boostgiven, int usesgiven) {
        name = namegiven;
        boost = boostgiven;
        uses = usesgiven;
    }
    
    // Constructor copia con visibilidad de paquete.
    
    ShieldBooster (ShieldBooster s) {
        name = s.name;
        boost = s.boost;
        uses = s.uses;
    }
    
    // Consultor público para el atributo boost
    
    public float getBoost (){
        return boost;
    }
    
    // Consultor público para el atributo uses
    
    @Override
    public int getUses () {
        return uses;
    }
    
    /**
     * Si el valor del atributo uses es mayor que 0, lo decrementa en una
     * unidad y devuelve el valor del atributo boost
     * Devuelve el valor 1.0 en otro caso.
     */
    
    @Override
    public float useIt(){
        
        float returnvalue = boost;
        
        if (uses > 0)   uses--;
        else returnvalue = 1.0f;
        
        return returnvalue;
    }
    
    /**
     * Método toString
     * @return String que representa el objeto ShieldBooster
     */
    @Override
    public String toString() {
        return "name: " + name + ", boost: " + boost + ", uses: "+uses;
    }
    
    ShieldToUI getUIversion() {
        return (new ShieldToUI(this));        
    }
    
    
    
}
