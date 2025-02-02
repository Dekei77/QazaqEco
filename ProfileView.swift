import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Profile Image
            Image("profilePic") // Убедитесь, что у вас есть изображение с таким именем
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            
            // User Name
            Text("Syrymbetov Amir")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.top, 8)
            
            Spacer()
            
            // Account Section
            VStack(alignment: .leading, spacing: 12) {
                Text("My Account")
                    .font(.headline)
                    .foregroundColor(.black)
                
                ProfileButton(title: "Manage Profile", iconName: "person.crop.circle")
                ProfileButton(title: "Payment methods", iconName: "creditcard")
            }
            .padding()
            
            // Others Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Others")
                    .font(.headline)
                    .foregroundColor(.black)
                
                ProfileButton(title: "Logout", iconName: "arrow.backward.circle")
            }
            .padding()
            
            Spacer()
            
            // Bottom Tab Bar
            CustomTabBar()
        }
        .padding()
    }
}

// Button Component
struct ProfileButton: View {
    var title: String
    var iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
            Text(title)
                .foregroundColor(.black)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

// Custom Bottom Tab Bar
struct CustomTabBar: View {
    var body: some View {
        HStack {
            TabBbButton(iconName: "house.fill", title: "Home")
            TabBbButton(iconName: "chart.bar", title: "Usage")
            TabBbButton(iconName: "doc.text", title: "Bill")
            TabBbButton(iconName: "bell.fill", title: "Notifications", hasBadge: true)
        }
        .padding()
        .background(Color.white)
    }
}

struct TabBbButton: View {
    var iconName: String
    var title: String
    var hasBadge: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: iconName)
                    .foregroundColor(.black)
                
                if hasBadge {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                        .offset(x: 10, y: -10)
                }
            }
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
