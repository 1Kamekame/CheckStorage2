//
//  ContentView.swift
//  CheckStorage2
//
//  Created by 1Kamekame on 2025/09/20.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    // App Group に保存
    // BackGroundColor
    @AppStorage("BackGroundColorHex", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var BackGroundColorHex: String = "#565656"
    
    // GBText
    @AppStorage("GBTextFontColorHex", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var GBTextFontColorHex: String = "#FFFFFF"
    @AppStorage("GBTextHiddenAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var GBTextHiddenAS: Bool = false
    @AppStorage("GBTextFontSizeAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var GBTextFontSizeAS: Double = 24.5
    @AppStorage("GBTextVerticalOffsetAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var GBTextVerticalOffsetAS: Double = 0.58
    @AppStorage("GBTextHorizontalOffsetAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var GBTextHorizontalOffsetAS: Double = 0.08
    
    // ProgresssBar
    @AppStorage("ProgressBarColorHex", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var ProgressBarColorHex: String = "#2BD757"
    @AppStorage("ProgressBarHeightAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var ProgressBarHeightAS: Double = 0.58
    @AppStorage("ProgressBarWidthAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var ProgressBarWidthAS: Double = 0.26
    @AppStorage("ProgressBarVerticalOffsetAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var ProgressBarVerticalOffsetAS: Double = 0.58
    @AppStorage("ProgressBarHorizontalOffsetAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var ProgressBarHorizontalOffsetAS: Double = 0.79
    
    // AvailableSpaceText
    @AppStorage("AvailableSpaceTextContentAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var AvailableSpaceTextContentAS: String = "Available Space:"
    @AppStorage("AvailableSpaceTextColorHex", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var AvailableSpaceTextColorHex: String = "#FFFFFF"
    @AppStorage("AvailableSpaceTextHiddenAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var AvailableSpaceTextHiddenAS: Bool = false
    @AppStorage("AavilableSpaceTextFontSizeAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var AavilableSpaceTextFontSizeAS: Double = 22.5
    @AppStorage("AvailableSpaceTextVerticalOffsetAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var AvailableSpaceTextVerticalOffsetAS: Double = 0.4
    @AppStorage("AvailableSpaceTextHorizontalOffsetAS", store: UserDefaults(suiteName: "group.kame.web.of.CheckStorage2"))private var AvailableSpaceTextHorizontalOffsetAS: Double = 0.5
    
    
    // ローカル変数
    // BackGroundColor
    @State private var BackGroundColor: Color = (Color(hex: "#565656") ?? .black)
    
    // GBText
    @State private var GBTextFontColor: Color = .white
    @State private var GBTextHidden: Bool = false
    @State private var GBTextFontSize: Double = 24.5
    @State private var GBTextVerticalOffset: Double = 0.58
    @State private var GBTextHorizontalOffset: Double = 0.08
    
    // ProgressBar
    @State private var ProgressBarColor: Color = Color(hex: "#2BD757") ?? .green
    @State private var ProgressBarHeight: Double = 0.58
    @State private var ProgressBarWidth: Double = 0.26
    @State private var ProgressBarVerticalOffset: Double = 0.58
    @State private var ProgressBarHorizontalOffset: Double = 0.79
    
    // AvailableSpaceText
    @State private var AvailableSpaceTextContent: String = "Available Space:"
    @State private var AvailableSpaceTextColor: Color = .white
    @State private var AvailableSpaceTextHidden: Bool = false
    @State private var AavilableSpaceTextFontSize: Double = 22.5
    @State private var AvailableSpaceTextVerticalOffset: Double = 0.4
    @State private var AvailableSpaceTextHorizontalOffset: Double = 0.5
    
    var body: some View {
        VStack(spacing: 15) {
            Text("CheckStorage2 Settings")
                .font(.system(size: 30))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            // MARK: -AvailableSpaceText
            
            HStack {
                Text("AvailableSpaceText")
                VStack{
                    Divider()
                }
            }
            
            // AvailableSpaceTextContent
            HStack {
                Text("AvailableSpaceTextContent")
                Spacer()
                TextField("", text: $AvailableSpaceTextContent)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5) // 枠線の色と太さ
                    )
                    .onChange(of: AvailableSpaceTextContent) { oldValue, newValue in
                        // 保存
                        AvailableSpaceTextContentAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // AvailableSpaceTextColor
            HStack {
                Text("AvailableSpaceTextColor")
                Spacer()
                ColorPicker("", selection: $AvailableSpaceTextColor)
                // ""の空間を消す
                EmptyView()
                // Liquid Glass
                    .glassEffect()
                    .onChange(of: AvailableSpaceTextColor) { oldValue, newValue in
                        // Hex に変換して保存
                        AvailableSpaceTextColorHex = newValue.toHex() ?? "#FFFFFF"
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // AvailableSpaceTextHidden
            HStack {
                Text("AvailableSpaceTextHidden")
                Text(String(AvailableSpaceTextHidden))
                Spacer()
                Toggle("", isOn: $AvailableSpaceTextHidden)
                EmptyView()
                    .glassEffect()
                    .onChange(of: AvailableSpaceTextHidden) { oldValue, newValue in
                        // 保存
                        AvailableSpaceTextHiddenAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // AavilableSpaceTextFontSize
            HStack {
                Text("AavilableSpaceTextFontSize")
                Text(String(format: "%.2fpt", AavilableSpaceTextFontSize))
                Spacer()
                Slider(value: $AavilableSpaceTextFontSize, in: 10...50)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: AavilableSpaceTextFontSize) { oldValue, newValue in
                        // 保存
                        AavilableSpaceTextFontSizeAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // AvailableSpaceTextVerticalOffset
            HStack {
                Text("AvailableSpaceTextVerticalOffset")
                Text(String(format: "%.2f", AvailableSpaceTextVerticalOffset))
                Spacer()
                Slider(value: $AvailableSpaceTextVerticalOffset, in: 0...1)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: AvailableSpaceTextVerticalOffset) { oldValue, newValue in
                        // 保存
                        AvailableSpaceTextVerticalOffsetAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // AvailableSpaceTextHorizontalOffset
            HStack {
                Text("AvailableSpaceTextHorizontalOffset")
                Text(String(format: "%.2f", AvailableSpaceTextHorizontalOffset))
                Spacer()
                Slider(value: $AvailableSpaceTextHorizontalOffset, in: 0...1)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: AvailableSpaceTextHorizontalOffset) { oldValue, newValue in
                        // 保存
                        AvailableSpaceTextHorizontalOffsetAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // MARK: -BackGroundColor
            
            HStack {
                Text("BackGroundColor")
                VStack{
                    Divider()
                }
            }
            
            // BackGroundColor
            HStack {
                Text("BackGroundColor")
                Spacer()
                ColorPicker("", selection: $BackGroundColor)
                // ""の空間を消す
                EmptyView()
                // Liquid Glass
                    .glassEffect()
                    .onChange(of: BackGroundColor) { oldValue, newValue in
                        // Hex に変換して保存
                        BackGroundColorHex = newValue.toHex() ?? "#565656"
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // MARK: -GBText
            
            HStack {
                Text("GBText")
                VStack{
                    Divider()
                }
            }
            
            // GBTextFontColor
            HStack {
                Text("GBTextFontColor")
                Spacer()
                ColorPicker("", selection: $GBTextFontColor)
                // ""の空間を消す
                EmptyView()
                // Liquid Glass
                    .glassEffect()
                    .onChange(of: GBTextFontColor) { oldValue, newValue in
                        // Hex に変換して保存
                        GBTextFontColorHex = newValue.toHex() ?? "#FFFFFF"
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // GBTextHidden
            HStack {
                Text("GBTextHidden")
                Text(String(GBTextHidden))
                Spacer()
                Toggle("", isOn: $GBTextHidden)
                EmptyView()
                    .glassEffect()
                    .onChange(of: GBTextHidden) { oldValue, newValue in
                        // 保存
                        GBTextHiddenAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // GBTextFontSize
            HStack {
                Text("GBTextFontSize")
                Text(String(format: "%.2fpt", GBTextFontSize))
                Spacer()
                Slider(value: $GBTextFontSize, in: 10...50)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: GBTextFontSize) { oldValue, newValue in
                        // 保存
                        GBTextFontSizeAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // GBTextVerticalOffset
            HStack {
                Text("GBTextVerticalOffset")
                Text(String(format: "%.2f", GBTextVerticalOffset))
                Spacer()
                Slider(value: $GBTextVerticalOffset, in: 0...1)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: GBTextVerticalOffset) { oldValue, newValue in
                        // 保存
                        GBTextVerticalOffsetAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // GBTextHorizontalOffset
            HStack {
                Text("GBTextHorizontalOffset")
                Text(String(format: "%.2f", GBTextHorizontalOffset))
                Spacer()
                Slider(value: $GBTextHorizontalOffset, in: 0...1)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: GBTextHorizontalOffset) { oldValue, newValue in
                        // 保存
                        GBTextHorizontalOffsetAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // MARK: -ProgressBar
            
            HStack {
                Text("ProgressBar")
                VStack {
                    Divider()
                }
            }
            
            // ProgressBarColor
            HStack {
                Text("ProgressBarColor")
                Spacer()
                ColorPicker("", selection: $ProgressBarColor)
                EmptyView()
                    .glassEffect()
                    .onChange(of: ProgressBarColor) { oldValue, newValue in
                        // Hex に変換して保存
                        ProgressBarColorHex = newValue.toHex() ?? "#2BD757"
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // ProgressBarHeight
            HStack {
                Text("ProgressBarHeight")
                Text(String(format: "%.2f", ProgressBarHeight))
                Spacer()
                Slider(value: $ProgressBarHeight, in: 0...1)
                    .padding(.horizontal, 10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: ProgressBarHeight) { oldValue, newValue in
                        // 保存
                        ProgressBarHeightAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // ProgressBarWidth
            HStack {
                Text("ProgressBarWidth")
                Text(String(format: "%.2f", ProgressBarWidth))
                Spacer()
                Slider(value: $ProgressBarWidth, in: 0...1)
                    .padding(.horizontal,10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: ProgressBarWidth) { oldValue, newValue in
                        // 保存
                        ProgressBarWidthAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // ProgressBarVerticalOffset
            HStack {
                Text("ProgressBarVerticalOffset")
                Text(String(format: "%.2f", ProgressBarVerticalOffset))
                Spacer()
                Slider(value: $ProgressBarVerticalOffset, in: 0...1)
                    .padding(.horizontal,10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: ProgressBarVerticalOffset) { oldValue, newValue in
                        // 保存
                        ProgressBarVerticalOffsetAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // ProgressBarHorizontalOffset
            HStack {
                Text("ProgressBarHorizontalOffset")
                Text(String(format: "%.2f", ProgressBarHorizontalOffset))
                Spacer()
                Slider(value: $ProgressBarHorizontalOffset, in: 0...1)
                    .padding(.horizontal,10)
                    .frame(width: 300, height: 22)
                    .glassEffect()
                    .onChange(of: ProgressBarHorizontalOffset) { oldValue, newValue in
                        // 保存
                        ProgressBarHorizontalOffsetAS = newValue
                        // Widget 更新
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            
            // MARK: -ResetToDefault
            HStack {
                Text("Reset to default")
                Spacer()
                Button("", action: {
                    // --- AppStorage をデフォルトに戻す ---
                    BackGroundColorHex = "#565656"
                    GBTextFontColorHex = "#FFFFFF"
                    GBTextHiddenAS = false
                    GBTextFontSizeAS = 24.5
                    GBTextVerticalOffsetAS = 0.58
                    GBTextHorizontalOffsetAS = 0.08
                    ProgressBarColorHex = "#2BD757"
                    ProgressBarHeightAS = 0.58
                    ProgressBarWidthAS = 0.26
                    ProgressBarVerticalOffsetAS = 0.58
                    ProgressBarHorizontalOffsetAS = 0.79
                    AvailableSpaceTextContentAS = "Available Space:"
                    AvailableSpaceTextColorHex = "#FFFFFF"
                    AvailableSpaceTextHiddenAS = false
                    AavilableSpaceTextFontSizeAS = 22.5
                    AvailableSpaceTextVerticalOffsetAS = 0.4
                    AvailableSpaceTextHorizontalOffsetAS = 0.5

                    // --- ローカル @State 変数も更新 ---
                    BackGroundColor = Color(hex: BackGroundColorHex) ?? .black
                    GBTextFontColor = Color(hex: GBTextFontColorHex) ?? .white
                    GBTextHidden = GBTextHiddenAS
                    GBTextFontSize = GBTextFontSizeAS
                    GBTextVerticalOffset = GBTextVerticalOffsetAS
                    GBTextHorizontalOffset = GBTextHorizontalOffsetAS
                    ProgressBarColor = Color(hex: ProgressBarColorHex) ?? .green
                    ProgressBarHeight = ProgressBarHeightAS
                    ProgressBarWidth = ProgressBarWidthAS
                    ProgressBarVerticalOffset = ProgressBarVerticalOffsetAS
                    ProgressBarHorizontalOffset = ProgressBarHorizontalOffsetAS
                    AvailableSpaceTextContent = AvailableSpaceTextContentAS
                    AvailableSpaceTextColor = Color(hex: AvailableSpaceTextColorHex) ?? .white
                    AvailableSpaceTextHidden = AvailableSpaceTextHiddenAS
                    AavilableSpaceTextFontSize = AavilableSpaceTextFontSizeAS
                    AvailableSpaceTextVerticalOffset = AvailableSpaceTextVerticalOffsetAS
                    AvailableSpaceTextHorizontalOffset = AvailableSpaceTextHorizontalOffsetAS

                    // Widget 更新
                    WidgetCenter.shared.reloadAllTimelines()
                })
            }
            
        }
        .padding()
        // アプリ起動時に以前のデータを読み込み
        .onAppear {
            // BackGroundColor
            if let savedBackGroundColor = Color(hex: BackGroundColorHex) {
                BackGroundColor = savedBackGroundColor
            }
            // ProgressBarColor
            if let savedProgressBarColor = Color(hex: ProgressBarColorHex) {
                ProgressBarColor = savedProgressBarColor
            }
            // GBTextFontColor
            if let savedGBTextFontColor = Color(hex: GBTextFontColorHex) {
                GBTextFontColor = savedGBTextFontColor
            }
            // GBTextHidden
            GBTextHidden = GBTextHiddenAS
            // GBTextFontSize
            GBTextFontSize = GBTextFontSizeAS
            // ProgressBarHeight
            ProgressBarHeight = ProgressBarHeightAS
            // ProgressBarWidth
            ProgressBarWidth = ProgressBarWidthAS
            // ProgressBarVerticalOffset
            ProgressBarVerticalOffset = ProgressBarVerticalOffsetAS
            // ProgressBarHorizontalOffset
            ProgressBarHorizontalOffset = ProgressBarHorizontalOffsetAS
            // GBTextVerticalOffset
            GBTextVerticalOffset = GBTextVerticalOffsetAS
            // GBTextHorizontalOffset
            GBTextHorizontalOffset = GBTextHorizontalOffsetAS
            
            // MARK: -AvailablSpaceText
            // AvailableSpaceTextContent
            AvailableSpaceTextContent = AvailableSpaceTextContentAS
            // AvailableSpaceTextColor
            if let savedAvailableSpaceTextColor = Color(hex: AvailableSpaceTextColorHex) {
                AvailableSpaceTextColor = savedAvailableSpaceTextColor
            }
            // AvailableSpaceTextHidden
            AvailableSpaceTextHidden = AvailableSpaceTextHiddenAS
            // AavilableSpaceTextFontSize
            AavilableSpaceTextFontSize = AavilableSpaceTextFontSizeAS
            // AvailableSpaceTextVerticalOffset
            AvailableSpaceTextVerticalOffset = AvailableSpaceTextVerticalOffsetAS
            // AvailableSpaceTextHorizontalOffset
            AvailableSpaceTextHorizontalOffset = AvailableSpaceTextHorizontalOffsetAS
        }
    }
}

#Preview {
    ContentView()
}

extension Color {
    // SwiftUI Color → Hex
    func toHex() -> String? {
        guard let components = cgColor?.components, components.count >= 3 else { return nil }
        let r = Int(components[0]*255)
        let g = Int(components[1]*255)
        let b = Int(components[2]*255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
    
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") { hexSanitized.removeFirst() }
        guard hexSanitized.count == 6 else { return nil }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = Double((rgb & 0xFF0000) >> 16)/255
        let g = Double((rgb & 0x00FF00) >> 8)/255
        let b = Double(rgb & 0x0000FF)/255
        self.init(red: r, green: g, blue: b)
    }
}
