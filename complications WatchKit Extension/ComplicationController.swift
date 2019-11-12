//
//  ComplicationController.swift
//  complications WatchKit Extension
//
//  Created by Nada ElHakim on 11/12/19.
//  Copyright © 2019 Nada ElHakim. All rights reserved.
//

import ClockKit
import WatchKit

import ClockKit
import WatchKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    let userDefaults = UserDefaults.standard
    
    // MARK: - Timeline Configuration
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let update = userDefaults.integer(forKey: "update")
        
        switch complication.family {
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "Klue")
            template.body1TextProvider = CLKSimpleTextProvider(text: "Updates")
            template.body2TextProvider = CLKSimpleTextProvider(text: "\(update)")
            handler(template)
        default:
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "Updates")
            template.line2TextProvider = CLKSimpleTextProvider(text: "\(update)")
            handler(template)
        }
    }
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date())
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let update = userDefaults.integer(forKey: "update")
        var entry: CLKComplicationTimelineEntry
        
        switch complication.family {
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "Klue")
            template.body1TextProvider = CLKSimpleTextProvider(text: "Updates")
            template.body2TextProvider = CLKSimpleTextProvider(text:  "\(update)")
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        default:
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "Update")
            template.line2TextProvider = CLKSimpleTextProvider(text:  "\(update)")
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        }
        
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
}
