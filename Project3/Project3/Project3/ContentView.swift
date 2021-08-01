//
//  ContentView.swift
//  Project3
//
//  Created by Sathish Paul Leo on 7/28/21.
//

import SwiftUI

struct MyCustomView: View {
    var text1: String
    var text2: String
    
    var body: some View {
        VStack {
            Text(text1)
            Text(text2)
        }
    }
}

struct MyLargeBlueFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueText() -> some View {
        self.modifier(MyLargeBlueFontModifier())
    }
}

struct ContentView: View {
    @State private var myState = false
    var body: some View {
        Text("Hi there")
            .largeBlueText()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
