import SwiftUI

struct SignUpView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack {
            // Логотип и кнопка закрытия
            HStack {
                Image("miniLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                
                Text("QazaqEco")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    // Действие закрытия экрана
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .medium))
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 60)

            Spacer().frame(height: 40) // Увеличенный отступ

            // Заголовок
            Text("Create Account")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)

            Spacer().frame(height: 40) // Увеличенный отступ перед полями

            // Поле "Full Name"
            VStack(alignment: .leading, spacing: 12) {
                Text("Full Name")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)

                TextField("Enter full name", text: $fullName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
            }
            .padding(.horizontal, 24)

            Spacer().frame(height: 24) // Увеличенный отступ перед email

            // Поле "Email"
            VStack(alignment: .leading, spacing: 12) {
                Text("Email")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)

                TextField("Enter email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .keyboardType(.emailAddress)
            }
            .padding(.horizontal, 24)

            Spacer().frame(height: 24) // Отступ перед паролем

            // Поле "Password"
            VStack(alignment: .leading, spacing: 12) {
                Text("Password")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)

                HStack {
                    if isPasswordVisible {
                        TextField("Enter password", text: $password)
                    } else {
                        SecureField("Enter password", text: $password)
                    }

                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))

                Text("Password must contain at least 8 characters.")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 24)

            Spacer().frame(height: 40) // Отступ перед кнопкой

            // Кнопка "Sign Up"
            Button(action: {
                // Действие при нажатии
            }) {
                Text("Sign Up")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
                    .padding(.horizontal, 24)
            }

            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
