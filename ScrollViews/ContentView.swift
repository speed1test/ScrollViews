//
//  ContentView.swift
//  ScrollViews
//
//  Created by elsalvador on 28/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isScrollViewVisible = true

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Parte izquierda de la pantalla
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Contenido fuera del ScrollView")
                            .padding()

                        // ScrollView que cubre solo una parte de la pantalla
                        if isScrollViewVisible {
                            MyScrollView()
                                .frame(width: 200, height: 400) // Ajusta la altura según tus necesidades
                                .padding()
                        }

                        // Spacer para centrar los elementos verticalmente
                        Spacer()
                    }

                    // Parte derecha de la pantalla
                    SecondView()
                        .padding()
                }
            }
            .navigationTitle("Scroll Views Demo")
            .toolbar {
                // Botón en la barra de herramientas
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        isScrollViewVisible.toggle()
                    }) {
                        Text(isScrollViewVisible ? "Ocultar ScrollView" : "Mostrar ScrollView")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct MyScrollView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1...50, id: \.self) { index in
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

