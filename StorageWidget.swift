//
//  Storage_Widget.swift
//  Storage Widget
//
//  Created by 1Kamekame on 2025/09/20.
//

import WidgetKit
import SwiftUI
import Foundation

// Timeline Entry
struct StorageEntry: TimelineEntry {
    let date: Date
    // 表示
    let BackGroundColorHex: String
    let ProgressBarColorHex: String
    let ProgressBarHeightAS: Double
    let ProgressBarWidthAS: Double
    let ProgressBarVerticalOffsetAS: Double
    let ProgressBarHorizontalOffsetAS: Double
    let GBTextHiddenAS: Bool
    let GBTextFontSizeAS: Double
    let GBTextVerticalOffsetAS: Double
    let GBTextHorizontalOffsetAS: Double
    let GBTextFontColorHex: String
    let AvailableSpaceTextContentAS: String
    let AvailableSpaceTextColorHex: String
    let AvailableSpaceTextHiddenAS: Bool
    let AavilableSpaceTextFontSizeAS: Double
    let AvailableSpaceTextVerticalOffsetAS: Double
    let AvailableSpaceTextHorizontalOffsetAS: Double
    // 容量計算用
    let availableCapacity: Double
    let totalCapacity: Double
    // 容量計算用(レガシー)
//    let freeStorageformatter: String
//    let maxStorageformatter: String
}

// Timeline Provider
struct StorageProvider: AppIntentTimelineProvider {
    typealias Entry = StorageEntry
    typealias Intent = ConfigurationAppIntent
    
    // ① プレースホルダー (ウィジェットのプレビュー用)
    func placeholder(in context: Context) -> StorageEntry {
        StorageEntry(
            // ここに追記していく
            date: Date(),
            BackGroundColorHex: "#565656",
            ProgressBarColorHex: "#2BD757",
            ProgressBarHeightAS: 0.58,
            ProgressBarWidthAS: 0.26,
            ProgressBarVerticalOffsetAS: 0.58,
            ProgressBarHorizontalOffsetAS: 0.79,
            GBTextHiddenAS: false,
            GBTextFontSizeAS: 24.5,
            GBTextVerticalOffsetAS: 0.58,
            GBTextHorizontalOffsetAS: 0.08,
            GBTextFontColorHex: "#FFFFFF",
            AvailableSpaceTextContentAS: "Available Space:",
            AvailableSpaceTextColorHex: "#FFFFFF",
            AvailableSpaceTextHiddenAS: false,
            AavilableSpaceTextFontSizeAS: 22.5,
            AvailableSpaceTextVerticalOffsetAS: 0.4,
            AvailableSpaceTextHorizontalOffsetAS: 0.5,
            //容量取得
            availableCapacity: 50,
            totalCapacity: 100
            // 容量計算用(レガシー)
//            freeStorageformatter: "1.5GB",
//            maxStorageformatter: "100.0GB"
        )
    }
    
    // ② スナップショット (ウィジェットギャラリーなど)
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> StorageEntry {
        let settings = readSettings()
        // 容量計算用
        let (total, available) = getStorageGB() // 同期取得してプレビュー用
        return StorageEntry(
            // ここに追記していく
            date: Date(),
            BackGroundColorHex: settings.BackGroundColor,
            ProgressBarColorHex: settings.ProgressBarColor,
            ProgressBarHeightAS: settings.ProgressBarHeight,
            ProgressBarWidthAS: settings.ProgressBarWidth,
            ProgressBarVerticalOffsetAS: settings.ProgressBarVerticalOffset,
            ProgressBarHorizontalOffsetAS: settings.ProgressBarHorizontalOffset,
            GBTextHiddenAS: settings.GBTextHidden,
            GBTextFontSizeAS: settings.GBTextFontSize,
            GBTextVerticalOffsetAS: settings.GBTextVerticalOffset,
            GBTextHorizontalOffsetAS: settings.GBTextHorizontalOffset,
            GBTextFontColorHex: settings.GBTextFontColor,
            AvailableSpaceTextContentAS: settings.AvailableSpaceTextContent,
            AvailableSpaceTextColorHex: settings.AvailableSpaceTextColor,
            AvailableSpaceTextHiddenAS: settings.AvailableSpaceTextHidden,
            AavilableSpaceTextFontSizeAS: settings.AavilableSpaceTextFontSize,
            AvailableSpaceTextVerticalOffsetAS: settings.AvailableSpaceTextVerticalOffset,
            AvailableSpaceTextHorizontalOffsetAS: settings.AvailableSpaceTextHorizontalOffset,
            // 容量取得
            availableCapacity: 50,
            totalCapacity: 100
            // 容量計算用(レガシー)
//            freeStorageformatter: "1.5GB",
//            maxStorageformatter: "100.0GB"
        )
    }
    
