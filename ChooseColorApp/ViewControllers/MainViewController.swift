//
//  MainViewController.swift
//  ChooseColorApp
//
//  Created by Виталий on 06.03.2021.
//

import UIKit

protocol ChangeColorDelegate {
    func changeColor(color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsViewController = segue.destination as? SettingsViewController {
            settingsViewController.changeColorDelegate = self
            settingsViewController.resultColor = view.backgroundColor
        }
    }

}

extension MainViewController: ChangeColorDelegate {
    
    func changeColor(color: UIColor) {
        view.backgroundColor = color
    }
    
}
