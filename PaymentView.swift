import SwiftUI

struct PaymentView: View {
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
                        Image("profilePic") // Замените на ваше изображение профиля
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())

                        Spacer()

                        // Выпадающий список "Today"
                        Menu {
                            Button("Today", action: {})
                            Button("Last Week", action: {})
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
                }
            }

            // Белая карточка с суммой оплаты
            VStack {
                HStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                        .padding(.leading, 16)

                    Spacer()
                }
                .padding(.top, 20)

                HStack {
                    Text("Total")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black.opacity(0.7))

                    Spacer()

                    Text("2700.34")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)

                Spacer()
            }
            .frame(height: 150)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.horizontal, 16)
            .padding(.top, -40)

            // Кнопка оплаты
            Button(action: {
                print("Pay button tapped")
            }) {
                Text("Pay")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)

            Spacer()

            // Нижняя панель навигации
            HStack {
                TabBarButton(image: "house.fill", title: "Home", isSelected: false)
                TabBarButton(image: "chart.bar.fill", title: "Usage", isSelected: false)
                TabBarButton(image: "creditcard.fill", title: "Bill", isSelected: true)
                TabBarButton(image: "bell.fill", title: "Notifications", isSelected: false)
            }
            .frame(height: 70)
            .background(Color.white)
            .shadow(radius: 5)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// Компонент кнопки таббара
struct TabBarButton: View {
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

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
