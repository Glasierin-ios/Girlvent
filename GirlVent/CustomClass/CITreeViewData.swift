//
//  CITreeViewData.swift
//  CITreeView
//
//  Created by Apple on 24.01.2018.
//  Copyright © 2018 Cenk Işık. All rights reserved.
//

import UIKit

class CITreeViewData {
    
    let name : String
    let ids : String
    var children : [CITreeViewData]
    
    init(name : String, children: [CITreeViewData],ids : String) {
        self.name = name
        self.children = children
        self.ids = ids
    }
    
    convenience init(name : String,ids:String) {
        self.init(name: name, children: [CITreeViewData](),ids:ids)
    }
    
    func addChild(_ child : CITreeViewData) {
        self.children.append(child)
    }
    
    func removeChild(_ child : CITreeViewData) {
        self.children = self.children.filter( {$0 !== child})
    }
}

extension CITreeViewData {
    
    static func getDefaultCITreeViewData() -> [CITreeViewData] {
        
   
        
        let child11 = CITreeViewData(name: "VolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvo",ids:"5")
        let child12 = CITreeViewData(name: "FiatVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvoVolvo",ids:"5")
        let child13 = CITreeViewData(name: "Alfa Romeo",ids:"6")
        let child14 = CITreeViewData(name: "Mercedes",ids:"7")
        let parent1 = CITreeViewData(name: "Sedan", children: [child11, child12, child13, child14],ids:"8")
        
//        let subChild221 = CITreeViewData(name: "Discovery",ids:"9")
//        let subChild222 = CITreeViewData(name: "Evoque",ids:"10")
//        let subChild223 = CITreeViewData(name: "Defender",ids:"11")
//        let subChild224 = CITreeViewData(name: "Freelander",ids:"12")
        
        let child21 = CITreeViewData(name: "GMC",ids:"13")
        let child22 = CITreeViewData(name: "Land Rover",ids: "14")
        let parent2 = CITreeViewData(name: "SUV", children: [child21, child22],ids:"15")
        
        
        let child31 = CITreeViewData(name: "Wolkswagen",ids:"16")
        let child32 = CITreeViewData(name: "Toyota",ids:"17")
        let child33 = CITreeViewData(name: "Dodge",ids:"18")
        let parent3 = CITreeViewData(name: "Truck", children: [child31, child32,child33],ids:"19")
        
        let subChildChild5321 = CITreeViewData(name: "Carrera",ids:"20")
        let subChildChild5322 = CITreeViewData(name: "Carrera 4 GTS",ids:"21")
        let subChildChild5323 = CITreeViewData(name: "Targa 4",ids:"22")
        let subChildChild5324 = CITreeViewData(name: "Turbo S",ids:"23")
        
        let parent4 = CITreeViewData(name: "Van",children:[subChildChild5321,subChildChild5322,subChildChild5323,subChildChild5324],ids:"24")
        
       
        
//        let subChild531 = CITreeViewData(name: "Cayman")
//        let subChild532 = CITreeViewData(name: "911",children:[subChildChild5321,subChildChild5322,subChildChild5323,subChildChild5324])
//
        let child51 = CITreeViewData(name: "Renault",ids:"25")
        let child52 = CITreeViewData(name: "Ferrari",ids:"26")
        let child53 = CITreeViewData(name: "Porshe",ids:"27")
        let child54 = CITreeViewData(name: "Maserati",ids:"28")
        let child55 = CITreeViewData(name: "Bugatti",ids:"29")
        let parent5 = CITreeViewData(name: "Sports Car",children:[child51,child52,child53,child54,child55],ids:"30")

        
        return [parent5,parent2,parent1,parent3,parent4]
    }
    
    
}
