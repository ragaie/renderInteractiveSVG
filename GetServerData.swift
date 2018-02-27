



/// start time 2017-05-25 10:33:19 +0000
/// 

import UIKit
import SystemConfiguration


protocol getRemoteData {
    func parseData(result : AnyObject,flagSender :String);
    
}

//

////patrick.emyrey@purplebureau.com
extension getRemoteData {

    
    

    
    func getUrlData(parameter : AnyObject, url : String,way :String,flagSender : String) -> Void{
        
        
        
        
    if isConnectedToNetwork() == true {
            
  
        
        
        // show indecator
       UIApplication.shared.isNetworkActivityIndicatorVisible = true
    

            ShowIndecator(type: "start")

        
  
        
////////////////////////////////////////////
        
            print("----"  + url)
            var resultData : NSString! = ""
        
        
        
           // if parameter as! String != ""
        if parameter.isKind(of: NSDictionary.self){
        
            do{
                let theJSONData = try JSONSerialization.data(withJSONObject: parameter as! NSMutableDictionary ,options:        JSONSerialization.WritingOptions.prettyPrinted)
                resultData = NSString(data: theJSONData,encoding: String.Encoding.utf8.rawValue)
                
                print("-----------------------")
                if resultData != nil {
                        print(resultData)
                }
            }
            catch{
                
                
            }
            }
 
           
   
        
        
        // this is for sendign the devic is in the header 
            
        var headers : [String : String]!
        
        
         headers  = [ "Content-Type": "application/json"]
         
        if UserDefaults.standard.value(forKey: "UserToken") != nil {
            
           // request.setValue(UserDefaults.standard.value(forKey: "UserToken") as! String? , forHTTPHeaderField:"authorization")
            
             headers  = [ "Content-Type": "application/json","authorization":(UserDefaults.standard.value(forKey: "UserToken") as! String?)!]
            
            print(headers)

        }
          
        
        
    if (way == "get") {
            
    
       // print(URL(string: url)!)
        
        
        
        
            
            let request = NSMutableURLRequest(url: URL.init(string: url)!)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        self.sucessToGetData(data: parseJSON as AnyObject,flagSender: flagSender)
                        
                        //let resultValue:String = parseJSON["success"] as! String;
                        //print("result: \(parseJSON)")
                        // print(parseJSON)
                    }
                } catch let error as NSError {
                    
                    self.failGetData()
                    
                    print(error)
                }
            }
            task.resume()
       
        
        
        
        
        
  
        
        

        
    }
        
        
      else if (way == "post") {
        
   
        
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameter, options: []) {
            
            
            let url = NSURL(string:url)!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            
            //Authorization  key for nsuserdeafault UserToken
            if UserDefaults.standard.value(forKey: "UserToken") != nil {
                
                request.setValue(UserDefaults.standard.value(forKey: "UserToken") as! String? , forHTTPHeaderField:"authorization")
                
                
            }
            print(UserDefaults.standard.value(forKey: "UserToken"))
            
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        self.sucessToGetData(data: parseJSON as AnyObject,flagSender: flagSender)
                        
                        //let resultValue:String = parseJSON["success"] as! String;
                        print("result: \(parseJSON)")
                        // print(parseJSON)
                    }
                } catch let error as NSError {
                    
                    self.failGetData()
                    
                    print(error)
                }
            }
            task.resume()
        }
        
        
        
        
        
       
        
        

        
        
        
        
        
        
        
        
        
        
     
        
       
        
        
      }
        
    
 
        
  }
        
    else{
        
        UIAlertView.init(title: "فشل في الاتصال", message: "تفقد الاتصال بالشبكه", delegate: nil, cancelButtonTitle: "غلق").show()
        
        }
    
    
}
    
    
    
    
    func sucessToGetData(data :AnyObject,flagSender:String) -> Void{
        
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        ShowIndecator(type: "stop")

        parseData(result: data,flagSender: flagSender)
        
        
        
        
    }
    
    func ShowIndecator(type : String) -> Void {
        
        var  appdelegate : AppDelegate!
        
        
        if appdelegate == nil {
            appdelegate =  UIApplication.shared.delegate as! AppDelegate
        }
        if SingleClass.indecator == nil {
            
       
                SingleClass.indecator = UIActivityIndicatorView.init(frame:CGRect.init(x: (appdelegate.window!.frame.width / 2) - 30 , y: (appdelegate.window!.frame.height / 2 ) - 30   , width: 60, height: 60))
            
            
            SingleClass.indecator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.init(rawValue: 16)!
            
            
            SingleClass.indecator.color = UIColor.black
            
            

            
            
            
        }
        
        if type == "start"{
            
            UIApplication.shared.keyWindow?.addSubview(SingleClass.indecator)

            
            SingleClass.indecator.startAnimating()

          
            
            
        }else if type == "stop"{
            
            SingleClass.indecator.stopAnimating()
            
            
            
             SingleClass.indecator = nil
        }
        
        
    }
    

    
    
    
    
//    func ShowIndecator(type : String) -> Void {
//        
//        var  appdelegate : AppDelegate!
//        
//        
//        if appdelegate == nil {
//            appdelegate =  UIApplication.shared.delegate as! AppDelegate
//        }
//        if SingleClass.LoaderTemp == nil {
//            
//            SingleClass.LoaderTemp   = UINib(nibName: "Loader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Loader
//            
//            
//            
//            SingleClass.LoaderTemp.frame = CGRect.init(x: (appdelegate.window!.frame.width / 2) - 30 , y: (appdelegate.window!.frame.height / 2 ) - 40   , width: 60, height: 80)
//            
//            //            }
//            
//            
//            
//            UIApplication.shared.keyWindow?.addSubview(SingleClass.LoaderTemp)
//
//            
//        }
//        
//        if type == "start"{
//            
//            
//            UIApplication.shared.keyWindow?.addSubview(SingleClass.LoaderTemp)
//            SingleClass.LoaderTemp.isHidden = false
//
//            //appdelegate.window?.topMostController()?.view.addSubview(SingleClass.indecator)
//            
//            //SingleClass.indecator.hidden = false
//            
//            
//            
//        }else if type == "stop"{
//            
//            SingleClass.LoaderTemp.isHidden = true
//            SingleClass.LoaderTemp.removeFromSuperview()
//            SingleClass.LoaderTemp = nil
//            
//            // SingleClass.indecator.hidden = true
//        }
//        
//        
//    }
//    
    
    
    
    
    func failGetData() -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

        
        ShowIndecator(type: "stop")
        
        UIAlertView.init(title: "connection error", message: "try again later", delegate: nil, cancelButtonTitle: "cancel").show()
        
    
    
        print("fail to get data  ")
    }
    
    
    
    
     func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            /* Only Working for WIFI
             let isReachable = flags == .reachable
             let needsConnection = flags == .connectionRequired
             
             return isReachable && !needsConnection
             */
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
            
        }
    

}


