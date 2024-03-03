/*
@authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
2ºDGIIM         PDOO


 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Esta clase representa a un paquete de suministros para una estación espacial
 * Puede contener armamento, combustible y/o energía para los escudos.
 */
class SuppliesPackage {         // Visibilidad de paquete, no ponemos nada

    private float ammoPower;
    private float fuelUnits;
    private float shieldPower;
    
    // Constructor con visibilad de paquete que recibe como parámetro un
    // valor para cada uno de los atributos de la clase. 
    
    SuppliesPackage (float ammoPowergiven, float fuelUnitsgiven, float shieldPowergiven){
        
        ammoPower = ammoPowergiven;
        fuelUnits = fuelUnitsgiven;
        shieldPower = shieldPowergiven;
    }
    
    // Constructor copia con visibilidad de paquete.
    
    SuppliesPackage (SuppliesPackage s){
        
        ammoPower = s.ammoPower;
        fuelUnits = s.fuelUnits;
        shieldPower = s.shieldPower;
    }
    
    // Consultor público para el atributo ammoPower
    
    public float getAmmoPower (){
        
        return ammoPower;
    }
    
    // Consultor público para el atributo fuelUnits
    
    public float getFuelUnits (){
        
        return fuelUnits;
    }
    
    // Consultor público para el atributo shieldPower
    
    public float getShielPower (){
        
        return shieldPower;
    }
    
    /**
     * Método toString
     * @return String que representa el objeto SuppliesPackage
     */
    public String toString() {
        return "Ammo Power: "+ammoPower+", Fuel Units: "+fuelUnits+
                ", Shield Power: "+shieldPower;
    }
    
}
