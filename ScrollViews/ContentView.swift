//
//  ContentView.swift
//  ScrollViews
//
//  Created by elsalvador on 28/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            // Parte izquierda de la pantalla
            VStack(alignment: .leading, spacing: 10) {
                Text("Contenido fuera del ScrollView")
                    .padding()
                    .multilineTextAlignment(.center)

                // ScrollView que cubre solo una parte de la pantalla
                MyScrollView()
                    .frame(width: 200)
                    .padding()

                // Spacer para centrar los elementos verticalmente
                Spacer()
            }

            // Parte derecha de la pantalla
            SecondView()
                .padding()
        }
    }
}

struct MyScrollView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1...20, id: \.self) { index in
                    Text("Elemento \(index)")
                        .padding()
                }
            }
        }
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
    }
}

struct SecondView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Segunda vista con una CircleImage")
                .font(.headline)
                .padding()
                .multilineTextAlignment(.center)

            CircleImage(imageURL: "https://docs-assets.developer.apple.com/published/2b2fe5cb06e9b4e3b9bb6496ed407797/010607.png")
                .frame(width: 100, height: 100)

            // Spacer para centrar los elementos verticalmente
            Spacer()
        }
    }
}

struct CircleImage: View {
    var imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
            case .failure:
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}


#Preview {
    ContentView()
}
