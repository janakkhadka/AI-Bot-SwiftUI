//
//  TrialView.swift
//  JK Bot
//
//  Created by Janak Khadka on 18/02/2025.
//
import SwiftUI

struct TrialView: View {
    @State private var isSidebarVisible = true

    var body: some View {
        HStack(spacing: 0) {
            if isSidebarVisible {
                SidebarView()
                    .frame(width: 200)
                    .transition(.move(edge: .leading))
            }

            MainContentView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation {
                                isSidebarVisible.toggle()
                            }
                        } label: {
                            Label("Toggle Sidebar", systemImage: "sidebar.left")
                        }
                        .background(.blue)
                    }
                }
        }
    }
}

struct SidebarView: View {
    var body: some View {
        List {
            Text("Sidebar Item 1")
            Text("Sidebar Item 2")
            Text("Sidebar Item 3")
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Sidebar")
    }
}

struct MainContentView: View {
    var body: some View {
        Text("Main Content")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Main Content")
    }
}

#Preview {
    TrialView()
}
