import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack {
            // Верхняя панель с логотипом и кнопкой закрытия
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

            Spacer().frame(height: 40)

            // Заголовок
            Text("Sign in to Flexify")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)

            Spacer().frame(height: 40)

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

            Spacer().frame(height: 24)

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
            }
            .padding(.horizontal, 24)

            // Ссылка "Forgot Password?"
            HStack {
                Spacer()
                Button(action: {
                    // Действие восстановления пароля
                }) {
                    Text("Forgot Password?")
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 24)

            Spacer().frame(height: 40)

            // Кнопка "Sign In"
            Button(action: {
                // Действие входа в систему
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
