//
//  CalculatorModel.swift
//  ScientificCalculator
//
//  Created by Alberto Benavides on 2/11/15.
//  Copyright (c) 2015 rocket-raccoon. All rights reserved.
//

import Foundation

class CalculatorModel {
    
    enum Op: Printable {
        
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String, (Double, Double)->Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let number):
                    return "\(number)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    var ops = [String: Op]()
    var opStack = [Op]()
    
    init() {
        ops["➗"] = Op.BinaryOperation("➗") { $1 / $0 }
        ops["✖️"] = Op.BinaryOperation("➗", *)
        ops["➕"] = Op.BinaryOperation("➕", +)
        ops["➖"] = Op.BinaryOperation("➖") { $1 - $0 }
        ops["√"] = Op.UnaryOperation("√", sqrt)
        ops["cos"] = Op.UnaryOperation("cos", cos)
        ops["sin"] = Op.UnaryOperation("sin", sin)
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
    }
    
    func pushOperation(operand: String) {
        if let op = ops[operand] {
            opStack.append(op)
        }
    }
    
    func evaluate(result: Double, var remainingOps: [Op]) -> (Double, [Op]){
        let op = remainingOps.removeLast()
        switch op {
        case .Operand(let number):
            return (number, remainingOps)
        case .UnaryOperation(_, let unaryOperation):
            var (number1, results1) = evaluate(0, remainingOps: remainingOps)
            return (unaryOperation(number1), results1)
        case .BinaryOperation(_, let binaryOperation):
            var (number1, results1) = evaluate(0, remainingOps: remainingOps)
            var (number2, results2) = evaluate(0, remainingOps: results1)
            return (binaryOperation(number1,number2), results2)
        default:
            return (-1, remainingOps)
        }
    }
    
    func calculate() -> Double {
        var (number, ops) = evaluate(0, remainingOps: opStack)
        opStack = [Op.Operand(number)]
        return number
    }
    
}

















