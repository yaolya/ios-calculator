//
//  ViewController.swift
//  ios-calculator
//
//  Created by Оля Галягина on 24.12.2022.
//

import UIKit

class CustomBtn: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }
}

public class ViewController: UIViewController {

    public var presenter: Presenter?

    var buttonFontSize: CGFloat = 25

    @IBOutlet weak var holder: UIView!

    @IBOutlet weak var numbersHolder: UIView!

    @IBOutlet weak var displayLbl: UILabel!

    public override func viewDidLoad() {
        super.viewDidLoad()
        Configurator.sharedInstance.createCalculator(model: nil, viewController: self)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
    }

    private func setupButtons() {
        var buttonSize: CGFloat = 0.0
        if view.frame.size.width > view.frame.size.height - 300 {
            buttonSize = (view.frame.size.height - 220) / 5
        } else {
            buttonSize = (view.frame.size.width - 20) / 4
        }

        setupNumberButtons(buttonSize: buttonSize)
        setupTopOperationButtons(buttonSize: buttonSize)
        setupRightOperationButtons(buttonSize: buttonSize)
        setupBottomButtons(buttonSize: buttonSize)
    }

    private func setupNumberButtons(buttonSize: CGFloat) {
        for btnNumber in 0..<9 {
            let btn = CustomBtn(frame: CGRect(
                x: buttonSize * CGFloat(btnNumber % 3),
                y: buttonSize*CGFloat(floor(Double(btnNumber)/3.0) + 1),
                width: buttonSize,
                height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: buttonFontSize)
            btn.setTitle("\(btnNumber+1)", for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = btnNumber+1
            btn.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
    }

    private func setupRightOperationButtons(buttonSize: CGFloat) {
        let arr: [String] = ["÷", "×", "-", "+", "="]
        for btnNumber in 0...4 {
            let btn = CustomBtn(frame: CGRect(
                x: buttonSize * CGFloat(3),
                y: buttonSize*CGFloat(btnNumber),
                width: buttonSize,
                height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: buttonFontSize)
            btn.setTitle(arr[btnNumber], for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = 13 + btnNumber
            if btnNumber == 4 {
                btn.addTarget(self, action: #selector(result(_:)), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
        }
    }

    private func setupTopOperationButtons(buttonSize: CGFloat) {
        let arr: [String] = ["AC", "±", "%"]
        for btnNumber in 9..<12 {
            let btn = CustomBtn(frame: CGRect(
                x: buttonSize * CGFloat(btnNumber % 3),
                y: 0,
                width: buttonSize,
                height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: buttonFontSize)
            btn.setTitle(arr[btnNumber-9], for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = btnNumber+1
            if btnNumber == 9 {
                btn.addTarget(self, action: #selector(clearAll(_:)), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
        }
    }

    private func setupBottomButtons(buttonSize: CGFloat) {
        let zeroBtn = CustomBtn(frame: CGRect(x: 0, y: buttonSize*CGFloat(4), width: buttonSize*2, height: buttonSize))
        zeroBtn.setTitleColor(.black, for: .normal)
        zeroBtn.backgroundColor = .white
        zeroBtn.titleLabel?.font =  UIFont.systemFont(ofSize: buttonFontSize)
        zeroBtn.setTitle("0", for: .normal)
        numbersHolder.addSubview(zeroBtn)
        zeroBtn.tag = 0
        zeroBtn.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)

        let commaBtn = CustomBtn(frame: CGRect(
            x: buttonSize * CGFloat(2),
            y: buttonSize * CGFloat(4),
            width: buttonSize,
            height: buttonSize))
        commaBtn.setTitleColor(.black, for: .normal)
        commaBtn.backgroundColor = .white
        commaBtn.titleLabel?.font =  UIFont.systemFont(ofSize: buttonFontSize)
        commaBtn.setTitle(".", for: .normal)
        numbersHolder.addSubview(commaBtn)
        commaBtn.tag = 14
        commaBtn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
    }

    @objc func numberPressed(_ sender: UIButton) {
        presenter?.addDigit(digit: sender.tag)
    }

    @objc func operationPressed(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            presenter?.addOperation(operation: buttonTitle)
        }
    }

    @objc func clearAll(_ sender: UIButton) {
        presenter?.clearAll()
    }

    @objc func result(_ sender: UIButton) {
        presenter?.calculateResult()
    }
}

extension ViewController: ViewControllerProtocol {

    public func showResult(model: CalculatorModel) {
        displayLbl.text = model.displayText
    }

}
