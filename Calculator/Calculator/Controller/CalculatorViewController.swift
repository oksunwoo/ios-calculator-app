//
//  Calculator - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit


class CalculatorViewController: UIViewController {
    
    // MARK: Properties
    var calculatorModel = Calculator() {
        didSet {
            removeAllFormulaHistory()
            updateCurrentInputLabel()
            addFormulaHistory()
        }
    }
    
    @IBOutlet weak var formulaHistoryScrollView: UIScrollView!
    @IBOutlet weak var formulaHistoryStackView: UIStackView!
    @IBOutlet weak var currentInputOperandLabel: UILabel!
    @IBOutlet weak var currentInputOperatorLabel: UILabel!
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeAllFormulaHistory()
        updateCurrentInputLabel()
    }
    
    // MARK: Private Method
    private func updateCurrentInputLabel() {
        currentInputOperandLabel.text = formatInputNumber(calculatorModel.currentInputOperand)
        currentInputOperatorLabel.text = calculatorModel.currentInputOperator
    }
    
    private func addFormulaHistory() {
        for each in calculatorModel.mathExpression {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            let operatorLabel = UILabel()
            operatorLabel.text = each.operatorSymbole
            operatorLabel.textColor = .white
            
            let operandLabel = UILabel()
            operandLabel.text = formatNumber(each.operandNumber)
            operandLabel.textColor = .white
            
            stackView.addArrangedSubview(operatorLabel)
            stackView.addArrangedSubview(operandLabel)
            formulaHistoryStackView.addArrangedSubview(stackView)
        }
    }
    
    private func removeAllFormulaHistory() {
        formulaHistoryStackView.arrangedSubviews.forEach { (view: UIView) -> () in
            view.removeFromSuperview()
        }
    }
    
    private func formatNumber(_ number: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 15
        numberFormatter.roundingMode = .halfUp
        
        guard let doubleNumber = Double(number) else {
            return number
        }
        
        guard let formattedNumber = numberFormatter.string(for: doubleNumber) else {
            return number
        }
        
        return formattedNumber
    }
    
    private func formatInputNumber(_ number: String) -> String {
        let formattedNumber = formatNumber(number)
        
        guard let numberDotindex = number.firstIndex(of: ".") else {
            return formattedNumber
        }
        
        guard let formattedNumberDotIndex = formattedNumber.firstIndex(of: ".") else {
            return formattedNumber + String(number[numberDotindex...])
        }
        
        return String(formattedNumber[..<formattedNumberDotIndex]) + String(number[numberDotindex...])
    }
    
    // MARK: Action
    @IBAction func touchUpAllClearButton(_ sender: UIButton) {
        calculatorModel.clearAllExpression()
    }
    
    @IBAction func touchUpClearEntryButton(_ sender: UIButton) {
        calculatorModel.clearEntry()
    }
    
    @IBAction func touchUpChangeSignButton(_ sender: UIButton) {
        calculatorModel.changeSignOfNumber()
    }
    
    @IBAction func touchUpEqualButton(_ sender: UIButton) {
        formulaHistoryScrollView.scrollToBottom()
        calculatorModel.calculateAllExpression()
    }
    
    @IBAction func touchUpDotButton(_ sender: UIButton) {
        calculatorModel.inputDot()
    }
    
    @IBAction func touchUpOperatorsButton(_ sender: UIButton) {
        guard let operatorSymbol = sender.titleLabel?.text else {
            return
        }
        
        formulaHistoryScrollView.scrollToBottom()
        calculatorModel.inputOperator(operatorSymbol)
    }
    
    @IBAction func touchUpOperandsButton(_ sender: UIButton) {
        guard let operandSymbol = sender.titleLabel?.text else {
            return
        }
        
        calculatorModel.inputNumber(operandSymbol)
    }
    
}

fileprivate extension UIScrollView {
    func scrollToBottom() {
        layoutIfNeeded()
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: false)
    }
}
