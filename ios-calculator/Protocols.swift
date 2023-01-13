//
//  Protocols.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

//Presenter -> ViewController
public protocol CalculatorViewControllerProtocol: AnyObject {
    var presenter: CalculatorPresenterProtocol? { get set }
    
    func showResult(_ model: CalculatorModel)
}

//ViewController -> Presenter
public protocol CalculatorPresenterProtocol: AnyObject {
    var viewController: CalculatorViewControllerProtocol? { get set }
    var interactor: CalculatorInteractorInputProtocol? { get set }
    
    func addDigit(_ digit: Character)
    func addOperation(_ operation: Character)
    func calculateResult()
    func clearAll()
    
    func formViewModel(_ model: CalculatorModel)
}

// Presenter -> Interactor
public protocol CalculatorInteractorInputProtocol: AnyObject {
    var presenter: CalculatorInteractorOutputProtocol? { get set }
    var worker: CalculatorWorkerProtocol? { get set }
    
    func getOperation()
    func getDigit()
    func getClearCmd()
    func getResultCmd()
}

// Interactor -> Presenter
public protocol CalculatorInteractorOutputProtocol: AnyObject {
    
    func getResultFromWorker()
    
}

// Worker 
public protocol CalculatorWorkerProtocol: AnyObject {
    func appendInput()
    func updateFunction()
    func calculateResult()
    func clearAll()
}
