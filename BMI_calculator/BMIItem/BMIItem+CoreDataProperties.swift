//
//  BMIItem+CoreDataProperties.swift
//  BMI_calculator
//
//  Created by chin wai lai on 6/12/2022.
//
//

import Foundation
import CoreData


extension BMIItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BMIItem> {
        return NSFetchRequest<BMIItem>(entityName: "BMIItem")
    }

    @NSManaged public var weight: Float
    @NSManaged public var bmi: Float
    @NSManaged public var date: Date?
    @NSManaged public var height: Float
    @NSManaged public var mode: String?

}

extension BMIItem : Identifiable {

}
