/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import View.DeepSpaceView;
import View.GUI.MainWindow;
import controller.Controller;
import deepspace.GameUniverse;

/**
 *
 * @author Profe
 */
public class PlayWithUI {
    public static void main(String[] args) {
      GameUniverse game = new GameUniverse();
        DeepSpaceView view = MainWindow.getInstance();
        Controller controller = Controller.getInstance();
        controller.setModelView(game, view);
        controller.start();   
    }
  
}
