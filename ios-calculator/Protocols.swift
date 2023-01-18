//
//  Protocols.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

// Presenter -> ViewController
public protocol ViewControllerProtocol: AnyObject {
    func showResult(model: CalculatorModel)
}

// ViewController -> Presenter
public protocol PresenterProtocol: AnyObject {
    func addDigit(digit: Int)
    func addOperation(operation: String)
    func calculateResult()
    func clearAll()

    func formViewModel()
}

// Presenter -> Interactor
public protocol InteractorInputProtocol: AnyObject {
    func getOperation(model: CalculatorModel, operation: String)
    func getDigit(model: CalculatorModel, digit: Int)
    func getClearCmd(model: CalculatorModel)
    func getResultCmd(model: CalculatorModel)
}

// Worker 
public protocol WorkerProtocol: AnyObject {
    func appendInput(model: CalculatorModel, digit: Int)
    func processBinaryOperation(model: CalculatorModel, operation: BinaryOperation)
    func processUnaryOperation(model: CalculatorModel, operation: UnaryOperation)
    func calculateResult(model: CalculatorModel)
    func clearAll(model: CalculatorModel)
}
