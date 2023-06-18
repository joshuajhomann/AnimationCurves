//
//  AnimationsView.swift
//  AnimationCurves
//
//  Created by Joshua Homann on 6/18/23.
//

import Observation
import SwiftUI

@MainActor
@Observable
final class AnimationsViewModel {
    typealias Timing = AnimationViewModel.Timing
    var move = false
    var speed = 1.0
    let speedRange = (0.20...5)
    let boxes: [AnimationViewModel]
    nonisolated init() {
        boxes = zip(
            zip(
                (0...),
                ["linear", "easeIn", "easeOut", "easeInOut", "bouncy", "smooth", "snappy"]
            ),
            zip(
                [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)].lazy.map(Color.init(uiColor:)),
                [Timing.curve(.linear), .curve(.easeIn), .curve(.easeOut), .curve(.easeInOut), .spring(.bouncy(duration: 1)), .spring(.smooth(duration: 1)), .spring(.snappy(duration: 1))]
            )
        )
        .lazy
        .map { ($0.0, $0.1, $1.0, $1.1) }
        .map(AnimationViewModel.init(id:name:color:timing:))
    }
}

struct AnimationsView: View {
    @Bindable var viewModel: AnimationsViewModel
    var body: some View {
        VStack {
            VStack {
                ForEach(viewModel.boxes) { box in
                    RoundedRectangle(
                        cornerSize: CGSize(width: 24, height: 24),
                        style: .continuous
                    )
                    .fill(box.color)
                    .strokeBorder(style: .init())
                    .frame(width: 80, height: 80)
                    .overlay(Text(box.name).foregroundColor(.white))
                    .frame(maxWidth: .infinity, alignment: viewModel.move ? .trailing : .leading)
                    .animation(box.animation.speed(viewModel.speed), value: viewModel.move)
                }
            }
            Button("Animate")  { viewModel.move.toggle() }
            Text("Speed: \(viewModel.speed, format: .number.precision(.significantDigits(0...2)))")
            Slider(value: $viewModel.speed, in: viewModel.speedRange, step: 0.1)
        }
        .padding()
    }
}

