//
//  MapController.swift
//  interactiveMap
//
//  Created by Ragaie alfy on 5/17/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

class MapController: NSObject,UIGestureRecognizerDelegate {

    
    private var myContext = 0

    
    var initialTransform: CGAffineTransform?
    
    var gestures = Set<UIGestureRecognizer>(minimumCapacity: 3)
   
    var myView : MapView!
    
    var myModel : MapViewModel!
   
    var minPathBound : CGFloat! = 0
    var maxPathBound : CGFloat! = 0
    var ratioPathBound : CGFloat! = 0
    
    override init(){
    
        super.init()
    
  
    
 
        myModel = MapViewModel()
        myModel.addObserver(self,forKeyPath: "flage",options: .new,context: &myContext)
        
       // print("start time \(Date())")
        myModel.getUtilityData()
        
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &myContext {
            
            
            
            
            if myModel.flage == "dataFinished" {
            
            
            
              //  addUtilityTextDependUtility()
                
            }
            
            
        }
    
    }
    

    
    
    
    
    
    
    
    
    // MARK: - Gesturies
    
    func transformUsingRecognizer(_ recognizer: UIGestureRecognizer, transform: CGAffineTransform) -> CGAffineTransform {
        
        if let rotateRecognizer = recognizer as? UIRotationGestureRecognizer {
            
            return transform.rotated(by: rotateRecognizer.rotation / 2)
        }
        
        if let pinchRecognizer = recognizer as? UIPinchGestureRecognizer {
            let scale = pinchRecognizer.scale

            // minim zooming
            
            
         /// set min size of map and max represent to screen size
            
            
        if (myView.map.frame.width < myView.view.frame.width
               && myView.map.frame.height < myView.view.frame.width
            && scale < 1   )
            ||
            (myView.map.frame.width > myView.view.frame.height * 15
            && myView.map.frame.width > myView.view.frame.height * 15
            && scale > 1)
         
        
        {
            
            return myView.map.transform
            }
        else{
             
                return transform.scaledBy(x: scale  , y: scale )
         
            }
            
            
        }
        
        
        //// pan move
        
        if let panRecognizer = recognizer as? UIPanGestureRecognizer {
            let deltaX = panRecognizer.translation(in: myView.map).x
            let deltaY = panRecognizer.translation(in: myView.map).y

            return transform.translatedBy(x: deltaX / 2 , y: deltaY / 2)
        }
        
        return transform
    }
    
    
    
    
    
    
  
    
    
  func processTransform(_ sender: Any) {
        
        let gesture = sender as! UIGestureRecognizer
        
        switch gesture.state {
            
        case .began:
            if gestures.count == 0 {
                // check transform it is avialable of not // get inital tranform from view
                initialTransform = myView.map.transform
            }
            gestures.insert(gesture)
            
        case .changed:
            //add all gustrue to one tranform then apply it 
            if var initial = initialTransform {
                gestures.forEach({ (gesture) in
                    initial = transformUsingRecognizer(gesture, transform: initial)
                    
                })
                myView.map.transform = initial
          
            }
        
            
            
        case .ended:
            if let pinchRecognizer = gesture as? UIPinchGestureRecognizer {
                let scale = pinchRecognizer.scale
                
                
               // addTextOnMap()
               // addUtilityTextDependUtility()
            }
            
            
            if let rotateRecognizer = gesture as? UIRotationGestureRecognizer {
                
                
               // rotateTextLayer(rotateValue: rotateRecognizer.rotation)
            }
            
            gestures.remove(gesture)
            
        default:
            break
        }
    

    
    }
    

    
    
    
    ///to make gusture work with each other on touch
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }

    
    


  /// it was for testing fix string
    
