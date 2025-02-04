import SwiftUI
import Charts

struct WaterUsageData: Identifiable {
    let id = UUID()
    let date: Date
    let waterUsage: Double
}

func loadCSV() -> [WaterUsageData] {
    guard let path = Bundle.main.path(forResource: "test_database", ofType: "csv") else {
        print("CSV file not found")
        return []
    }
    let url = URL(fileURLWithPath: path)
    
    do {
        let data = try String(contentsOf: url, encoding: .utf8)
        let rows = data.components(separatedBy: "\n").dropFirst()
        
        var waterUsageList: [WaterUsageData] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count >= 5,
               let waterUsage = Double(columns[3]),
               let date = dateFormatter.date(from: columns[4].trimmingCharacters(in: .whitespaces)) {
                waterUsageList.append(WaterUsageData(date: date, waterUsage: waterUsage))
            }
        }
        
        print("Loaded records: \(waterUsageList.count)")
        return waterUsageList
    } catch {
        print("Error loading CSV: \(error)")
        return []
    }
}

func groupByFourHourIntervals(_ data: [WaterUsageData]) -> [(timeRange: String, totalUsage: Double)] {
    var grouped: [String: [WaterUsageData]] = [:]
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())

    for record in data {
        let recordDate = calendar.startOfDay(for: record.date)
        if recordDate == today {
            let hour = calendar.component(.hour, from: record.date)
            let range = hour / 4 * 4
            let timeRange = "\(range):00 - \(range + 4):00"
            grouped[timeRange, default: []].append(record)
        }
    }

    let result = grouped.map { (timeRange, records) -> (String, Double) in
        let totalUsage = records.reduce(0.0) { $0 + $1.waterUsage }
        return (timeRange, totalUsage)
    }
    .sorted { $0.0 < $1.0 }
    
    print("Interval data for today: \(result)")
    return result
}

func groupByWeekday(_ data: [WaterUsageData]) -> [(weekday: String, totalUsage: Double)] {
    var grouped: [String: Double] = [:]
    let calendar = Calendar(identifier: .gregorian)
    let weekdaySymbols = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    for day in weekdaySymbols {
        grouped[day] = 0.0
    }

    for record in data {
        let weekdayIndex = (calendar.component(.weekday, from: record.date) + 5) % 7
        let weekday = weekdaySymbols[weekdayIndex]
        grouped[weekday, default: 0.0] += record.waterUsage
    }

    let result = weekdaySymbols.map { ($0, grouped[$0] ?? 0.0) }
    
    print("Weekly data corrected: \(result)")
    return result
}

struct WaterUsageChartView: View {
    let dailyData: [(timeRange: String, totalUsage: Double)]
    let weekdayData: [(weekday: String, totalUsage: Double)]
    
    @State private var showWeekly = false
    
    var body: some View {
        VStack {
            Picker("Select View Mode", selection: $showWeekly) {
                Text("By Time of Day").tag(false)
                Text("By Day of the Week").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if dailyData.isEmpty && weekdayData.isEmpty {
                Text("No data available")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Chart {
                    if showWeekly {
                        ForEach(weekdayData, id: \ .weekday) { data in
                            BarMark(
                                x: .value("Day of the Week", data.weekday),
                                y: .value("Water Usage", data.totalUsage)
                            )
                            .foregroundStyle(.blue)
                        }
                    } else {
                        ForEach(dailyData, id: \ .timeRange) { data in
                            BarMark(
                                x: .value("Time Interval", data.timeRange),
                                y: .value("Water Usage", data.totalUsage)
                            )
                            .foregroundStyle(.green)
                        }
                    }
                }
                .chartYAxisLabel("Liters")
                .chartXAxisLabel(showWeekly ? "Day of the Week" : "Time Interval")
                .frame(minHeight: 300, maxHeight: 350)
                .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct WaterUsageChartView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleData = loadCSV()

        let mockData: [WaterUsageData] = [
            WaterUsageData(date: Calendar.current.date(bySettingHour: 1, minute: 0, second: 0, of: Date())!, waterUsage: 10),
            WaterUsageData(date: Calendar.current.date(bySettingHour: 5, minute: 0, second: 0, of: Date())!, waterUsage: 15),
            WaterUsageData(date: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, waterUsage: 20),
            WaterUsageData(date: Calendar.current.date(bySettingHour: 13, minute: 0, second: 0, of: Date())!, waterUsage: 25),
            WaterUsageData(date: Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!, waterUsage: 30),
            WaterUsageData(date: Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!, waterUsage: 35)
        ]

        let finalData = sampleData.isEmpty ? mockData : sampleData

        WaterUsageChartView(
            dailyData: groupByFourHourIntervals(finalData),
            weekdayData: groupByWeekday(finalData)
        )
    }
}
