//
//  Model.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

public struct CalculatorModel {
    public enum BinaryOperation: Character {
        case add = "+", subtract = "-", multiply = "×", delete = "÷"
    }
    public enum UnaryOperation: Character {
        case percent = "%", makeDouble = ".", changeSign = "±"
    }
    public enum Digit: Character {
        case one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", zero = "0"
    }
    struct calculatorState {
        var userInput: String
        var parameter1: String?
        var parameter2: String
        var function: Character
        var result: Double
    }
    struct Operation {
        var firstOperand: String
        var secondOperand: String?
        var function: Character
    }
    struct History {
        var operationArray: [Operation]
    }
    struct ViewModel {
        var displayText: String
        var isError: Bool
    }
}