//   /// add text on the map
//    
    func addTextOnMap(){
    
    
        
        
        
        //print("svg file bound W = \(myView.svgFile.bounds.width) , H =  \(myView.svgFile.bounds.height)")
        //print("map view  bound W = \(myView.map.frame.width) , H =  \(myView.map.frame.height)")
        
        
        //print("ratio  W = \(myView.map.frame.width / myView.svgFile.bounds.width) , H =  \(myView.map.frame.height / myView.svgFile.bounds.height)")
        
        //  get ratio between original file and scaled view
        var ratioWidth : CGFloat! = myView.map.frame.width / myView.svgFile.bounds.width
        var ratioHight : CGFloat! = myView.map.frame.height / myView.svgFile.bounds.height
        
        
        
        for item in  myView.map.subviews {
            
            
            item.removeFromSuperview()
            
            
        }
        
        
        
        
        
        for item in  myView.svgFile.paths{
            
            var path = item as! FSSVGPathElement
            
            
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path =  path.path.cgPath
            
            
            
            var textString : String! =  "egypt"
            var fontText : UIFont! = UIFont.init(name: "Helvetica", size: 12)
            
            // find bounds of label
            
            var x = path.path.bounds.minX
            var y = path.path.bounds.midY
            var lWidth = textString.widthOfString(usingFont: fontText)
            var lHight = textString.heightOfString(usingFont: fontText)
            
            var labelText = UILabel()//.init(frame: CGRect.init(x: x, y: y, width: 10, height: 15))
            
         
            labelText.frame = CGRect.init(x: x, y: y, width: lWidth, height: lHight)
            
      
            labelText.restorationIdentifier = path.identifier
            labelText.text = textString
           // labelText.adjustsFontSizeToFitWidth = true
            labelText.textAlignment = .center
            labelText.layer.zPosition = 12
            
            
            
            //check width of path to width of label text
            if ((path.path.bounds.width * ratioWidth ) > labelText.bounds.width * 1.5 ) {
                
                myView.map.addSubview(labelText)
                
                
            }
            
            
            
        }
        
        
    
    
    }
    
    
    