    // ③ タイムライン (実際に表示するデータ)
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<StorageEntry> {
        let settings = readSettings()
        
        // 総容量・空き容量取得
        let (totalGB, availableGB) = getStorageGB()
        // 非同期で容量取得
        let (total, available) = await getStorageGBAsync()
        
        // 容量取得　レガシー
//        let (total, available) = getStorageGB()
        
        let entry = StorageEntry(
            // ここに追記していく
            date: Date(),
            BackGroundColorHex: settings.BackGroundColor,
            ProgressBarColorHex: settings.ProgressBarColor,
            ProgressBarHeightAS: settings.ProgressBarHeight,
            ProgressBarWidthAS: settings.ProgressBarWidth,
            ProgressBarVerticalOffsetAS: settings.ProgressBarVerticalOffset,
            ProgressBarHorizontalOffsetAS: settings.ProgressBarHorizontalOffset,
            GBTextHiddenAS: settings.GBTextHidden,
            GBTextFontSizeAS: settings.GBTextFontSize,
            GBTextVerticalOffsetAS: settings.GBTextVerticalOffset,
            GBTextHorizontalOffsetAS: settings.GBTextHorizontalOffset,
            GBTextFontColorHex: settings.GBTextFontColor,
            AvailableSpaceTextContentAS: settings.AvailableSpaceTextContent,
            AvailableSpaceTextColorHex: settings.AvailableSpaceTextColor,
            AvailableSpaceTextHiddenAS: settings.AvailableSpaceTextHidden,
            AavilableSpaceTextFontSizeAS: settings.AavilableSpaceTextFontSize,
            AvailableSpaceTextVerticalOffsetAS: settings.AvailableSpaceTextVerticalOffset,
            AvailableSpaceTextHorizontalOffsetAS: settings.AvailableSpaceTextHorizontalOffset,
            // 容量取得
            availableCapacity: available,
            totalCapacity: total
            // 容量取得　レガシー
//            freeStorageformatter: available,
//            maxStorageformatter: total
            
        )
        
        return Timeline(entries: [entry], policy: .atEnd)
        // 更新頻度1分(負荷多)高速
        //        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? Date().addingTimeInterval(60)
        //        return Timeline(entries: [entry], policy: .after(nextUpdate))
    }
    
