/*
@authors Manuel Diaz-Meco Terrés y Ana Graciani Donaire
2ºDGIIM         PDOO


 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package deepspace;

/**
 * Este enumerado representa a los tipos de armas del juego Cada tipo de arma 
 * tiene un valor numérico asociado igual a su potencia de disparo
 */
public enum WeaponType {
    
    LASER((float)2.0),
    MISSILE((float)3.0),
    PLASMA((float)4.0);
    
    private final float power;
    
    // Constructor
    WeaponType(float p) { power= p; }
    
    // Consultor
    float getPower() { return power; }
    
}