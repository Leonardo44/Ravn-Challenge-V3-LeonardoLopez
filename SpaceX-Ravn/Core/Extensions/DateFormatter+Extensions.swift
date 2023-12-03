//
//  DateFormatter+Extensions.swift
//  SpaceX-Ravn
//
//  Created by Leo on 3/12/23.
//

import Foundation

public extension DateFormatter {
    convenience init(dateFormat: String, timeZone: TimeZone, locale: Locale) {
        self.init()
        
        self.dateFormat = dateFormat
        self.timeZone = timeZone
        self.locale = locale
    }
    
    func utcToLocal(dateStr: String, abbreviation: String, inputFormat: String, outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        dateFormatter.timeZone = TimeZone(abbreviation: abbreviation)
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = outputFormat
            dateFormatter.locale = Locale(identifier: Locale.current.identifier)
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
