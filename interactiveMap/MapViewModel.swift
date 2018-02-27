//
//  MapViewModel.swift
//  interactiveMap
//
//  Created by Ragaie alfy on 5/25/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class MapViewModel: NSObject ,getRemoteData{
    
    
    dynamic var flage : String!
    var svgFile : FSSVG!

    
    
    var allUtility : [Utility]! = []
    
    override init(){
    
        super.init()
    }
    
    
    
    func getUtilityData(){
    
        getUrlData(parameter: "" as! AnyObject, url: UrlData.getAllUtility, way: "get", flagSender: "getData")
    }
    
    
    
    func parseData(result: AnyObject, flagSender: String) {
        
        
   
        var AllUtility  = (result as! NSDictionary).object(forKey: "result") as! NSArray
        
        for item in AllUtility{
            
            var tempUtility : Utility!  = Utility()
            
            tempUtility.parseObject(value: item as! NSDictionary )
            
            if tempUtility.utility_id != nil {
                tempUtility.path = findPathForID(id: tempUtility.utility_id)

            
            }
            
            allUtility.append(tempUtility)

            
            
        
        }
        
       flage = "dataFinished"
        
    }
    
    
    
    func findPathForID(id : Int) -> FSSVGPathElement{
        
        
        
        for item in  svgFile.paths{
            
            
            var path = item as! FSSVGPathElement
            
            
           // print(" id value \(path.identifier) ,\(id) ")
            
            if path.identifier == "\(id)"{
               // print(" id value \(path.identifier) ,\(id) ")
                return path
            }
            
        }
        
        var path1 : FSSVGPathElement! = FSSVGPathElement()
        
        
        
        return path1
        
        
    }
    

}
