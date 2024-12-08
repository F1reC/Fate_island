//
//  ContentView.swift
//  Fate_island
//
//  Created by F1reC on 2024/12/8.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.05, blue: 0.2), // 深紫色
                    Color(red: 0.05, green: 0.05, blue: 0.15)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Main content with TabView
            TabView(selection: $selectedTab) {
                DiscoverView()
                    .tabItem {
                        Label("Discover", systemImage: selectedTab == 0 ? "map.fill" : "map")
                    }
                    .tag(0)
                
                MessageView()
                    .tabItem {
                        Label("Message", systemImage: selectedTab == 1 ? "message.fill" : "message")
                    }
                    .tag(1)
                
                ProfileView()
                    .tabItem {
                        Label("Me", systemImage: selectedTab == 2 ? "person.fill" : "person")
                    }
                    .tag(2)
            }
            .tint(.white)
        }
    }
}

// MARK: - Discover View
struct DiscoverView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var locations: [LocationPin] = [
        LocationPin(type: .restaurant, coordinate: CLLocationCoordinate2D(latitude: 37.7800, longitude: -122.4150), peopleCount: 11),
        LocationPin(type: .party, coordinate: CLLocationCoordinate2D(latitude: 37.7700, longitude: -122.4180), peopleCount: 17),
        LocationPin(type: .nightclub, coordinate: CLLocationCoordinate2D(latitude: 37.7650, longitude: -122.4200), peopleCount: 9)
    ]
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    LocationAnnotationView(type: location.type, count: location.peopleCount)
                }
            }
            .colorScheme(.dark)
            
            // Top overlay with blur effect
            VStack {
                HStack {
                    Spacer()
                    VibesCountView(count: 235)
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .blur(radius: 10)
                        .edgesIgnoringSafeArea(.top)
                )
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Message View
struct MessageView: View {
    let messages: [ChatMessage] = [
        ChatMessage(name: "Jonah Blake", message: "Do you enjoy a bit of adventure?", date: "December 8", isNew: true),
        ChatMessage(name: "Maya Robinson", message: "It's a secret until we connect more!", date: "December 8", isNew: true),
        ChatMessage(name: "Nina Kovalev", message: "Hey! How's your day going? 😊", date: "December 8", isNew: true),
        ChatMessage(name: "Nina Evans", message: "Hi there! How's your day going? 😊", date: "December 3", isNew: true),
        ChatMessage(name: "Mateo Soto", message: "Absolutely! It'll be a night to remember!", date: "December 8", isNew: false),
        ChatMessage(name: "Arjun Verma", message: "What have you been up to?", date: "December 6", isNew: false),
        ChatMessage(name: "Elena Smith", message: "Are you doing alright today? 😊", date: "December 4", isNew: false),
        ChatMessage(name: "Liam Adams", message: "Just curious, what's on your mind? 🤔", date: "December 4", isNew: false)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.6))
                        Text("Search messages")
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.1))
                    )
                    .padding(.horizontal)
                    
                    // Messages list
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            MessageRow(message: message)
                        }
                    }
                }
                .padding(.top)
            }
            .background(Color(red: 0.1, green: 0.05, blue: 0.2))
            .navigationTitle("Message")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.4, green: 0.2, blue: 0.8),
                                        Color(red: 0.6, green: 0.3, blue: 0.9)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 36, height: 36)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
        }
    }
}

// MARK: - Profile View
struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 20) {
                        // Avatar
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.4, green: 0.2, blue: 0.8),
                                            Color(red: 0.6, green: 0.3, blue: 0.9)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "person")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                        .shadow(color: Color(red: 0.4, green: 0.2, blue: 0.8).opacity(0.5), radius: 15, x: 0, y: 8)
                        
                        Text("Guest")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white.opacity(0.1))
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.white.opacity(0.2),
                                                Color.white.opacity(0.1)
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                    )
                    .padding(.horizontal)
                    
                    // Settings Section
                    VStack(spacing: 16) {
                        SettingsCardView(icon: "slider.horizontal.3", title: "Preferences")
                        
                        // Balance Card
                        HStack {
                            Image(systemName: "creditcard")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 30)
                            
                            Text("Balance")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("235 vibes")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.8, green: 0.3, blue: 0.9))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.white.opacity(0.1))
                                )
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.1))
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.white.opacity(0.2),
                                                    Color.white.opacity(0.1)
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1
                                        )
                                )
                        )
                        
                        SettingsCardView(icon: "gearshape", title: "Setting")
                        SettingsCardView(icon: "info.circle", title: "About Fate")
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .background(Color(red: 0.1, green: 0.05, blue: 0.2))
            .navigationTitle("Me")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Supporting Views
struct LocationAnnotationView: View {
    let type: LocationType
    let count: Int
    @State private var isHovered = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Location banner
            HStack {
                Text(type.icon)
                    .font(.system(size: 14))
                Text(type.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            
            // People count circle
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 30, height: 30)
                Text("\(count)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
            .offset(y: -15)
        }
        .scaleEffect(isHovered ? 1.1 : 1.0)
        .onHover { hovering in
            withAnimation(.spring()) {
                isHovered = hovering
            }
        }
    }
}

struct VibesCountView: View {
    let count: Int
    
    var body: some View {
        HStack {
            Image(systemName: "sparkles")
                .foregroundColor(.white)
            Text("\(count)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

struct MessageRow: View {
    let message: ChatMessage
    @State private var isPressed = false
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar with new message indicator
            ZStack(alignment: .topTrailing) {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.4, green: 0.2, blue: 0.8),
                                Color(red: 0.6, green: 0.3, blue: 0.9)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "person")
                            .foregroundColor(.white)
                    )
                
                if message.isNew {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.8, green: 0.3, blue: 0.9))
                            .frame(width: 20, height: 20)
                        Image(systemName: "sparkles")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                    .offset(x: 5, y: -5)
                }
            }
            
            // Message content
            VStack(alignment: .leading, spacing: 4) {
                Text(message.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                Text(message.message)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Text(message.date)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.1)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .padding(.horizontal)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onTapGesture {
            withAnimation(.spring()) {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring()) {
                        isPressed = false
                    }
                }
            }
        }
    }
}

struct SettingsCardView: View {
    let icon: String
    let title: String
    @State private var isPressed = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.1)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onTapGesture {
            withAnimation(.spring()) {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring()) {
                        isPressed = false
                    }
                }
            }
        }
    }
}

// MARK: - Models
struct LocationPin: Identifiable {
    let id = UUID()
    let type: LocationType
    let coordinate: CLLocationCoordinate2D
    let peopleCount: Int
}

enum LocationType {
    case restaurant
    case party
    case nightclub
    
    var icon: String {
        switch self {
        case .restaurant: return "🍽️"
        case .party: return "🎉"
        case .nightclub: return "🎵"
        }
    }
    
    var title: String {
        switch self {
        case .restaurant: return "Restaurant"
        case .party: return "Party"
        case .nightclub: return "Night Club"
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let date: String
    let isNew: Bool
}

#Preview {
    ContentView()
}
