/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Esta clase representa ....
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class PowerEfficientSpaceStation extends SpaceStation {
    private final static float EFFICIENCYFACTOR = 1.10f;
    
    PowerEfficientSpaceStation(SpaceStation station) {
        super(station);
    }
    
    @Override
    public float fire() {
        return super.fire()*EFFICIENCYFACTOR;
    }
    
    @Override
    public float protection() {
        return super.protection()*EFFICIENCYFACTOR;
    }
    
    @Override
    public Transformation setLoot(Loot l) {
        Transformation t = super.setLoot(l);
        if (t == Transformation.SPACECITY)
            return Transformation.NOTRANSFORM;
        else
            return t;        
    }
    
    PowerEfficientSpaceStationToUI getToUI() {
        return new PowerEfficientSpaceStationToUI(this);
    }
    
}
