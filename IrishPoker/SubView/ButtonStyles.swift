//
//  NextButton.swift
//  IrishPoker
//
//  Created by Jeremy Manlangit on 11/19/23.
//

import SwiftUI

extension ButtonStyle where Self == ButtonIconRight {
    static var next: ButtonIconRight {
        ButtonIconRight(icon: "arrowshape.right.fill", color: .blue)
    }
}
extension ButtonStyle where Self == ButtonIconLeft {
    static var correct: ButtonIconLeft {
        ButtonIconLeft(icon: "checkmark", color: .green)
    }
    static var wrong: ButtonIconLeft {
        ButtonIconLeft(icon: "xmark", color: .red)
    }
    static var start: ButtonIconLeft {
        ButtonIconLeft(icon: "flag.2.crossed.fill", color: .black)
    }
}


struct ButtonIconRight: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var icon: String
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            if isEnabled {
                HStack {
                    Spacer()
                        .frame(width: 25)
                    configuration.label
                    Image(systemName: icon)
                        .fontWeight(.thin)
                        .foregroundStyle(color)
                }
            } else {
                ProgressView()
            }
        }
        .font(.system(size: 50))
        .fontWeight(.heavy)
        .padding()
        .frame(height: 95)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .animation(.default, value: isEnabled)
        .padding()
    }
}

struct ButtonIconLeft: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var icon: String
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            if isEnabled {
                HStack {
                    Image(systemName: icon)
                        .fontWeight(.heavy)
                        .foregroundStyle(color, icon == "flag.2.crossed.fill" ? .red : color)
                    configuration.label
                    Spacer()
                        .frame(width: 30)
                }
            } else {
                Spacer()
            }
        }
        .font(.system(size: 50))
        .fontWeight(.heavy)
        .padding()
        .frame(height: 95)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: isEnabled ? 10 : 0)
        .animation(.default, value: isEnabled)
        .padding()
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            if isEnabled {
                configuration.label
            } else {
                ProgressView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(10)
        .animation(.default, value: isEnabled)
    }
}

#if DEBUG
struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPreview(disabled: false)
        ButtonPreview(disabled: true)
    }
    
    private struct ButtonPreview: View {
        let disabled: Bool
        
        var body: some View {
            VStack {
                Button("Next", action: {})
                    .buttonStyle(.next)
                Button("Correct", action: {})
                    .buttonStyle(.correct)
                Button("Wrong", action: {})
                    .buttonStyle(.wrong)
                Button("Start", action: {})
                    .buttonStyle(.start)
            }
        }
    }
}
#endif
