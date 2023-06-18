//
//  AnimationInspector.swift
//  AnimationCurves
//
//  Created by Joshua Homann on 6/18/23.
//

import Charts
import SwiftUI

struct AnimationInspectorViewModel {
    var animations: [AnimationViewModel]
    var instants: some RandomAccessCollection<Double> = Array(stride(from: 0.0, through: 1.0, by: 0.1))
}

struct AnimationInspector: View {
    var viewModel: AnimationInspectorViewModel
    var body: some View {
        ScrollView {
            Chart(viewModel.instants, id: \.self) { instant in
                ForEach(viewModel.animations) { animation in
                    LineMark(
                        x: .value("Time", instant),
                        y: .value("Proportion", animation.evaluate(at: instant))
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(animation.color)
                    .foregroundStyle(by: .value("Animation", animation.name))
                }
            }
            .chartLegend {
                HStack {
                    ForEach(viewModel.animations) { animation in
                        Text(animation.name)
                            .font(.caption)
                            .foregroundColor(animation.color)
                    }
                }
            }
            .aspectRatio(1, contentMode: .fill)
        }
    }
}