    // ④ UserDefaults (App Group) から値を読み取る
    // 追記時、配列の型変更必須
    private func readSettings() -> (BackGroundColor: String, ProgressBarColor: String, ProgressBarHeight: Double, ProgressBarWidth: Double, ProgressBarVerticalOffset: Double, ProgressBarHorizontalOffset: Double, GBTextHidden: Bool, GBTextFontSize: Double, GBTextVerticalOffset: Double, GBTextHorizontalOffset: Double, GBTextFontColor: String, AvailableSpaceTextContent: String, AvailableSpaceTextColor: String, AvailableSpaceTextHidden: Bool, AavilableSpaceTextFontSize: Double, AvailableSpaceTextVerticalOffset: Double, AvailableSpaceTextHorizontalOffset: Double) {
        let defaults = UserDefaults(suiteName: "group.kame.web.of.CheckStorage2")
        // ここに追記していく
        let BackGroundColor = defaults?.string(forKey: "BackGroundColorHex") ?? "#565656"
        let ProgressBarColor = defaults?.string(forKey: "ProgressBarColorHex") ?? "#2BD757"
        let ProgressBarHeight = defaults?.double(forKey: "ProgressBarHeightAS") ?? 0.58
        let ProgressBarWidth = defaults?.double(forKey: "ProgressBarWidthAS") ?? 0.26
        let ProgressBarVerticalOffset = defaults?.double(forKey: "ProgressBarVerticalOffsetAS") ?? 0.58
        let ProgressBarHorizontalOffset = defaults?.double(forKey: "ProgressBarHorizontalOffsetAS") ?? 0.79
        let GBTextHidden = defaults?.bool(forKey: "GBTextHiddenAS") ?? false
        let GBTextFontSize = defaults?.double(forKey: "GBTextFontSizeAS") ?? 24.5
        let GBTextVerticalOffset = defaults?.double(forKey: "GBTextVerticalOffsetAS") ?? 0.58
        let GBTextHorizontalOffset = defaults?.double(forKey: "GBTextHorizontalOffsetAS") ?? 0.08
        let GBTextFontColor = defaults?.string(forKey: "GBTextFontColorHex") ?? "#FFFFFF"
        let AvailableSpaceTextContent = defaults?.string(forKey: "AvailableSpaceTextContentAS") ?? "Available Space:"
        let AvailableSpaceTextColor = defaults?.string(forKey: "AvailableSpaceTextColorHex") ?? "#FFFFFF"
        let AvailableSpaceTextHidden = defaults?.bool(forKey: "AvailableSpaceTextHiddenAS") ?? false
        let AavilableSpaceTextFontSize = defaults?.double(forKey: "AavilableSpaceTextFontSizeAS") ?? 22.5
        let AvailableSpaceTextVerticalOffset = defaults?.double(forKey: "AvailableSpaceTextVerticalOffsetAS") ?? 0.4
        let AvailableSpaceTextHorizontalOffset = defaults?.double(forKey: "AvailableSpaceTextHorizontalOffsetAS") ?? 0.5
        // 追記時、配列の型変更必須
        return (BackGroundColor, ProgressBarColor, ProgressBarHeight, ProgressBarWidth, ProgressBarVerticalOffset, ProgressBarHorizontalOffset, GBTextHidden, GBTextFontSize, GBTextVerticalOffset, GBTextHorizontalOffset, GBTextFontColor, AvailableSpaceTextContent, AvailableSpaceTextColor, AvailableSpaceTextHidden, AavilableSpaceTextFontSize, AvailableSpaceTextVerticalOffset, AvailableSpaceTextHorizontalOffset)
    }
}

// Widget View
struct StorageWidgetEntryView: View {
    var entry: StorageProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                smallView
            case .systemMedium:
                mediumView
            default:
                smallView
            }
        }
        .containerBackground((Color(hex: entry.BackGroundColorHex) ?? Color.black).opacity(0.8), for: .widget)
    }
    
    var smallView: some View {
        VStack {
            Text(String(format: "%.2f", entry.availableCapacity) + "GB")
                .foregroundColor((Color(hex: entry.GBTextFontColorHex) ?? .white))
                .font(.system(size: entry.GBTextFontSizeAS))
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding()
    }
    
    var mediumView: some View {
        ZStack {
            //AvailableSpace
            Text(String(entry.AvailableSpaceTextContentAS))
                .foregroundColor((Color(hex: entry.AvailableSpaceTextColorHex) ?? .white))
                .font(.system(size: entry.AavilableSpaceTextFontSizeAS))
                .opacity(entry.AvailableSpaceTextHiddenAS ? 0 : 1)
                .offset(x: (entry.AvailableSpaceTextHorizontalOffsetAS - 0.5) * 200, y: (entry.AvailableSpaceTextVerticalOffsetAS - 0.5) * 200)
            // GB表示
            Text(String(format: "%.2f", entry.availableCapacity) + "GB")
            // レガシー
//            Text(String(format: "%.2f", entry.freeStorageformatter) + "GB")
                .foregroundColor((Color(hex: entry.GBTextFontColorHex) ?? .white))
                .font(.system(size: entry.GBTextFontSizeAS))
                .opacity(entry.GBTextHiddenAS ? 0 : 1)
                .offset(x: (entry.GBTextHorizontalOffsetAS - 0.5) * 200, y: (entry.GBTextVerticalOffsetAS - 0.5) * 200)
            // ProgressView
            ProgressView(value: (entry.totalCapacity - entry.availableCapacity) / entry.totalCapacity)
            // レガシー
//            ProgressView(value: (parseGBString(entry.maxStorageformatter) - parseGBString(entry.freeStorageformatter)) / parseGBString(entry.maxStorageformatter))
                .progressViewStyle(.linear)
                .tint(Color(hex: entry.ProgressBarColorHex) ?? .blue)
                .foregroundStyle(.tint)
                .scaleEffect(x: entry.ProgressBarWidthAS * 2, y: entry.ProgressBarHeightAS * 8)
                .offset(x: (entry.ProgressBarHorizontalOffsetAS - 0.5) * 200, y: (entry.ProgressBarVerticalOffsetAS - 0.5) * 200)
        }
        .padding()
    }
}

