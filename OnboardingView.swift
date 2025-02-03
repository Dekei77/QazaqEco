import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("backgroundImage")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            // Content Overlay
            VStack {
                Spacer()
                
                // Logo & Title
                HStack {
                    Image("miniLogo") // Исправлено: Используем изображение, а не системную иконку
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text("QazaqEco")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Text("Smart Water Use for a Sustainable Future")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                    
                
                // Buttons
                HStack {
                    Button(action: {
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: SignUpView().environmentObject(ProfileData()))
                    }) {
                        Text("Join Us")
                            .font(.headline)
                            .frame(minWidth: 100, minHeight: 44)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(22)
                    }
                    
                    Button(action: {
                        UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: SignInView().environmentObject(ProfileData()))
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .frame(minWidth: 100, minHeight: 44)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
