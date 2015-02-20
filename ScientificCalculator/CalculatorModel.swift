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
        case Symbol(String)
        
        var description: String {
            get {
                switch self {
                case .Operand(let number):
                    return "\(number)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .Symbol(let symbol):
                    return symbol
                }
            }
        }
    }
    
    var ops = [String: Op]()
    var opStack = [Op]()
    var opHistory = [Op]()
    var variableValues = [String: Double]()
    
    func generateDescription(var equationString: String, var remainingOps: [Op]) -> (equation: String, remainingOps: [Op]) {
        if !remainingOps.isEmpty {
            let lastOp = remainingOps.removeLast()
            switch lastOp {
            case .Operand(let number):
                return (lastOp.description, remainingOps)
            case .UnaryOperation(let symbol, _):
                let (prevEquation, prevRemainingOps) = generateDescription("", remainingOps: remainingOps)
                if prevEquation.hasPrefix("(") && prevEquation.hasSuffix(")") {
                    equationString = "\(lastOp.description)\(prevEquation)"
                } else {
                    equationString = "\(lastOp.description)(\(prevEquation))"
                }
                return (equationString, prevRemainingOps)
            case .BinaryOperation(let symbol, _):
                let (prevEquation1, remainingOps1) = generateDescription("", remainingOps: remainingOps)
                let (prevEquation2, remainingOps2) = generateDescription("", remainingOps: remainingOps1)
                equationString = "(\(prevEquation2)\(symbol)\(prevEquation1))"
                return (equationString, remainingOps2)
            case .Symbol(let symbol):
                return (symbol, remainingOps)
            }
        }
        return ("?", remainingOps)
    }
    
    var description: String {
        get {
            var (equationString, remainingOps) = generateDescription("", remainingOps: opHistory)
            if equationString.hasPrefix("(") && equationString.hasSuffix(")") {
                let startIndex = advance(equationString.startIndex,1)
                let endIndex = advance(equationString.endIndex,-2)
                equationString = equationString.substringWithRange(startIndex...endIndex)
            }
            return equationString
        }
    }
    
    init() {
        //Initialize the known operations
        ops["➗"] = Op.BinaryOperation("➗") { $1 / $0 }
        ops["✖️"] = Op.BinaryOperation("✖️", *)
        ops["➕"] = Op.BinaryOperation("➕", +)
        ops["➖"] = Op.BinaryOperation("➖") { $1 - $0 }
        ops["√"] = Op.UnaryOperation("√", sqrt)
        ops["cos"] = Op.UnaryOperation("cos", cos)
        ops["sin"] = Op.UnaryOperation("sin", sin)
        //Initialize the known variables (symbols)
        variableValues["pi"] = M_PI
    }
    
    func pushOperand(symbol: String) {
        opStack.append(Op.Symbol(symbol))
        opHistory.append(Op.Symbol(symbol))
    }
    
    func pushOperand(operand: Double) {
        opStack.append(Op.Operand(operand))
        opHistory.append(Op.Operand(operand))
    }
    
    func pushOperation(operand: String) {
        if let op = ops[operand] {
            opStack.append(op)
            opHistory.append(op)
        }
    }
    
    func evaluate(result: Double, var remainingOps: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !remainingOps.isEmpty {
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let number):
                return (number, remainingOps)
            case .UnaryOperation(_, let unaryOperation):
                var evaluation = evaluate(0, remainingOps: remainingOps)
                if let result = evaluation.result {
                    return (unaryOperation(result), evaluation.remainingOps)
                }
            case .BinaryOperation(_, let binaryOperation):
                var evaluation1 = evaluate(0, remainingOps: remainingOps)
                if let result1 = evaluation1.result {
                    var evaluation2 = evaluate(0, remainingOps: evaluation1.remainingOps)
                    if let result2 = evaluation2.result {
                        return (binaryOperation(result1, result2), evaluation2.remainingOps)
                    }
                }
            case .Symbol(let symbolName):
                if let symbolValue = variableValues[symbolName] {
                    return (symbolValue, remainingOps)
                }
            }
        }
        return (nil, remainingOps)
    }
    
    func calculate() -> Double? {
        var evaluation = evaluate(0, remainingOps: opStack)
        if let result = evaluation.result {
            opStack = evaluation.remainingOps + [Op.Operand(result)]
            return result
        }
        return nil
    }
    
}

















