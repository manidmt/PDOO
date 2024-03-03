/*
@authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
2ºDGIIM         PDOO


 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

import java.util.Random;

/**
 * Esta clase tiene la responsabilidad de tomar todas las decisiones que
 * dependen del azar en el juego.
 */
public class Dice {
    
    // Atributos de instancia privados y constantes
    
    private final float NHANGARSPROB;
    private final float NSHIELDSPROB;
    private final float NWEAPONSPROB;
    private final float FIRSTSHOTPROB;
    private final float EXTRAEFFICIENCYPROB;
    
    // Generador de números pseudo-aleatorios
    
    public Random generator;
    
    /**
     * Constructor por defecto, inicializa todos los atributos de instancia
     * privados
     */
    Dice() {
        
        generator = new Random();
        
        NHANGARSPROB  = (float)0.25;
        NSHIELDSPROB  = (float)0.25;
        NWEAPONSPROB  = (float)0.33;
        FIRSTSHOTPROB = (float)0.50;
        EXTRAEFFICIENCYPROB = (float)0.8;
        
    }
    
    /**
     * Este método determina el número de hangares que recibirá una estación
     * espacial al ser creada.
     * @return rvalue
     */
    int initWithNHangars() {
        int rvalue = 1;
        if (generator.nextFloat() <= NHANGARSPROB) {
            rvalue = 0;
        }
        return rvalue;   
    }
    
    
    /**
     * Este método determina el de armas que recibirá una estación espacial al
     * ser creada.
     * @return rvalue
     */
    int initWithNWeapons() {
        int rvalue = 3;
        float prob = generator.nextFloat();
        if (prob <= NWEAPONSPROB) {
            rvalue = 1;
        } else if (prob <= 2*NWEAPONSPROB) {
            rvalue = 2;
        }
        
        return rvalue;
    }
    
    /**
     * Este método determina el número de potenciadores de escudo que recibirá
     * una estación espacial al ser creada.
     * @return rvalue
     */
    int initWithNShields() {
        int rvalue = 1;
        if (generator.nextFloat() <= NSHIELDSPROB) {
            rvalue = 0;
        }
        return rvalue;         
    }
    
    /**
     * Este método determina el jugador (su índice) que iniciará la partida.
     * @param nPlayers Número de jugadores en la partida
     * @return Índice del jugador que empieza la partida [0, nPlayers-1[
     */
    int whoStarts(int nPlayers) {
        return generator.nextInt(nPlayers);
    }
    
    /**
     * Este método determina quién (de los dos tipos de personajes del juego)
     * dispara primero en un combate: la estación espacial o la nave enemiga.
     * @return Personaje que dispara primero (SPACESTATION o ENEMYSTARSHIP)
     */
    GameCharacter firstShot() {
        if (generator.nextFloat() <= FIRSTSHOTPROB) {
            return GameCharacter.SPACESTATION;
        } else {
            return GameCharacter.ENEMYSTARSHIP;
        }
    }
    
    /**
     * Este método determina si la estación espacial se moverá para esquivar un
     * disparo.
     * @param speed
     * @return True si la estación esquiva el disparo, False en caso contrario
     */
    boolean spaceStationMoves(float speed) {
        boolean rvalue = false;
        if (generator.nextFloat() <= speed) {
           rvalue = true;
        }
        return rvalue;
    } 
    
    boolean extraEfficiency() {
        boolean rvalue = false;
        if (generator.nextFloat() <= EXTRAEFFICIENCYPROB) {
           rvalue = true;
        }
        return rvalue;
    }
}
