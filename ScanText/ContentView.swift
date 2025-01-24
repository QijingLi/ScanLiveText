//
//  ContentView.swift
//  ScanText
//
//  Created by Qijing li on 1/12/25.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    @State private var showScanner = false
    @State private var scannedText = ""
    
    var body: some View {
        VStack {
            Text(scannedText.isEmpty ? "No text scanned yet" : scannedText)
                .padding()
            
            Button("Start Scanning") {
                if DataScannerViewController.isSupported &&
                   DataScannerViewController.isAvailable {
                    showScanner = true
                }
            }
        }
        .sheet(isPresented: $showScanner) {
            ScannerView(scannedText: $scannedText)
        }
    }
}

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedText: String
@Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scanner = DataScannerViewController(
            recognizedDataTypes: [
                .text()
            ],
            qualityLevel: .balanced,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true, isPinchToZoomEnabled: true,
            isHighlightingEnabled: true
    
        )
        scanner.delegate = context.coordinator
        try? scanner.startScanning()
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: ScannerView
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        /*
         func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                parent.scannedText = text.transcript
                parent.scannedText += descBound(bound: text.bounds)
                parent.presentationMode.wrappedValue.dismiss()
                
            default:
                break
            }
        }
      
        // Dictionary to store our custom highlights keyed by their associated item ID.
        var itemHighlightViews: [RecognizedItem.ID: HighlightView] = [:]

        // For each new item, create a new highlight view and add it to the view hierarchy.
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addItems: [RecognizedItem], allItems: [RecognizedItem]) {
            for item in addedItems {
                let newView = newHighlightView(forItem: item)
                itemHighlightViews[item.id] = newView
                dataScanner.overlayContainerView.addSubview(newView)
            }
        }*/
        
        var itemHighlightViews: [RecognizedItem.ID: UIView] = [:]
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            for item in addedItems {
                let overlayView = UIView(frame: convertBoundsToCGRect(item.bounds))
                overlayView.layer.borderColor = UIColor.green.cgColor
                overlayView.layer.borderWidth = 2.0
                itemHighlightViews[item.id] = overlayView
                
                switch item {
                case .text(let text):
                    parent.scannedText = text.transcript

                    
                default:
                    break
                }
                overlayView.draw(item)

                dataScanner.overlayContainerView.addSubview(overlayView)
            }
            
            //parent.presentationMode.wrappedValue.dismiss()
        }
        
        // Remove highlights when their associated items are removed.
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            for item in removedItems {
                if let view = itemHighlightViews[item.id] {
                    itemHighlightViews.removeValue(forKey: item.id)
                    dataScanner.overlayContainerView.willRemoveSubview(view)
                    view.removeFromSuperview()
                }
               
            }
        }
        // write the function that transform RecognizedItem.Bounds to CGRect
        
        func convertBoundsToCGRect(_ bounds: RecognizedItem.Bounds) -> CGRect {
            return CGRect(
                x: bounds.topLeft.x,
                y: bounds.topLeft.y,
                width: bounds.topRight.x - bounds.topLeft.x,
                height: bounds.bottomLeft.y - bounds.topLeft.y
            )
        }
    }
    
}

