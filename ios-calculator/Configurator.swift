//
//  Configurator.swift
//  ios-calculator
//
//  Created by Оля Галягина on 13.01.2023.
//

import Foundation
import UIKit

public class Configurator {

    static let sharedInstance = Configurator()

    private init() {}

    func createCalculator(model: CalculatorModel?, viewController: ViewController) {
        let presenter = Presenter(model: model)
        let interactor = Interactor()
        let worker = Worker()

        viewController.presenter = presenter

        presenter.output = viewController
        presenter.interactor = interactor

        interactor.output = presenter
        interactor.worker = worker
    }
}
