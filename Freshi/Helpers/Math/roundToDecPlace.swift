//
//  roundToDecPlace.swift
//  Freshi
//
//  Created by Casey Roby on 6/7/21.
//

import Foundation

func roundToDecPlace(value: Float, place: Int) -> Float {
    // Ex. input
    // value: 10.23425
    // place: 3
    // return: 10.234
    
    // round() accepts Double or Float and returns nearest whole number as a Double:
    // ex. 10.35 would return 10.0
    let placesInTensDouble = (
        raiseToPower(value: 10, power: place - 1) * 10.0
    )
    return round(value * placesInTensDouble) / placesInTensDouble
}
