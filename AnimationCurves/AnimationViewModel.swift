//
//  AnimationViewModel.swift
//  AnimationCurves
//
//  Created by Joshua Homann on 6/18/23.
//

import SwiftUI

struct AnimationViewModel: Identifiable, Hashable {
    let id: Int
    var name: String
    var color: Color
    var timing: Timing
    var animation: Animation {
        switch timing {
        case .curve(let unitCurve): .timingCurve(unitCurve, duration: 1)
        case .spring(let spring): .spring(spring)
        }
    }
    static func == (lhs: AnimationViewModel, rhs: AnimationViewModel) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    func evaluate(at time: TimeInterval) -> Double {
        switch timing {
        case .curve(let unitCurve): unitCurve.value(at: time)
        case .spring(let spring): spring.value(target: 1, time: time)
        }
    }
}

extension AnimationViewModel {
    enum Timing {
        case curve(UnitCurve), spring(Spring)
    }
}
