/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

import java.util.ArrayList;

/**
 * Esta clase representa una ciudad espacial
 * @authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
 */
public class SpaceCity extends SpaceStation {
    
    // Atributos de instancia
    
    private ArrayList<SpaceStation> collaborators = null;
    private SpaceStation base = null;
    
    /**
     * Constructor con parámetros
     * @param b Base, estación espacial correspondiente al jugador actual
     * @param rest Colección de las estaciones espaciales del resto de jugadores
     */
    SpaceCity(SpaceStation b, ArrayList<SpaceStation> rest) {
        super(b);
        base = b;
        collaborators = new ArrayList<>(rest);
    }
    
    ArrayList<SpaceStation> getCollaborators() {
        return collaborators;
    }
    
    @Override
    public float fire() {
        float power = super.fire(); // base.fire()
        
        for (SpaceStation station : collaborators) {
            power+= station.fire();
        }
        
        return power;
    }
    
    @Override
    public float protection() {
        float shield = super.protection(); // base.protection()
        
        for (SpaceStation station : collaborators) {
            shield+= station.protection();
        }
        
        return shield;
    }
    
    @Override
    public Transformation setLoot(Loot loot) {
        super.setLoot(loot);
        return Transformation.NOTRANSFORM;
    }
    
    @Override
    public SpaceCityToUI getUIversion() {
        return new SpaceCityToUI(this);
    }
    
}
