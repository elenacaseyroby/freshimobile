//
//  percentAsDecimal.swift
//  Freshi
//
//  Created by Casey Roby on 6/8/21.
//

import Foundation
import SwiftUI

func percentAsDecimal(value: Float, total: Float) -> CGFloat {
    let percent: Float = value / total
    let roundedPercent = roundToDecPlace(value: percent, place: 2)
    return CGFloat(roundedPercent)
}
