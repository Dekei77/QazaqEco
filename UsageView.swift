import SwiftUI
import Charts

struct UsageView: View {
    @StateObject var viewModel = WaterUsageViewModel()
    @State private var showWeekly = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 330)
                    .clipped()
                VStack {
                    HStack {
                        Image("profilePic")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        Spacer()
                        Menu {
                            Button("Today", action: { showWeekly = false })
                            Button("Last Week", action: { showWeekly = true })
                        } label: {
                            HStack {
                                Text(showWeekly ? "Last Week" : "Today")
                                    .font(.system(size: 16, weight: .medium))
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 50)
                    Spacer()
                    PieChartView(
                        data: showWeekly ? viewModel.weeklyData : viewModel.dailyData,
                        showWeekly: showWeekly
                    )
                    .frame(width: 200, height: 200)
                    .padding(.top, -100)
                }
            }
            VStack(alignment: .leading) {
                Text(showWeekly ? "Weekly Usage" : "Daily Usage")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                CustomWaterUsageChartView(
                    hourlyData: viewModel.dailyData,
                    weekdayData: viewModel.weeklyData
                )
                .frame(height: 450)
                .padding(.horizontal, 16)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.top, -80)
            Spacer()
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

struct PieChartView: View {
    let data: [(timeRange: String, totalUsage: Double)]
    let showWeekly: Bool
    var body: some View {
        Chart {
            ForEach(data, id: \ .timeRange) { entry in
                SectorMark(
                    angle: .value("Usage", entry.totalUsage),
                    innerRadius: .ratio(0.5),
                    angularInset: 2
                )
                .foregroundStyle(by: .value("Category", entry.timeRange))
            }
        }
        .frame(width: 200, height: 200)
    }
}

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

class WaterUsageViewModel: ObservableObject {
    @Published var dailyData: [(timeRange: String, totalUsage: Double)] = []
    @Published var weeklyData: [(timeRange: String, totalUsage: Double)] = []
    init() {
        let data = loadCSV()
        dailyData = groupByFourHourIntervals(data)
        weeklyData = groupByWeekday(data).map { ($0.weekday, $0.totalUsage) }
    }
}

struct CustomWaterUsageChartView: View {
    let hourlyData: [(timeRange: String, totalUsage: Double)]
    let weekdayData: [(timeRange: String, totalUsage: Double)]
    @State private var showWeekly = false
    var body: some View {
        VStack {
            Picker("Select Mode", selection: $showWeekly) {
                Text("Hourly").tag(false)
                Text("Weekly").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Chart {
                if showWeekly {
                    ForEach(weekdayData, id: \ .timeRange) { data in
                        BarMark(
                            x: .value("Day of the Week", data.timeRange),
                            y: .value("Water Usage", data.totalUsage)
                        )
                        .foregroundStyle(.blue)
                    }
                } else {
                    ForEach(hourlyData, id: \ .timeRange) { data in
                        BarMark(
                            x: .value("Time Interval", data.timeRange),
                            y: .value("Water Usage", data.totalUsage)
                        )
                        .foregroundStyle(.green)
                    }
                }
            }
            .chartYAxisLabel("Liters")
            .frame(height: 300)
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct UsageView_Previews: PreviewProvider {
    static var previews: some View {
        UsageView()
    }
}
