import SwiftUI

struct ContentView: View {
    @State private var activePic = false
    @State private var blurType: BlurType = .freeStyle
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            ScrollView(.vertical) {
                VStack(spacing: 15.0) {
                    TransparentBlurView(removeAllFilters: true)
                        .blur(radius: 15, opaque:  blurType == .clipped)
                        .padding([.horizontal, .top], -30)
                        .frame(height: 100 + safeArea.top)
                        .visualEffect { view, proxy in
                            view.offset(y: (proxy.bounds(of: .scrollView)?.minY ?? 0))
                        }
                        .zIndex(2)
                    VStack(alignment: .leading, spacing: 10.0) {
                        GeometryReader {
                            let size = $0.size
                            Image(activePic ? "Pic1" : "Pic2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(.rect(cornerRadius: 25, style: .continuous))
                                .onTapGesture {
                                    activePic.toggle()
                                }
                        }
                        .frame(height: 500)
                        
                        Text("Blur Type")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.top, 15)
                        Picker("", selection: $blurType) {
                            ForEach(BlurType.allCases) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(15)
                    .padding(.bottom, 500)
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

enum BlurType: String, CaseIterable, Identifiable {
    case clipped = "Clipped"
    case freeStyle = "Free Style"
    
    var id: BlurType { self }
}

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters = false
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                } else {
                    backdropLayer.filters?.removeAll(where: { String(describing: $0) != "gaussianBlur"})
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
