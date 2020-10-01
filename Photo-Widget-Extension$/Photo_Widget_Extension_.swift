//
//  Photo_Widget_Extension_.swift
//  Photo-Widget-Extension$
//
//  Created by muhammed on 01/10/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), imageID: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), imageID: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        let currentDate = Date()
        
        let imageIds = Helper.getImageIdsFromUserDefault()
        
        // testing for 5 seconds
        let timeRangeInSecond = 5
        
        for index in 0 ..< imageIds.count {
            
            let entryDate = Calendar.current.date(byAdding: .second, value: index * timeRangeInSecond, to: currentDate)!
            
            let entry = SimpleEntry(date: entryDate, imageID: imageIds[index])
            
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let imageID: String?
}

struct Photo_Widget_Extension_EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if let imageID = entry.imageID {
            Image(uiImage: Helper.getImageFromUserDefaults(key: imageID))
                .resizable()
                .scaledToFill()
        } else {
            Image("preview")
                .resizable()
                .scaledToFill()
        }
    }
}

@main
struct Photo_Widget_Extension_: Widget {
    let kind: String = "Photo_Widget_Extension_"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Photo_Widget_Extension_EntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Photo_Widget_Extension__Previews: PreviewProvider {
    static var previews: some View {
        Photo_Widget_Extension_EntryView(entry: SimpleEntry(date: Date(), imageID: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