//    
//   /// add text of utility
//    func addUtilityTextDependUtility(){
//        
//   
//        //  get ratio between original file and scaled view
//        var ratioWidth : CGFloat! = myView.map.frame.width / myView.svgFile.bounds.width
//        var ratioHight : CGFloat! = myView.map.frame.height / myView.svgFile.bounds.height
//        
//        
//        /// remove all last text 
//        for item in  myView.map.subviews {
//            
//            
//            item.removeFromSuperview()
//            
//            
//        }
//        
//        
//        
//        //print("svg file path \( myView.svgFile.paths.count)")
//        
//       // print("utility count  file path \( myModel.allUtility.count)")
//        
//        
//        
//        for item in myModel.allUtility{
//            
//            
//           // print("path id  \( item.utility_id)")
//
//            
//            if item.fitRectangle != nil {
//                
//                
//                var path  : FSSVGPathElement! =    item.path
//                
//                
//                
//                
//                if path.identifier != nil {
//                
//                    
//                    let shapeLayer = CAShapeLayer()
//                    shapeLayer.path =  path.path.cgPath
//                    
//                    
//                    
//                
//                    var textString : String! =  item.title != nil ? item.title : ""
//                    var fontText : UIFont! = UIFont.init(name: "Helvetica", size: 12)
//            
//                    var labelText = UILabel()
//  
//                    labelText.font = fontText
//                     var x = path.path.bounds.minX
//                     var y = path.path.bounds.midY
//                
//                    
//                    
//                    
//                    
//                    
//                    var lWidth = textString.widthOfString(usingFont: fontText)
//                    var lHight = textString.heightOfString(usingFont: fontText)
//   
//                    labelText.frame = CGRect.init(x: x, y: y, width: lWidth, height: lHight)
//                    
//                   // print(item.fitRectangle.angle)
//                    
//                    
//                   // labelText.transform = labelText.transform.rotated(by: item.fitRectangle.angle )
//
//                    
//                    labelText.text = textString
//            
//                    labelText.backgroundColor = UIColor.red
//                    labelText.textAlignment = .center
//                    labelText.layer.zPosition = 14
//            
//            
//            
//            
//                    //check width of path to width of label text
//                        if ((item.fitRectangle.width * ratioWidth ) > labelText.bounds.width * 1.5 ) {
//                
//                            myView.map.addSubview(labelText)
//                            //shapeLayer.addSublayer(labelText.layer)
//                
//                        }
//                    }
//            
//            }
//        }
//        
//        
//        
//        
//        
//    }
    
    
    
    
    
    
    
    
    /// add text of utility
    func addUtilityTextDependUtility(){
        
        
        //  get ratio between original file and scaled view
        
        
        
        var ratioWidth : CGFloat! = myView.map.frame.width / myView.svgFile.bounds.width
        var ratioHight : CGFloat! = myView.map.frame.height / myView.svgFile.bounds.height
        
        
        /// remove all last text
        for item in  myView.map.subviews {
            
            
            item.removeFromSuperview()
            
            
        }
        
  
        
        for item in myModel.allUtility{
            
            
            // print("path id  \( item.utility_id)")
            
            
            if item.fitRectangle != nil {
                
                
                var path  : FSSVGPathElement! =    item.path
                
                
                
                
                if path.identifier != nil {
                    
                    
                    let shapeLayer = CAShapeLayer()
                    shapeLayer.path =  path.path.cgPath
                    
                    
                    
                    
                    var textString : String! =  "ragaie"//item.title != nil ? item.title : ""
                    
                    // inizalize font for text  //Chalkboard SE // Helvetica
                    var fontText : UIFont! = UIFont.init(name: "Chalkboard SE", size: 7)
                    
                    // find  (x,y)width and hight of string
                    var lWidth = textString.widthOfString(usingFont: fontText)
                    var lHight = textString.heightOfString(usingFont: fontText)
                    
                    
                    
                    var x = path.path.bounds.midX - (lWidth / 2)
                    var y = path.path.bounds.midY - (lHight / 2)
                    
                    
                    
                    
                    
                    var labelText = UILabel()

                    labelText.font = fontText

                    labelText.frame = CGRect.init(x: x, y: y, width: lWidth, height: lHight)
                  
                    labelText.text = textString
                    
                    //labelText.backgroundColor = UIColor.red
                    labelText.textAlignment = .center
                    labelText.layer.zPosition = 14
                    
                 

                    /// set angle rotation  for text
                    labelText.transform = CGAffineTransform(rotationAngle: 0)
                    if item.fitRectangle.angle > 0 {
                        
                       
                        
                            labelText.transform = CGAffineTransform(rotationAngle: (item.fitRectangle.angle / 2 ) * -1)
                    }
                        
                        
                    else if item.fitRectangle.angle == -90{
                        
                        
                        print(" \(item.title)  angle  small  than 0 = \(item.fitRectangle.angle)")

                     
                        labelText.transform = CGAffineTransform(rotationAngle: (item.fitRectangle.angle  ) / 3)

                        
                        
                    }
                    //check width of path to width of label text
                    
                    if ((item.fitRectangle.width * ratioWidth ) > (labelText.bounds.width * 2.5)  )  && ((item.fitRectangle.hight * ratioWidth ) > (labelText.bounds.height )  ){


                        myView.map.addSubview(labelText)
                        //shapeLayer.addSublayer(labelText.layer)
                        
                    }
                    
                  
                  
                    
                    
                }
                
            }
        }
   
    }
    
    
    
    
    
    
    
    

  
    
    func rotateTextLayer(rotateValue : CGFloat){
        
        
        for item in  myView.map.subviews {
            
            
            
            // if item.isDescendant(of: UILabel())  {
            
            var labelView =   item as! UILabel
            labelView.transform = labelView.transform.rotated(by: rotateValue * -1 )

            //labelView.transform = CGAffineTransform.init(rotationAngle: 10)

        }
        
        
        
    }
    
    func findPathForID(id : Int) -> FSSVGPathElement{
    
        
        
        for item in  myView.svgFile.paths{
            
            
            var path = item as! FSSVGPathElement
            
            
           // print(" id value \(path.identifier) ,\(id) ")

            if path.identifier == "\(id)"{
                //print(" id value \(path.identifier) ,\(id) ")
                return path
            }
        
        }
        
        var path1 : FSSVGPathElement! = FSSVGPathElement()
        
  
        
            return path1
        
    
    }
    
    
    
    
 
   
    
    
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width * 1.4
    }
    
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height * 1.3
    }
}