// Widget 本体
struct StorageWidget: Widget {
    let kind: String = "StorageWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: StorageProvider()) { entry in
            StorageWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Storage Widget")
        .description("Storage Widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// Color Hex
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") { hexSanitized.removeFirst() }
        guard hexSanitized.count == 6 else { return nil }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}

// 容量取得
// 容量取得 (同期用)
func getStorageGB() -> (total: Double, available: Double) {
    let fileManager = FileManager.default
    guard let volumes = fileManager.mountedVolumeURLs(
        includingResourceValuesForKeys: [.volumeAvailableCapacityForImportantUsageKey, .volumeTotalCapacityKey],
        options: .skipHiddenVolumes
    ) else { return (0, 0) }

    var totalCapacity: Int64 = 0
    var availableCapacity: Int64 = 0

    for volumeURL in volumes {
        do {
            let values = try volumeURL.resourceValues(forKeys: [.volumeTotalCapacityKey, .volumeAvailableCapacityForImportantUsageKey])
            if let t = values.volumeTotalCapacity { totalCapacity += Int64(t) }
            if let a = values.volumeAvailableCapacityForImportantUsage { availableCapacity += Int64(a) }
        } catch {
            print("Error retrieving storage info for \(volumeURL.path): \(error)")
        }
    }

    return (Double(totalCapacity) / 1024 / 1024 / 1024,
            Double(availableCapacity) / 1024 / 1024 / 1024)
}

// 容量取得 (非同期/Widget用)
func getStorageGBAsync() async -> (Double, Double) {
    return await withCheckedContinuation { continuation in
        DispatchQueue.global(qos: .userInitiated).async {
            let result = getStorageGB()
            continuation.resume(returning: result)
        }
    }
}


// MARK: -レガシー対応
//func getStorageGB() -> (total: String, available: String) {
//    let fileManager = FileManager.default
//    var total = "0 GB"
//    var available = "0 GB"
//    do {
//        let systemAttributes = try fileManager.attributesOfFileSystem(forPath: "/")
//        //空き容量
//        if let freeSize = systemAttributes[.systemFreeSize] as? NSNumber {
//            if let maxCapacity = systemAttributes[.systemSize] as? NSNumber {
//                available = ByteCountFormatter.string(fromByteCount: freeSize.int64Value, countStyle: .file)
//                total = ByteCountFormatter.string(fromByteCount: maxCapacity.int64Value, countStyle: .file)
////                let entry = SimpleEntry(date: Date(), configuration: configuration, freeStorage: formattedFreeSize, maxStorage: formattedMaxCapacity)
////                entries.append(entry)
//            }
//        }
//    } catch {
//        print("Error: \(error.localizedDescription)")
//    }
//    return(total, available)
//}
//
//func parseGBString(_ value: String) -> Double {
//    // "619 GB" → "619"
//    let numberString = value.replacingOccurrences(of: " GB", with: "")
//    return Double(numberString) ?? 0.0
//}
