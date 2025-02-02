import SwiftUI

struct UsageView: View {
    var body: some View {
        VStack {
            // Верхняя часть экрана с фоновым изображением
            ZStack(alignment: .top) {
                Image("backgroundImage") // Замените на ваше изображение
                    .resizable()
                    .scaledToFill()
                    .frame(height: 330)
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

                    Spacer()

                    // Круглый индикатор потребления
                    VStack {
                        Text("Consumption")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black.opacity(0.7))

                        Text("75lit")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 170, height: 170)
                    .background(Circle().fill(Color.white))
                    .shadow(radius: 5)
                    .padding(.top, -250)
                }
            }

            // Белая область с текстом "Week Usage"
            VStack(alignment: .leading) {
                Text("Week usage")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.top, -60)

            Spacer()

            // Нижняя панель навигации
            HStack {
                TabBarItem(image: "house.fill", title: "Home", isSelected: false)
                TabBarItem(image: "chart.bar.fill", title: "Usage", isSelected: true)
                TabBarItem(image: "creditcard.fill", title: "Bill", isSelected: false)
                TabBarItem(image: "bell.fill", title: "Notifications", isSelected: false)
            }
            .frame(height: 70)
            .background(Color.white)
            .shadow(radius: 5)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// Компонент кнопки таббара
struct TabBarItem: View {
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

struct UsageView_Previews: PreviewProvider {
    static var previews: some View {
        UsageView()
    }
}
