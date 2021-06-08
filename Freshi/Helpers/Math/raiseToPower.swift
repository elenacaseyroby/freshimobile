//
//  raiseToPower.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import Foundation

func raiseToPower(value: Float, power: Int) -> Float {
    var raisedValue: Float = 1
    var counter: Int = 0
    while counter < power {
        counter += 1
        raisedValue *= value
    }
    if power > 0 {
        return raisedValue
    }
    return 1 / raisedValue
}
