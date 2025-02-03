import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView() {
            VStack {
                // Верхняя часть экрана с фоновым изображением
                ZStack(alignment: .top) {
                    Image("backgroundImage") // Название вашего изображения
                        .resizable()
                        .scaledToFill()
                        .frame(height: 500)
                    VStack {
                        HStack {
                            // Фото профиля
                            NavigationLink(destination: ProfileView().environmentObject(ProfileData())) {
                                Image("profilePic") // Аватар пользователя
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                        
                            
                            // Кнопка "Today" с выпадающим списком
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
                        .padding(.top, 10)
                        .padding(.horizontal, -200)
                        
                        // Круглый индикатор потребления воды
                        VStack {
                            Text("Consumption")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black.opacity(0.7))
                            
                            Text("75lit")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .frame(width: 170, height: 170)
                        .background(Circle().fill(Color.white.opacity(0.8)))
                        .shadow(radius: 5)
                        .padding(.top, 20)
                    }
                }
            

                // Белая карточка с информацией
                VStack {
                    HStack(spacing: 16) {
                        // Блок с неоплаченным счетом
                        VStack {
                            Image(systemName: "doc.text")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                            
                            Text("Outstanding bill")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black.opacity(0.7))
                            
                            Text("2700tg/")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Check now")
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                        .shadow(radius: 2)
                        
                        // Блок с непрочитанными сообщениями
                        VStack {
                            Image(systemName: "bell")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                            
                            Text("Unread messages")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black.opacity(0.7))
                            
                            Text("5 mes/")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Check now")
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    .frame(height: 250)
                    .background(Color.white)
                    .cornerRadius(30)
                }

                Spacer()
                
                // Нижняя панель навигации
                HStack {
                    
                    TabButton(image: "house.fill", title: "Home", isSelected: true)
                    NavigationLink(destination: UsageView()) {
                        TabButton(image: "chart.bar.fill", title: "Usage")
                    }
                    NavigationLink(destination: PaymentView()){
                        TabButton(image: "creditcard.fill", title: "Bill")
                    }
                    NavigationLink(destination: MessagesView()) {
                        TabButton(image: "bell.fill", title: "Notifications", hasBadge: true)
                    }
                }
                .frame(height: 70)
                .background(Color.white)
                .shadow(radius: 2)
            }
        }
    }
        }
        

// Компонент кнопки таббара
struct TabButton: View {
    var image: String
    var title: String
    var isSelected: Bool = false
    var hasBadge: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: image)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSelected ? .black : .gray)
                
                if hasBadge {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                        .offset(x: 12, y: -10)
                }
            }
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(isSelected ? .black : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
