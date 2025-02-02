import SwiftUI

struct ProfileEditView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Действие для возврата назад
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Profile Update")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                
            }
            .padding()
            
            // Аватар
            Image("profilePic")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .shadow(radius: 5)
                .padding(.bottom, 20)
            
            // Поля ввода
            InputField(title: "First Name", text: $firstName)
            InputField(title: "Last Name", text: $lastName)
            InputField(title: "Email", text: $email)
            InputField(title: "Phone Number", text: $phoneNumber)
            
            Spacer()
            
            // Кнопка выхода
            Button(action: {
                // Действие для выхода
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

struct InputField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            HStack {
                TextField("Enter \(title.lowercased())", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
            }
        }
        .padding(.vertical, 5)
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
