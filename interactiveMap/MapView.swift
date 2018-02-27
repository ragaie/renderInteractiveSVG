//
//  ViewController.swift
//  interactiveMap
//
//  Created by Ragaie alfy on 5/17/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class MapView: UIViewController {

    
    var oldClickedLayer :CAShapeLayer!
    
    
    let rotateRec = UIRotationGestureRecognizer()
    let ScaleRec = UIPinchGestureRecognizer()
    let gesturePin = UIPanGestureRecognizer()
    
    var svgFile : FSSVG!
    var  map :FSInteractiveMapView!
   
    var mapViewSize : CGFloat! = 0
    var myController : MapController!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myController = MapController()
        myController.myView = self
        
        initMapView()
        
        
        self.view.backgroundColor = UIColor.white
        
        
        rotateRec.addTarget(myController, action:#selector(myController.processTransform))
        view.addGestureRecognizer(rotateRec)
        
        rotateRec.delegate = myController
        
        ScaleRec.addTarget(myController, action: #selector(myController.processTransform))
        view.addGestureRecognizer(ScaleRec)
        ScaleRec.delegate = myController
        
        gesturePin.addTarget(myController, action: #selector(myController.processTransform))
        view.addGestureRecognizer(gesturePin)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    
    
    func initMapView(){
    
    
        // svgFile =  FSSVG.init(file: "germany")
      
        myController.myModel.svgFile = svgFile
        
        map  = FSInteractiveMapView.init(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 500))
       // map.frame =  CGRect.init(x: 0, y: 0, width: 1000, height: 1000)
        
     
  
        mapViewSize = map.frame.width * map.frame.height
    
      //world-low //moa_ground //germany
        
        //map.loadMap("download (4)-1447863674-1448288635", withColors: nil)
      //  map.loadMap("/Users/Ragaie/Library/Developer/CoreSimulator/Devices/F3FBA441-CF83-4FCB-9C55-0E5AA31CE991/data/Containers/Data/Application/FC0F4D27-2E94-4068-B877-425B93ECC27A/Library/Caches/PlaceFiles/2/(4)-1447863674-1448288635.svg")
       
    map.loadMap( "/Users/Ragaie/Library/Developer/CoreSimulator/Devices/C672CE07-4FA4-422A-BDE7-52870280154C/data/Containers/Data/Application/9E04D9DC-A2EE-4B24-ACE9-736F10824040/Library/Caches/PlaceFiles/2/download (4)-1447863674-1448288635.svg")
        
       // map.loadMap("download (4)-1447863674-1448288635")
        
        
        
        map.clickHandler = {(identifier: String?, layer: CAShapeLayer?) -> Void in
            
            
            
            self.title = identifier
            
            //if identifier != "7322" ||  identifier != "6973"{
//            
//            if self.oldClickedLayer != nil{
//            
//                self.oldClickedLayer.zPosition = 0
//                self.oldClickedLayer.shadowOpacity = 0
//                //layer?.fillColor = UIColor.red.cgColor
//
//            }
//            
//            self.oldClickedLayer = layer
//            
//            
//            
//            // We set a simple effect on the layer clicked to highlight it
//            layer?.zPosition = 1
//           // layer?.fillColor = UIColor.red.cgColor
//            layer?.shadowOpacity = 0.5
//            
//            layer?.shadowColor = UIColor.black.cgColor
//            layer?.shadowRadius = 3
//            layer?.shadowOffset = CGSize.init(width: 0, height: 0)
//            
//          //  UIAlertView.init(title: "Layer with identifier ", message: identifier, delegate: nil, cancelButtonTitle: "dismiss").show()
//        
       
            
        }

        
        
        

        
          self.view.addSubview(map)
        
        // call method to add text
        //myController.addTextOnMap()
      //  myController.addUtilityTextDependUtility()

       
    }
    
   
    
    
    

    
    
    
    
        
    
    

}

