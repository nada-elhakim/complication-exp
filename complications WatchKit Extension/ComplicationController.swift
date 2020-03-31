//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Harry Eakins on 12/11/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    static var counter: Int = 0

    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        // We support neither forward nor backward time travel
        handler([])
    }

    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        switch complication.family {
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
            template.headerTextProvider = CLKSimpleTextProvider(text: "Complication updates")
            template.gaugeProvider = CLKSimpleGaugeProvider(
                style: .fill,
                gaugeColor: .yellow,
                fillFraction: (Float(Self.counter)/10).truncatingRemainder(dividingBy: 1.0))
            template.body1TextProvider = CLKSimpleTextProvider(text: "Counter: \(Self.counter)")
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
            
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "\(Self.counter)")
            template.fillFraction = (Float(Self.counter)/10).truncatingRemainder(dividingBy: 1.0)
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
            
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = CLKTextProvider.init(format: "Complication updates")
            template.bodyTextProvider = CLKSimpleTextProvider(text: "\(Self.counter)")
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
            
        default:
            handler(nil)
        }
    }
}

extension CLKComplicationFamily {
    func stringValue() -> String {
        switch self {
        case .modularSmall:
            return "modularSmall"
        case .modularLarge:
            return "modularLarge"
        case .utilitarianSmall:
            return "utilitarianSmall"
        case .utilitarianSmallFlat:
            return "utilitarianSmallFlat"
        case .utilitarianLarge:
            return "utilitarianLarge"
        case .circularSmall:
            return "circularSmall"
        case .extraLarge:
            return "extraLarge"
        case .graphicCorner:
            return "graphicCorner"
        case .graphicBezel:
            return "graphicBezel"
        case .graphicCircular:
            return "graphicCircular"
        case .graphicRectangular:
            return "graphicRectangular"
        @unknown default:
            return "unknown"
        }
    }
}
