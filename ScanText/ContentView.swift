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
    @State private var scannedText: String = ""
    @State private var target = ""
    
    var body: some View {
        VStack {
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
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true, isPinchToZoomEnabled: true,
            isHighlightingEnabled: false
    
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
        
        
        var itemHighlightViews: [RecognizedItem.ID: UIView] = [:]
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            for item in addedItems {
                switch item {
                case .text(let text):
                    
                    let overlayView = UILabel(frame: convertBoundsToCGRect(item.bounds))
                    overlayView.layer.borderColor = UIColor.green.cgColor
                    overlayView.layer.borderWidth = 2.0
                    overlayView.textColor = .white
                    overlayView.textAlignment = .justified
                    overlayView.text = text.transcript
                    itemHighlightViews[item.id] = overlayView
                    dataScanner.overlayContainerView.addSubview(overlayView)
                    
                default:
                    break
                }
    
              
            }
            
       
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
