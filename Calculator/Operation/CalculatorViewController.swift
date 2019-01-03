//  CalculatorViewController
//
//  Created by Diego Fernando Cuesta Arevalo on 1/2/19.
//  Copyright © 2019 Diego Fernando Cuesta Arevalo. All rights reserved.

import UIKit

class CalculatorViewController : UIViewController {
    
    @IBOutlet weak var containerButtons : UIView!
    @IBOutlet weak var equalsBtn : UIButton!
    @IBOutlet weak var activeTextSwitch : UISwitch!
    @IBOutlet weak var operationLabel : UILabel!
    @IBOutlet weak var operationTextViewLabel : UITextView!
    
    lazy var viewModel: CalculatorViewModel = {
        return CalculatorViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUi()
    }
    
    private func settingUi(){
        operationTextViewLabel.delegate = self
        operationTextViewLabel.tintColor = UIColor.clear
        activeTextSwitch.addTarget(self, action: #selector(activeTextView), for: .touchUpInside)
        equalsBtn.addTarget(self, action: #selector(equalValue), for: .touchUpInside)
    }
    
    @IBAction func sendNumberValue(_ sender: UIButton){
        guard let number = viewModel.getNumberToTag(tag: sender.tag) else { return }
        viewModel.concatenateValue(newValue: number)
    }
    
    @IBAction func sendOperationValue(sender: UIButton){
        guard let operation = viewModel.getOperationToTag(tag: sender.tag) else { return }
        viewModel.concatenateValue(newValue: operation)
    }
    
    @IBAction func sendSpecialCharacterValue(sender: UIButton){
        guard let character = viewModel.getSpecialCharacterTag(tag: sender.tag) else { return }
        viewModel.concatenateValue(newValue: character)
    }
    
    @IBAction func equalValue(sender: UIButton){
        viewModel.getResult()
    }
    
    @IBAction func clearOpeartion(sender: UIButton){
        viewModel.clearOperation()
    }
    
    @objc func activeTextView(sender: UISwitch){
        if !sender.isOn {
          operationTextViewLabel.resignFirstResponder()
        }else {
           operationTextViewLabel.becomeFirstResponder()
        }
        viewModel.setIsOperationKeyboard(isOperationKeyboard: sender.isOn)
        containerButtons.isHidden = sender.isOn
        equalsBtn.isHidden = !sender.isOn
        operationTextViewLabel.isUserInteractionEnabled = sender.isOn
    }
    
}


extension CalculatorViewController : CalculatorProtocol {
    func resultFailed(newValue: String) {
        operationLabel.textColor = UIColor.red
        operationLabel.text = "Error en la sintaxis de la operación: \(newValue)"
    }
    
    func updateOperationFailed(newValue: String) {
        operationLabel.textColor = UIColor.red
        operationLabel.text = newValue
        operationTextViewLabel.text = newValue
    }
    
    func updateOperationLabel(newValue: String) {
        operationLabel.textColor = UIColor.white
        operationLabel.text = newValue
        operationTextViewLabel.text = newValue
    }
}

extension CalculatorViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == operationTextViewLabel {
            operationLabel.text = textView.text
            viewModel.setOperationToKeyboard(newValue: operationLabel.text! )
        }
    }
}


