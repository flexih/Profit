
import Foundation
import SwiftUI

private extension String {

    func localized() -> String {
        return NSLocalizedString(self, bundle: .module, comment: "")
    }

}

public struct Profit {

    protocol AppInfo {
        var title: String { get }
        var description: String { get }
        var imageName: String { get }
        var id: String { get }
        var url: URL { get }
    }

    public enum App: String, AppInfo, CaseIterable {
        case onepower
        case mysensor
        case glucosedaily
        case camflags
        case circle
        case pande
        case onestopwatch
        case yiqi
        case che

        var title: String {
            "\(self.rawValue).title"
        }

        var description: String {
            "\(self.rawValue).description"
        }

        var imageName: String {
            self.rawValue
        }

        var id: String {
            switch self {
            case .onepower:
                return "id6474468540"
            case .mysensor:
                return "id6504740377"
            case .glucosedaily:
                return "id6746083988"
            case .pande:
                return "id1291825838"
            case .onestopwatch:
                return "id1672759794"
            case .circle:
                return "id1166572670"
            case .yiqi:
                return "id6464371498"
            case .che:
                return "id6445831200"
            case .camflags:
                return "id6751882342"
            }
        }

        var url: URL {
            switch self {
            case .onepower:
                return URL(string: "https://apps.apple.com/app/1power-virtual-ride-simulator/id6474468540")!
            case .mysensor:
                return URL(string: "https://apps.apple.com/app/mysensor/id6504740377")!
            case .glucosedaily:
                return URL(string: "https://apps.apple.com/app/glucose-daily/id6746083988")!
            case .pande:
                return URL(string: "https://apps.apple.com/app/pande/id1291825838")!
            case .onestopwatch:
                return URL(string: "https://apps.apple.com/app/onestopwatch/id1672759794")!
            case .circle:
                return URL(string: "https://apps.apple.com/app/circle/id1166572670")!
            case .yiqi:
                return URL(string: "https://apps.apple.com/app/yiqi/id6464371498")!
            case .che:
                return URL(string: "https://apps.apple.com/app/id6445831200")!
            case .camflags:
                return URL(string: "https://apps.apple.com/app/id6454024308")!
            }
        }

    }

    public struct Item: AppInfo {
        public let title: String
        public let description: String
        public let imageName: String
        public let id: String
        public let url: URL

        init(app: App) {
            self.title = app.title.localized()
            self.description = app.description.localized()
            self.imageName = app.imageName
            self.id = app.id
            self.url = app.url
        }
    }

    public private(set) var allApps: [Item]

    init(excludeApps: [Profit.App] = []) {
        self.allApps = App.allCases.filter { !excludeApps.contains($0) }.map { Item(app: $0) }
    }
}

public struct ProfitItemView: View {

    public let item: Profit.Item

    public init(item: Profit.Item) {
        self.item = item
    }

    public var body: some View {
        Link(destination: item.url, label: {
            HStack(spacing: 16) {
                Image(item.imageName, bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(item.title)
                        .foregroundColor(.primary)
                    Text(item.description)
                        .foregroundColor(.secondary)
                }
            }
        })
        .buttonStyle(.plain)
    }
}

public struct ProfitView: View {
    public let profit: Profit

    public init(excludeApps: [Profit.App] = []) {
        self.profit = Profit(excludeApps: excludeApps)
    }

    public var body: some View {
        Section {
            ForEach(profit.allApps, id: \.id) { item in
                ProfitItemView(item: item)
            }
        } header: {
            Text("Profit".localized())
        }
    }
}

#Preview {
    ProfitView(excludeApps: [.che])
}
