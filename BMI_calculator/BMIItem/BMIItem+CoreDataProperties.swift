//
//  BMIItem+CoreDataProperties.swift
//  BMI_calculator
//
//  Created by chin wai lai on 5/12/2022.
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

}

extension BMIItem : Identifiable {

}
