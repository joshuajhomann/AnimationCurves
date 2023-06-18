//
//  ContentView.swift
//  AnimationCurves
//
//  Created by Joshua Homann on 6/16/23.
//
import Charts
import Observation
import SwiftUI

struct ContentView: View {
    private var viewModel = AnimationsViewModel()
    @State private var showInspector = false
    var body: some View {
        NavigationStack {
            AnimationsView(viewModel: viewModel)
                .navigationTitle("Animation")
                .navigationBarTitleDisplayMode(.inline)
                .inspector(isPresented: $showInspector) {
                    AnimationInspector(viewModel: .init(animations: viewModel.boxes))
                        .presentationDetents([.fraction(0.5), .fraction(0.75)])
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button { showInspector.toggle() } label: {
                            Image(systemName: "lightspectrum.horizontal")
                                .renderingMode(.original)
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}

