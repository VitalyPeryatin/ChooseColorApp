//
//  ViewController.swift
//  ChooseColorApp
//
//  Created by Виталий on 03.03.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var changeColorDelegate: ChangeColorDelegate!
    var resultColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton(to: redTextField, greenTextField, blueTextField)
        
        colorView.layer.cornerRadius = 16
        
        [redTextField, greenTextField, blueTextField].forEach { textField in
            textField.delegate = self
        }
        
        setupAllSliders()
        
        updateColorView()
    }
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            let value = String(format: "%.2f", redSlider.value)
            redLabel.text = value
            redTextField.text = value
        case 1:
            let value = String(format: "%.2f", greenSlider.value)
            greenLabel.text = value
            greenTextField.text = value
        case 2:
            let value = String(format: "%.2f", blueSlider.value)
            blueLabel.text = value
            blueTextField.text = value
        default:
            break
        }
        updateColorView()
    }
    
    @IBAction func doneButtonPressed() {
        changeColorDelegate.changeColor(color: resultColor)
        dismiss(animated: true)
    }
    
    private func updateColorView() {
        resultColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: CGFloat(1.0)
        )
        colorView.backgroundColor = resultColor
    }
}

// MARK: - Initial setup
extension SettingsViewController {
    
    private func setupAllSliders() {
        let color = CIColor(color: resultColor)
        
        redSlider.setValue(Float(color.red), animated: false)
        setActualValues(for: redSlider)
        
        greenSlider.setValue(Float(color.green), animated: false)
        setActualValues(for: greenSlider)
        
        blueSlider.setValue(Float(color.blue), animated: false)
        setActualValues(for: blueSlider)
    }
    
    private func setActualValues(for slider: UISlider) {
        let value = String(format: "%.2f", slider.value)
        
        switch slider {
        case redSlider:
            redLabel.text = value
            redTextField.text = value
        case greenSlider:
            greenLabel.text = value
            greenTextField.text = value
        case blueSlider:
            blueLabel.text = value
            blueTextField.text = value
        default:
            break
        }
    }
}

// MARK: - UITextField delegates
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let colorComponentValue = extractValidColorComponentValue(for: textField)
        
        switch textField {
        case redTextField:
            redSlider.setValue(colorComponentValue, animated: true)
            setActualValues(for: redSlider)
        case greenTextField:
            greenSlider.setValue(colorComponentValue, animated: true)
            setActualValues(for: greenSlider)
        case blueTextField:
            blueSlider.setValue(colorComponentValue, animated: true)
            setActualValues(for: blueSlider)
        default:
            break
        }
        updateColorView()
    }
    
    private func extractValidColorComponentValue(for textField: UITextField) -> Float {
        clamp(value: Float(textField.text ?? "0") ?? 0, lower: 0, upper: 1)
    }
    
    private func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
        return min(max(value, lower), upper)
    }
}

// MARK: - Keyboard setup
extension SettingsViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func addDoneButton(to textFields: UITextField...) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: view,
            action: #selector(UIView.endEditing(_:))
        )
        
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        
        for textField in textFields {
            textField.inputAccessoryView = keyboardToolbar
        }
    }
}

