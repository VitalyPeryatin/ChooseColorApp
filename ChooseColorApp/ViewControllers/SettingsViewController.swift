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
        
        addDoneButtonToNumpadKeyboard()
        
        colorView.layer.cornerRadius = 16
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setupAllSliders()
        setupAllRgbLabels()
        setupAllTextFieldValues()
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
    
    private func setupAllRgbLabels() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setupAllTextFieldValues() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setupAllSliders() {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        
        if resultColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
            redSlider.setValue(Float(red), animated: true)
            greenSlider.setValue(Float(green), animated: true)
            blueSlider.setValue(Float(blue), animated: true)
        }
    }
}

// MARK: - UITextField delegates
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let colorComponentValue = extractValidColorComponentValue(for: textField)
        let colorComponentFormatted = String(format: "%.2f", colorComponentValue)
        switch textField {
        case redTextField:
            redSlider.value = colorComponentValue
            redLabel.text = colorComponentFormatted
            redTextField.text = colorComponentFormatted
        case greenTextField:
            greenSlider.value = colorComponentValue
            greenLabel.text = colorComponentFormatted
            greenTextField.text = colorComponentFormatted
        case blueTextField:
            blueSlider.value = colorComponentValue
            blueLabel.text = colorComponentFormatted
            blueTextField.text = colorComponentFormatted
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
    
    private func addDoneButtonToNumpadKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        redTextField.inputAccessoryView = keyboardToolbar
        greenTextField.inputAccessoryView = keyboardToolbar
        blueTextField.inputAccessoryView = keyboardToolbar
    }
}

