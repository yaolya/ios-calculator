//
//  Interactor.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

public class Interactor: InteractorInputProtocol {
    public var worker: WorkerProtocol!
    public var output: Presenter!

    public func getOperation(model: CalculatorModel, operation: String) {
        if let enumCase = BinaryOperation(rawValue: operation) {
            worker.processBinaryOperation(model: model, operation: enumCase)
        } else if let enumCase = UnaryOperation(rawValue: operation) {
            worker.processUnaryOperation(model: model, operation: enumCase)
        }
        output.formViewModel()
    }

    public func getDigit(model: CalculatorModel, digit: Int) {
        worker.appendInput(model: model, digit: digit)
        output.formViewModel()
    }

    public func getClearCmd(model: CalculatorModel) {
        worker.clearAll(model: model)
        output.formViewModel()
    }

    public func getResultCmd(model: CalculatorModel) {
        worker.calculateResult(model: model)
        output.formViewModel()
    }

}
