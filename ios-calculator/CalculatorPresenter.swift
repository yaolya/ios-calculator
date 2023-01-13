//
//  Presenter.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

public class CalculatorPresenter: CalculatorPresenterProtocol {
    public var viewController: CalculatorViewControllerProtocol?
    public var interactor: CalculatorInteractorInputProtocol?
    
    public func addDigit(_ digit: Character) {
        
    }
    public func addOperation(_ operation: Character) {
        
    }
    public func calculateResult() {
        
    }
    public func clearAll() {
        
    }
    
    public func formViewModel(_ model: CalculatorModel) {
        
    }
}

extension CalculatorPresenter: CalculatorInteractorOutputProtocol {
    public func getResultFromWorker() {
    }
}
