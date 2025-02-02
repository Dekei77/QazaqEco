import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack {
            // Верхняя часть экрана с фоновым изображением
            ZStack(alignment: .top) {
                Image("backgroundImage") // Замените на ваше изображение
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .clipped()

                VStack {
                    HStack {
                        // Фото профиля
                        Image("profilePic") // Замените на изображение профиля
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())

                        Spacer()

                        // Выпадающий список "Today"
                        Menu {
                            Button("Today", action: {})
                            Button("Yesterday", action: {})
                            Button("Last Month", action: {})
                        } label: {
                            HStack {
                                Text("Today")
                                    .font(.system(size: 16, weight: .medium))
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 50)

                    Spacer()
                }
            }

            // Белая область с заголовком "Messages"
            VStack(alignment: .leading, spacing: 16) {
                Text("Messages")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.leading, 16)
                    .padding(.top, 20)

                // Список сообщений
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(0..<6) { _ in
                            HStack(alignment: .top, spacing: 16) {
                                Circle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(width: 40, height: 40)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Please pay your water bill by [due date] to avoid interruptions.")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)

                                    Text("Contact us for assistance.")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)

                                    Text("2 hours before")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.top, -190)

            Spacer()

            // Нижняя панель навигации
            HStack {
                TabBarButton(image: "house.fill", title: "Home", isSelected: false)
                TabBarButton(image: "chart.bar.fill", title: "Usage", isSelected: false)
                TabBarButton(image: "creditcard.fill", title: "Bill", isSelected: false)
                TabBarButton(image: "bell.fill", title: "Notifications", isSelected: true)
            }
            .frame(height: 60)
            .background(Color.white)
            .shadow(radius: 5)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// Компонент кнопки таббара
struct TabbButton: View {
    var image: String
    var title: String
    var isSelected: Bool = false

    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(isSelected ? .black : .gray)

            Text(title)
                .font(.system(size: 12))
                .foregroundColor(isSelected ? .black : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
