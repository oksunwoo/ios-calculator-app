//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CalculatorViewController: UIViewController {
    var calculator = Formula()
    
    @IBAction func touchUpAllClearButton(_ sender: UIButton) {
        clearAllElement()
    }
    
    @IBAction func touchUpClearEntryButton(_ sender: UIButton) {
    }
    
    @IBAction func touchUpChangeSignButton(_ sender: UIButton) {
    }
    
    @IBAction func touchUpEqualButton(_ sender: UIButton) {
    }
    
    @IBAction func touchUpDotButton(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func clearAllElement() {
        calculator.operands.removeAllItem()
        calculator.operators.removeAllItem()
    }
    

}

