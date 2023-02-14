//
//  WorkerTests.swift
//  ios-calculatorTests
//
//  Created by Оля Галягина on 06.02.2023.
//

import XCTest
@testable import ios_calculator

class WorkerTests: XCTestCase {

    var sut: Worker!

    override func setUpWithError() throws {
      try super.setUpWithError()
      sut = Worker()
    }

    override func tearDownWithError() throws {
      sut = nil
      try super.tearDownWithError()
    }

    func testCorrectOutputWhenDoBinaryOperation() {
        let parameter1 = "14"
        let parameter2 = "-12"
        let operation: Character? = "+"
        let calculatorModel = CalculatorModel(userInput: parameter2, displayText: "", parameter1: parameter1, parameter2: nil, function: operation, result: nil, history: nil)

        sut.calculateResult(model: calculatorModel)

        let testResult = calculatorModel.displayText
        let actual = String(Int(Double(parameter1)! + Double(parameter2)!))

        XCTAssertEqual(testResult, actual)
    }

    func testErrorDividingByZero() {
        let parameter1 = "14"
        let parameter2 = "0"
        let operation: Character? = "÷"
        let calculatorModel = CalculatorModel(userInput: parameter2, displayText: "", parameter1: parameter1, parameter2: nil, function: operation, result: nil, history: nil)

        sut.calculateResult(model: calculatorModel)
        let testResult = calculatorModel.displayText
        let actual = "Error"

        XCTAssertEqual(testResult, actual)
    }

    func testCorrectOutputWhenDoBinaryOperationAndPressOperationInsteadOfResult() {
        let parameter1 = "14"
        let parameter2 = "-12"
        let operation: Character? = "+"
        let calculatorModel = CalculatorModel(userInput: parameter2, displayText: "", parameter1: parameter1, parameter2: nil, function: operation, result: nil, history: nil)

        sut.processBinaryOperation(model: calculatorModel, operation: .add)
        let testResult = calculatorModel.displayText
        let actual = String(Int(Double(parameter1)! + Double(parameter2)!))

        XCTAssertEqual(testResult, actual)
    }

    func testCorrectOutputWhenTwiceMakeDouble() {
        let parameter = "14.12"
        let operation: Character? = "."
        let calculatorModel = CalculatorModel(userInput: parameter, displayText: "14.12", parameter1: nil, parameter2: nil, function: operation, result: nil, history: nil)

        sut.processUnaryOperation(model: calculatorModel, operation: .makeDouble)
        let testResult = calculatorModel.displayText
        let actual = parameter

        XCTAssertEqual(testResult, actual)
    }

    func testLastOperationExecutedWhenSeveralChosen() {
        let parameter1 = "14"
        let parameter2 = "-12"
        let calculatorModel = CalculatorModel(userInput: parameter1, displayText: "", parameter1: nil, parameter2: nil, function: nil, result: nil, history: nil)

        sut.processBinaryOperation(model: calculatorModel, operation: .subtract)
        sut.processBinaryOperation(model: calculatorModel, operation: .add)

        calculatorModel.userInput = parameter2

        sut.processBinaryOperation(model: calculatorModel, operation: .add)

        let testResult = calculatorModel.displayText
        let actual = String(Int(Double(parameter1)! + Double(parameter2)!))

        XCTAssertEqual(testResult, actual)
    }

}
