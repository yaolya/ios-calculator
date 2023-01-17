//
//  ViewController.swift
//  ios-calculator
//
//  Created by Оля Галягина on 24.12.2022.
//

import UIKit

class customBtn: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }
}

public class ViewController: UIViewController {
    
    public var presenter: Presenter?
    
    var ButtonFontSize: CGFloat = 25
    
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
        if (view.frame.size.width > view.frame.size.height - 300) {
            buttonSize = (view.frame.size.height - 220) / 5
        } else {
            buttonSize = (view.frame.size.width - 20) / 4
        }
        
        
        for i in 0..<9 {
            let btn = customBtn(frame: CGRect(x: buttonSize * CGFloat(i % 3), y: buttonSize*CGFloat(floor(Double(i)/3.0) + 1), width: buttonSize, height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: ButtonFontSize)
            btn.setTitle("\(i+1)", for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = i+1
            btn.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        let arr: Array<String> = ["AC", "±", "%", "÷", "×", "-", "+", "="]
        for i in 9..<12 {
            let btn = customBtn(frame: CGRect(x: buttonSize * CGFloat(i % 3), y: 0, width: buttonSize, height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: ButtonFontSize)
            btn.setTitle(arr[i-9], for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = i+1
            if i == 9 {
                btn.addTarget(self, action: #selector(clearAll(_:)), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
        }
        
        for j in 0...4 {
            let btn = customBtn(frame: CGRect(x: buttonSize * CGFloat(3), y: buttonSize*CGFloat(j), width: buttonSize, height: buttonSize))
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .white
            btn.titleLabel?.font =  UIFont.systemFont(ofSize: ButtonFontSize)
            btn.setTitle(arr[3+j], for: .normal)
            numbersHolder.addSubview(btn)
            btn.tag = 13 + j
            if j == 4 {
                btn.addTarget(self, action: #selector(result(_:)), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            }
        }
        
        let zeroBtn = customBtn(frame: CGRect(x: 0, y: buttonSize*CGFloat(4), width: buttonSize*2, height: buttonSize))
        zeroBtn.setTitleColor(.black, for: .normal)
        zeroBtn.backgroundColor = .white
        zeroBtn.titleLabel?.font =  UIFont.systemFont(ofSize: ButtonFontSize)
        zeroBtn.setTitle("0", for: .normal)
        numbersHolder.addSubview(zeroBtn)
        zeroBtn.tag = 0
        zeroBtn.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        
        let commaBtn = customBtn(frame: CGRect(x: buttonSize * CGFloat(2), y: buttonSize*CGFloat(4), width: buttonSize, height: buttonSize))
        commaBtn.setTitleColor(.black, for: .normal)
        commaBtn.backgroundColor = .white
        commaBtn.titleLabel?.font =  UIFont.systemFont(ofSize: ButtonFontSize)
        commaBtn.setTitle(",", for: .normal)
        numbersHolder.addSubview(commaBtn)
        commaBtn.tag = 14
        commaBtn.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
    }
    
    
    @objc func numberPressed(_ sender: UIButton) {
        presenter?.addDigit(digit: sender.tag)
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            presenter?.addOperation(operation: Character(buttonTitle))
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












