//
//  Interactor.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation

public class CalculatorInteractor: CalculatorInteractorInputProtocol {
    public var worker: CalculatorWorkerProtocol?
    public weak var presenter: CalculatorInteractorOutputProtocol?
    
    public func getOperation() {
        
    }
    
    public func getDigit() {
        
    }
    
    public func getClearCmd() {
        
    }
    
    public func getResultCmd() {
        
    }
    
}
