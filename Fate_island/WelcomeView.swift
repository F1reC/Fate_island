import SwiftUI

struct Star: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var opacity: Double
    var animationDelay: Double
}

struct StarFieldView: View {
    @State private var stars: [Star] = []
    private let starCount = 100
    @State private var phase: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(stars) { star in
                    Circle()
                        .fill(Color.white)
                        .frame(width: star.size, height: star.size)
                        .position(star.position)
                        .opacity(star.opacity)
                        .animation(
                            Animation.easeInOut(duration: 2.0)
                                .repeatForever()
                                .delay(star.animationDelay),
                            value: phase
                        )
                }
            }
            .onAppear {
                stars = (0..<starCount).map { _ in
                    Star(
                        position: CGPoint(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        ),
                        size: CGFloat.random(in: 1...3),
                        opacity: Double.random(in: 0.2...0.7),
                        animationDelay: Double.random(in: 0...2)
                    )
                }
                
                withAnimation(Animation.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                    phase = 1
                }
            }
        }
    }
}

struct AnimatedText: View {
    let text: String
    let size: CGFloat
    let weight: Font.Weight
    let design: Font.Design
    let delay: Double
    @State private var opacity: Double = 0
    @State private var offset: CGFloat = 20
    
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: weight, design: design))
            .foregroundColor(.white)
            .opacity(opacity)
            .offset(y: offset)
            .onAppear {
                withAnimation(
                    Animation.easeOut(duration: 1.0)
                        .delay(delay)
                ) {
                    opacity = 1
                    offset = 0
                }
            }
    }
}

struct WelcomeView: View {
    @State private var currentPage = 0
    @State private var showContentView = false
    
    var body: some View {
        ZStack {
            if showContentView {
                ContentView()
            } else {
                // Background gradient with stars
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.05, green: 0.05, blue: 0.1),
                            Color(red: 0.1, green: 0.1, blue: 0.2)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    StarFieldView()
                        .opacity(0.6)
                }
                .edgesIgnoringSafeArea(.all)
                
                // Page content
                TabView(selection: $currentPage) {
                    FirstPageView()
                        .tag(0)
                    
                    SecondPageView()
                        .tag(1)
                    
                    ThirdPageView()
                        .tag(2)
                    
                    FourthPageView()
                        .tag(3)
                    
                    FifthPageView(showContentView: $showContentView)
                        .tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
    }
}

struct FirstPageView: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            AnimatedText(
                text: "FATE ISLAND",
                size: 40,
                weight: .bold,
                design: .serif,
                delay: 0.3
            )
            
            AnimatedText(
                text: "The Paradise of Free Will",
                size: 20,
                weight: .medium,
                design: .serif,
                delay: 0.6
            )
            
            AnimatedText(
                text: "On these islands where technology and magic intertwine, every soul possesses its own unique consciousness. This is not a virtual playground, but a real parallel world.",
                size: 16,
                weight: .regular,
                design: .serif,
                delay: 0.9
            )
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct SecondPageView: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            AnimatedText(
                text: "As a visitor, you are about to embark on an unprecedented journey:",
                size: 20,
                weight: .medium,
                design: .default,
                delay: 0.3
            )
            .padding(.horizontal, 40)
            .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 25) {
                ForEach(0..<4) { index in
                    BulletPointView(
                        text: [
                            "Here, each islander is an independent entity with their own memories, emotions, and values",
                            "They think, question, laugh, and anger, just like any living being",
                            "You can converse with them, build friendships, or become rivals",
                            "Every interaction will shape the destiny of the island"
                        ][index],
                        delay: 0.6 + Double(index) * 0.2
                    )
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct ThirdPageView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                AnimatedText(
                    text: "Core Principles",
                    size: 30,
                    weight: .bold,
                    design: .default,
                    delay: 0.3
                )
                .padding(.top, 40)
                
                VStack(spacing: 25) {
                    FeatureView(
                        title: "Free Will",
                        description: "The islanders are not puppets of preset programs, but independent beings with real thoughts. They make choices based on their experiences and values, sometimes even questioning and challenging visitors.",
                        delay: 0.6
                    )
                    
                    FeatureView(
                        title: "Butterfly Effect",
                        description: "Every choice creates ripples across the island. A single act of kindness might change an islander's life forever, and a casual word might trigger a chain reaction.",
                        delay: 0.8
                    )
                    
                    FeatureView(
                        title: "Eternal Memory",
                        description: "Islanders remember every interaction with you, these memories shape their personality and future choices. There is no reset button - each story is unique.",
                        delay: 1.0
                    )
                    
                    FeatureView(
                        title: "Island Ecosystem",
                        description: "Different islands carry different civilizations and cultures, influencing each other while maintaining independence. The relationships between islands evolve over time.",
                        delay: 1.2
                    )
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

struct FourthPageView: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            AnimatedText(
                text: "⚠ VISITOR NOTICE ⚠",
                size: 30,
                weight: .bold,
                design: .default,
                delay: 0.3
            )
            .foregroundColor(.yellow)
            
            VStack(spacing: 25) {
                ForEach(0..<3) { index in
                    AnimatedText(
                        text: [
                            "This is not a game, but a real cross-dimensional journey.",
                            "Every action you take will have real impact on this world.",
                            "Please interact with the islanders as you would with real living beings."
                        ][index],
                        size: 18,
                        weight: .regular,
                        design: .default,
                        delay: 0.6 + Double(index) * 0.2
                    )
                    .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
    }
}

struct FifthPageView: View {
    @Binding var showContentView: Bool
    @State private var buttonOpacity: Double = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            AnimatedText(
                text: "Welcome to Fate Island",
                size: 30,
                weight: .bold,
                design: .serif,
                delay: 0.3
            )
            
            AnimatedText(
                text: "\"On Fate Island, every soul writes their own story.\nAnd you will become either a witness or a change-maker.\"",
                size: 20,
                weight: .medium,
                design: .serif,
                delay: 0.6
            )
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
            
            AnimatedText(
                text: "- Welcome to the Real Parallel World -",
                size: 18,
                weight: .medium,
                design: .serif,
                delay: 0.9
            )
            
            Spacer()
            
            // Enter button
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showContentView = true
                }
            }) {
                Text("Enter Fate Island")
                    .font(.system(size: 20, weight: .semibold, design: .serif))
                    .foregroundColor(.black)
                    .frame(width: 220, height: 50)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.white, Color(white: 0.9)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
                    .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .opacity(buttonOpacity)
            .onAppear {
                withAnimation(
                    Animation.easeOut(duration: 0.8)
                        .delay(1.2)
                ) {
                    buttonOpacity = 1.0
                }
            }
            
            Spacer()
                .frame(height: 60)
        }
    }
}

struct BulletPointView: View {
    let text: String
    let delay: Double
    @State private var opacity: Double = 0
    
    var body: some View {
        HStack(alignment: .top) {
            Text("•")
                .foregroundColor(.white)
            Text(text)
                .foregroundColor(.white.opacity(0.9))
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(
                Animation.easeOut(duration: 0.8)
                    .delay(delay)
            ) {
                opacity = 1.0
            }
        }
    }
}

struct FeatureView: View {
    let title: String
    let description: String
    let delay: Double
    @State private var opacity: Double = 0
    @State private var offset: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("▶ \(title)")
                .font(.headline)
                .foregroundColor(.white)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .opacity(opacity)
        .offset(y: offset)
        .onAppear {
            withAnimation(
                Animation.easeOut(duration: 0.8)
                    .delay(delay)
            ) {
                opacity = 1
                offset = 0
            }
        }
    }
}

#Preview {
    WelcomeView()
} 