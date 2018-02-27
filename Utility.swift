//
//  Utility.swift
//  interactiveMap
//
//  Created by Ragaie alfy on 5/25/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class Utility: NSObject {

   /* {
    message = OK;
    result =     (
    {
    UtilityTerms =             (
    {
    termData =                     (
    325
    );
    "utility_attribute_id" = 3;
    },
    {
    termData =                     (
    330
    );
    "utility_attribute_id" = 4;
    }
    );
     
     
    "location_floor_id" = 57;
    status = 0;
    "updated_at" = 1490712996;
     
     
    utilityHasAttributes =  
     
     (
     
     ////  represent title
    {
    "utility_attribute_id" = 1;
    "utility_id" = 4991;
    value = A2Z;
    },
     
     
     /// represent rectangle inside
    {
    "utility_attribute_id" = 10;
    "utility_id" = 4991;
    value = "{\"x\":955.55108503489,\"y\":1353.5880522365,\"width\":69.550691442023,\"height\":19.871626126292,\"angel\":-90}";
    },
     
     
     // url facebook
    {
    "utility_attribute_id" = 11;
    "utility_id" = 4991;
    value = "https://www.facebook.com/A-2-Z-Lingerie-239636389434296/";
    },
     
     
     // time for start and end
    {
    "utility_attribute_id" = 12;
    "utility_id" = 4991;
    value = "From 11:00 Am To 11:00 Pm";
    },
     
     
    // utility color
     
     {
     "utility_attribute_id" = 22;
     "utility_id" = 4991;
     value = "#c227b9";
     },
     
     /// lat
     {
     "utility_attribute_id" = 23;
     "utility_id" = 4991;
     value = "30.0052192242";
     },
     
     // long
     {
     "utility_attribute_id" = 24;
     "utility_id" = 4991;
     value = "30.9736755272";
     }
     
     
 */
    var utility_id : Int!
    var location_floor_id : Int!
    var status : Int!
    var title : String!
    var colorStr : String!
    var workDate : String!
    var facebookUrl : String!
    
    var longtitue : Double!
    var lantitute  : Double!
    var fitRectangle : FitRectangle!
    var path : FSSVGPathElement!
    
    
    
    func parseObject(value : NSDictionary){
    
        var tempObjectArray = value 
        
        
        location_floor_id = tempObjectArray.object(forKey: "location_floor_id") != nil ?  Int(tempObjectArray.object(forKey: "location_floor_id") as! String) : 0
        
        status = tempObjectArray.object(forKey: "status") != nil ?  Int(tempObjectArray.object(forKey: "status") as! String) : 0
        
        /// get all values
        for item in tempObjectArray.object(forKey: "utilityHasAttributes") as! NSArray{
        
        
            var termObject = item as! NSDictionary
            var id : Int! = Int(termObject.object(forKey: "utility_attribute_id") as! String)
            
            utility_id = termObject.object(forKey: "utility_id") != nil ? Int(termObject.object(forKey: "utility_id") as! String) : 0
            
            
            
            
            switch id {
                
                case 1:  //title
                    title = termObject.object(forKey: "value") != nil ? termObject.object(forKey: "value") as! String : ""
                
                case 10: //rectangle
                
                    print(termObject.object(forKey: "value") )
                    
                    
                   
                    
                    if let data = (termObject.object(forKey: "value") as! String).data(using: .utf8) {
                        do {
                            var recObject : NSDictionary!  =     try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                            
                            var tempRec : FitRectangle! = FitRectangle()
                            
                            "{\"x\":955.55108503489,\"y\":1353.5880522365,\"width\":69.550691442023,\"height\":19.871626126292,\"angel\":-90}";
                            
                            tempRec.x = recObject.object(forKey: "x") != nil ? recObject.object(forKey: "x") as! CGFloat : 0.0
                            tempRec.y = recObject.object(forKey: "y") != nil ? recObject.object(forKey: "y") as! CGFloat : 0.0
                            tempRec.width = recObject.object(forKey: "width") != nil ? recObject.object(forKey: "width") as! CGFloat : 0.0
                            tempRec.hight = recObject.object(forKey: "height") != nil ? recObject.object(forKey: "height") as! CGFloat : 0.0
                            
                            tempRec.angle = recObject.object(forKey: "angel") != nil ? recObject.object(forKey: "angel") as! CGFloat : 0.0
                            
                            fitRectangle = tempRec
                            
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
             
                case 11: //facebook
                
                    facebookUrl = termObject.object(forKey: "value") != nil ? termObject.object(forKey: "value") as! String : ""
                
                case 12: //start date to end date
                
                    workDate = termObject.object(forKey: "value") != nil ? termObject.object(forKey: "value") as! String : ""
                
                case 22: // color
                    colorStr = termObject.object(forKey: "value") != nil ? termObject.object(forKey: "value") as! String : ""
                
                case 23:  // lat
                    lantitute = termObject.object(forKey: "value") != nil ? Double(termObject.object(forKey: "value") as! String) : 0.0
                
                case 24:  // long
                    longtitue = termObject.object(forKey: "value") != nil ? Double(termObject.object(forKey: "value") as! String) : 0.0
                
                default:
                    break
            }
            
        
        }
      
        
    
    
    }
    
    
    
    
    
    
    
    
    
}
