//
//  Worker.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

public class Worker: WorkerProtocol {
    
    public func appendInput(model: CalculatorModel, digit: Int) {
        if digit == 0 {
            if model.displayText != "0" {
                model.displayText = ""
                model.userInput += "0"
                model.displayText = model.userInput
            }
        } else {
            model.displayText = ""
            model.userInput += String(digit)
            model.displayText = model.userInput
        }
    }
    
    public func processOperation(model: CalculatorModel, operation: Character) {
        switch operation {
        case "+":
            if model.userInput != "" {
                if model.parameter1 != nil {
                    calculateResult(model: model)
                }
                model.parameter1 = model.userInput
                model.userInput = ""
            }
            model.function  = "+"
        case "-":
            if model.userInput != "" {
                if model.parameter1 != nil {
                    calculateResult(model: model)
                }
                model.parameter1 = model.userInput
                model.userInput = ""
            }
            model.function  = "-"
        case "×":
            if model.userInput != "" {
                if model.parameter1 != nil {
                    calculateResult(model: model)
                }
                model.parameter1 = model.userInput
                model.userInput = ""
            }
            model.function  = "×"
        case "÷":
            if model.userInput != "" {
                if model.parameter1 != nil {
                    calculateResult(model: model)
                }
                model.parameter1 = model.userInput
                model.userInput = ""
            }
            model.function  = "÷"
        case "±":
            let num = Double(model.userInput)
            if let num = num, model.userInput != "" {
                model.displayText = ""
                let result = -num
                if floor(result) == result {
                    model.userInput = String(Int(result))
                } else {
                    model.userInput = String(result)
            }
                model.displayText = model.userInput
        }
        case ",":
            if let _ = Double(model.userInput + ".") {
                model.displayText = ""
                model.userInput += "."
                model.displayText = model.userInput
            }
        case "%":
            if model.userInput != "" {
                let num = Double(model.userInput)
                if let num = num {
                    model.displayText = ""
                    model.userInput = String(num/100)
                    model.displayText = model.userInput
                }
            } else {
                if let parameter1 = model.parameter1 {
                    let num = Double(parameter1)
                    if let num = num {
                        model.displayText = ""
                        model.parameter1 = String(num/100)
                        model.displayText = model.parameter1!
                    }
                }
            }
        default:
            print("default")
        }
    }
    
    public func calculateResult(model: CalculatorModel) {
        model.parameter2 = model.userInput
        if let parameter1 = model.parameter1, let parameter2 = model.parameter2 {
            let p1 = Double(parameter1)
            let p2 = Double(parameter2)
            if let num1 = p1 {
                if let num2 = p2 {
                    switch model.function {
                    case "÷":
                        model.result = num1 / num2
                    case "×":
                        model.result = num1 * num2
                    case "+":
                        model.result = num1 + num2
                    case "-":
                        model.result = num1 - num2
                    default:
                        model.result = 0
                    }
                    if floor(model.result!) == model.result! {
                        model.displayText = String(Int(model.result!))
                        model.userInput = String(Int(model.result!))
                    } else {
                        model.displayText = String(model.result!)
                        model.userInput = String(model.result!)
                    }
                }
            }
        }
        model.parameter1 = nil
    }
    
    public func clearAll(model: CalculatorModel) {
        model.displayText = "0"
        model.function = nil
        model.parameter1 = nil
        model.parameter2 = nil
        model.userInput = ""
        model.result = nil
    }
    
}
