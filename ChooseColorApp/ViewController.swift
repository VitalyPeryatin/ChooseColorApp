//
//  ViewController.swift
//  ChooseColorApp
//
//  Created by Виталий on 03.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 16
        
        updateAllRgbLabels()
        paintColorView()
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLabel.text = String(format: "%.2f", redSlider.value)
        case 1:
            greenLabel.text = String(format: "%.2f", greenSlider.value)
        case 2:
            blueLabel.text = String(format: "%.2f", blueSlider.value)
        default:
            break
        }
        paintColorView()
    }
    
    private func updateAllRgbLabels() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func paintColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(1.0)
        )
    }
}

