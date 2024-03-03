/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Esta clase representa  el concepto de estación espacial eficiente beta así
 * como sus atributos y funcionalidades
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class BetaPowerEfficientSpaceStation extends PowerEfficientSpaceStation {
    private final static float EXTRAEFFICIENCY = 1.2f;
    private Dice dado = null;
    
    BetaPowerEfficientSpaceStation(SpaceStation station) {
        super(station);
        dado = new Dice();
    }
        
    @Override
    public float fire() {
        if (dado.extraEfficiency())
            return super.fire()*EXTRAEFFICIENCY;
        else
            return super.fire();
    }
    
    @Override
    public BetaPowerEfficientSpaceStationToUI getToUI() {
        return new BetaPowerEfficientSpaceStationToUI(this);
    }
}
