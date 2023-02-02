import SwiftUI

struct PopOversView: View {
    @State private var showPopover = false
    @State private var updateText = false
    var body: some View {
        VStack {
            Button("Show Popover") {
                showPopover.toggle()
            }
            .iOSPopover(isPresented: $showPopover, arrowDirection: .down) {
                let text = updateText ? "Updated Popover" : "Popover"
                VStack {
                    Text("Hello, it's me, \(text)!")
                    Button("Update Text") {
                        updateText.toggle()
                    }
                    Button("Close Popover") {
                        showPopover.toggle()
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 20).fill(.blue.gradient)
                    .padding(-20))
            }
        }
    }
}

struct PopOversView_Previews: PreviewProvider {
    static var previews: some View {
        PopOversView()
    }
}

extension View {
    @ViewBuilder
    func iOSPopover<Content: View>(isPresented: Binding<Bool>,
                                   arrowDirection: UIPopoverArrowDirection,
                                   @ViewBuilder content: @escaping ()->Content) -> some View {
        self
            .background {
                PopOverController(isPresented: isPresented,
                                  arrowDirection: arrowDirection,
                                  content: content())
            }
    }
}

struct PopOverController<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    @State private var alreadyPresented = false
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if alreadyPresented {
            if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content> {
                hostingController.rootView = content
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
            }
            if !isPresented {
                uiViewController.dismiss(animated: true) {
                    alreadyPresented = false
                }
            }
        } else {
            if isPresented {
                let controller = CustomHostingView(rootView: content)
                controller.view.backgroundColor = .clear
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                controller.presentationController?.delegate = context.coordinator
                controller.popoverPresentationController?.sourceView = uiViewController.view
                uiViewController.present(controller, animated: true)
            }
        }
    }
    
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: PopOverController
        init(parent: PopOverController) {
            self.parent = parent
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
        
        func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
            DispatchQueue.main.async {
                self.parent.alreadyPresented = true
            }
        }
    }
}

class CustomHostingView<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}
