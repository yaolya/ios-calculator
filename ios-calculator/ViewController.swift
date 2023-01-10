//
//  ViewController.swift
//  ios-calculator
//
//  Created by Оля Галягина on 24.12.2022.
//

import UIKit

class customBtn: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }
}

class ViewController: UIViewController {
    
    var userInput = ""
    var parameter1: String? = ""
    var parameter2 = ""
    var function = ""
    var result = 0.0
    
    @IBOutlet weak var holder: UIView!
    
    @IBOutlet weak var numbersHolder: UIView!
    
    @IBOutlet weak var displayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
    }
    
    private func setupButtons() {
        let FontSize:CGFloat = 25
        var buttonSize: CGFloat = 0.0
        if (view.frame.size.width > view.frame.size.height - 300) {
            buttonSize = (view.frame.size.height - 220) / 5
        } else {
            buttonSize = (view.frame.size.width - 20) / 4
        }
        
        
        for i in 0..<9 {
            let btn = customBtn(frame: CGRect(x: buttonSize * CGFloat(i % 3), y: buttonSize*CGFloat(floor(Double(i)/3.0) + 1), width: buttonSize, height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: FontSize)
            btn.setTitle("\(i+1)", for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = i+1
            btn.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        let arr: Array<String> = ["AC", "+/-", "%", "÷", "×", "-", "+", "="]
        for i in 9..<12 {
            let btn = customBtn(frame: CGRect(x: buttonSize * CGFloat(i % 3), y: 0, width: buttonSize, height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: FontSize)
            btn.setTitle(arr[i-9], for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = i+1
            if i == 9 {
                btn.addTarget(self, action: #selector(clearAll(_:)), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
        }
        
        for j in 0...4 {
            let btn = customBtn(frame: CGRect(x: buttonSize * CGFloat(3), y: buttonSize*CGFloat(j), width: buttonSize, height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: FontSize)
            btn.setTitle(arr[3+j], for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = 13 + j
            if j == 4 {
                btn.addTarget(self, action: #selector(result(_:)), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
        }
        
        let zeroBtn = customBtn(frame: CGRect(x: 0, y: buttonSize*CGFloat(4), width: buttonSize*2, height: buttonSize))
        zeroBtn.setTitleColor(.black, for: .normal)
        zeroBtn.backgroundColor = .white
        zeroBtn.titleLabel?.font =  UIFont.systemFont(ofSize: FontSize)
        zeroBtn.setTitle("0", for: .normal)
        numbersHolder.addSubview(zeroBtn)
        zeroBtn.tag = 14
        zeroBtn.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        
        let commaBtn = customBtn(frame: CGRect(x: buttonSize * CGFloat(2), y: buttonSize*CGFloat(4), width: buttonSize, height: buttonSize))
        commaBtn.setTitleColor(.black, for: .normal)
        commaBtn.backgroundColor = .white
        commaBtn.titleLabel?.font =  UIFont.systemFont(ofSize: FontSize)
        commaBtn.setTitle(",", for: .normal)
        numbersHolder.addSubview(commaBtn)
        commaBtn.tag = 14
        commaBtn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
    }
    
    
    @objc func numberPressed(_ sender: UIButton) {
        if sender.tag == 14 {
            if displayLbl.text != "0" {
                displayLbl.text = ""
                userInput += "0"
                displayLbl.text = userInput
            }
        } else {
            displayLbl.text = ""
            userInput += String(sender.tag)
            displayLbl.text = userInput
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal), userInput != "" {
            switch buttonTitle {
            case "+":
                if parameter1 != nil {
                    showResult()
                }
                function  = "+"
                parameter1 = userInput
                userInput = ""
            case "÷":
                if parameter1 != nil {
                    showResult()
                }
                function  = "÷"
                parameter1 = userInput
                userInput = ""
            case "-":
                if parameter1 != nil {
                    showResult()
                }
                function  = "-"
                parameter1 = userInput
                userInput = ""
            case "×":
                if parameter1 != nil {
                    showResult()
                }
                function  = "×"
                parameter1 = userInput
                userInput = ""
            case "%":
                if userInput != "" {
                    let num = Double(userInput)
                    if let num = num {
                        displayLbl.text = ""
                        userInput = String(num/100)
                        displayLbl.text = userInput
                    }
                } else {
                    if var parameter1 = parameter1 {
                        let num = Double(parameter1)
                        if let num = num {
                            displayLbl.text = ""
                            parameter1 = String(num/100)
                            displayLbl.text = parameter1
                        }
                    }
                }
            case "+/-":
                let num = Double(userInput)
                if let num = num, userInput != "" {
                    displayLbl.text = ""
                    let result = -num
                    if floor(result) == result {userInput = String(Int(result))} else {userInput = String(result)}
                    displayLbl.text = userInput
                }
            case ",":
                if let _ = Double(userInput + ".") {
                    displayLbl.text = ""
                    userInput += "."
                    displayLbl.text = userInput
                }
            default:
                print("")
            }
          }
    }
    
    @objc func clearAll(_ sender: UIButton) {
        displayLbl.text = "0"
        parameter1 = nil
        parameter2 = ""
        userInput = ""
    }
    
    private func showResult() {
        parameter2 = userInput
        if let parameter1 = parameter1 {
            let p1 = Double(parameter1)
            let p2 = Double(parameter2)
            if let num1 = p1 {
                if let num2 = p2 {
                    switch function {
                    case "÷":
                        result = num1 / num2
                    case "×":
                        result = num1 * num2
                    case "+":
                        result = num1 + num2
                    case "-":
                        result = num1 - num2
                    default:
                        result = 0
                    }
                    if floor(result) == result {
                        displayLbl.text = String(Int(result))
                        userInput = String(Int(result))
                    } else {
                        displayLbl.text = String(result)
                        userInput = String(result)
                    }
                }
            }
        }
        parameter1 = nil
    }
    
    @objc func result(_ sender: UIButton) {
        showResult()
    }
}












