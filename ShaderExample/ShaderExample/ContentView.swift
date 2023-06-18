import SwiftUI

struct ContentView: View {
    @State private var pixellate: CGFloat = 1
    @State private var speed: CGFloat = 1
    @State private var amplitude: CGFloat = 5
    @State private var frequency: CGFloat = 15
    @State private var enableLayerEffect: Bool = false
    let startDate: Date = .init()
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    PixellateView()
                        .navigationTitle("Pixellate")
                } label: {
                    Text("Pixellate")
                }
                
                NavigationLink {
                    WavesView()
                        .navigationTitle("Waves")
                } label: {
                    Text("Waves")
                }
                
                NavigationLink {
                    GrayScaleView()
                        .navigationTitle("Grayscale")
                } label: {
                    Text("Grayscale")
                }
            }
            .navigationTitle("Shaders Example")
        }
    }
    
    @ViewBuilder
    func GrayScaleView() -> some View {
        VStack {
            xcodeImage
                .layerEffect(
                    .init(
                        function: .init(library: .default, name: "grayscale"),
                        arguments: []),
                    maxSampleOffset: .zero,
                    isEnabled: enableLayerEffect
                )
            Toggle("Enable Grayscale Layer Effect", isOn: $enableLayerEffect)
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    func PixellateView() -> some View {
        VStack {
            xcodeImage
                .distortionEffect(
                    .init(
                        function: .init(library: .default, name: "pixellate"),
                        arguments: [.float(pixellate)]),
                    maxSampleOffset: .zero)
            Slider(value: $pixellate, in: 1...20)
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    func WavesView() -> some View {
        List {
            TimelineView(.animation) {
                let time = $0.date.timeIntervalSince1970 - startDate.timeIntervalSince1970
                xcodeImage
                    .distortionEffect(
                        .init(
                            function: .init(library: .default, name: "wave"),
                            arguments: [
                                .float(time),
                                .float(speed),
                                .float(frequency),
                                .float(amplitude)
                            ]),
                        maxSampleOffset: .zero)
            }
            
            
            Section("Speed") {
                Slider(value: $speed, in: 1...15)
            }
            Section("Frequency") {
                Slider(value: $frequency, in: 1...50)
            }
            Section("Amplitude") {
                Slider(value: $amplitude, in: 1...35)
            }
        }
    }
    
    var xcodeImage: some View {
        Image(.xcode)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 200)
            .frame(maxWidth: .infinity)
    }
}



#Preview {
    ContentView()
}
