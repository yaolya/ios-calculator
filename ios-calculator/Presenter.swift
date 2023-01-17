//
//  Presenter.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation
import UIKit

public class Presenter: PresenterProtocol {
    
    weak var output: ViewControllerProtocol?
    public var interactor: InteractorInputProtocol?
    private let calculatorModel: CalculatorModel
    
    public init(model: CalculatorModel?) {
        if let model = model {
            self.calculatorModel = model
        } else {
            self.calculatorModel = CalculatorModel(userInput: "", displayText: "0", parameter1: nil, parameter2: nil, function: nil, result: nil, history: nil)
        }
    }
    
    
    public func addDigit(digit: Int) {
        interactor?.getDigit(model: calculatorModel, digit: digit)
    }
    public func addOperation(operation: Character) {
        interactor?.getOperation(model: calculatorModel, operation: operation)
    }
    public func calculateResult() {
        interactor?.getResultCmd(model: calculatorModel)
    }
    public func clearAll() {
        interactor?.getClearCmd(model: calculatorModel)
    }
    public func formViewModel() {
        if let output = self.output {
            output.showResult(model: calculatorModel)
        }
    }
}
