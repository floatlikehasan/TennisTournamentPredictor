// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.

import SwiftUI

struct StatInputRow: View {
    let title: String
    @Binding var value: Int
    
    @State private var textValue: String = ""
    @State private var lastValidText: String = ""
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            TextField("0-100", text: $textValue)
                .frame(width: 60)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .onChange(of: textValue) {
                    let newText = textValue

                    // Allow empty during editing
                    if newText.isEmpty {
                        return
                    }

                    // Accept valid numbers
                    if let num = Int(newText), (0...100).contains(num) {
                        value = num
                        lastValidText = newText
                    } else {
                        // Revert to last valid text
                        textValue = lastValidText
                    }
                }
            
            Button("-") {
                if value > 0 {
                    value -= 1
                    textValue = String(value)
                    lastValidText = textValue
                }
            }
            .buttonStyle(.bordered)
            
            Button("+") {
                if value < 100 {
                    value += 1
                    textValue = String(value)
                    lastValidText = textValue
                }
            }
            .buttonStyle(.bordered)
        }
        .onAppear {
            textValue = String(value)
            lastValidText = textValue
        }
    }
}
