//
//  Model.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

public enum BinaryOperation: String {
    case add = "+", subtract = "-", multiply = "×", delete = "÷"
}
public enum UnaryOperation: String {
    case percent = "%", makeDouble = ".", changeSign = "±"
}

public class CalculatorModel {

    public struct Operation {
        var firstOperand: String
        var secondOperand: String?
        var function: Character
    }

    public var userInput: String
    public var displayText: String
    public var parameter1: String?
    public var parameter2: String?
    public var function: Character?
    public var result: Double?
    public var history: [Operation]?

    public init(userInput: String, displayText: String, parameter1: String?, parameter2: String?, function: Character?, result: Double?, history: [Operation]?) {
        self.userInput = userInput
        self.displayText = displayText
        self.parameter1 = parameter1
        self.parameter2 = parameter2
        self.function = function
        self.result = result
        self.history = history
    }
}
