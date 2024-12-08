//
//  viewController.swift
//  Mobile Apps Project
//
//  Created by Joseph Charuhas on 10/18/24.
//


import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController
{
    
    var ResaurauntArray = [Restauraunt]();
    var favoritesArray: [String] = [];
    var curRestauraunt = Restauraunt();
    var restCounter = 0;
    var ratings: [Int] = [3, 4, 5];
    
    
    @IBOutlet weak var favRestLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var txtbox: UITextView!
    @IBOutlet weak var siteBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var dishLbl: UILabel!
        
    var mySoundFile: AVAudioPlayer!

    
    @IBAction func nextRest(_ sender: Any)
    {
        setLabels()
        //print(restCounter)
    }
    
    
    @IBAction func visitSite(_ sender: Any)
    {
        //let browserApp = UIApplication.shared
        
        //let url = URL(string: curRestauraunt.rWebSite)
            
        //browserApp.open(url!)
        
        print("button tapped")
        
        performSegue(withIdentifier: "showDetailsSegue", sender: self)
    }
    
    
    @IBAction func setFav(_ sender: Any)
    {
        favoritesArray.append(curRestauraunt.rName)
        //print(curRestauraunt.rName);
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetailsSegue"
        {
            let destinationController = segue.destination as! (SubViewController)
            destinationController.subDetailRest = curRestauraunt
        }
    }
    
    
    func setLabels()
    {
        if(restCounter >= (ResaurauntArray.count))
        {
            let lbl = (String)("Favorite Restaurants: \n" + favoritesArray.joined(separator: "\n"))
            favRestLbl.text = lbl;
            //print("Favorite Restaurants: \n" + favoritesArray.joined(separator: "\n"))
            nameLbl.text = ""
            ratingLbl.text = ""
            dishLbl.text = ""
            addressLbl.text = ""
            siteBtn.setTitle("", for: .normal)
            
            imgBackground.image = UIImage(named: "")
            
            restCounter = 0;
        }
        else
        {
            siteBtn.setTitle("Visit Site", for: .normal)
            favRestLbl.text = " ";
            curRestauraunt = ResaurauntArray[restCounter]
            nameLbl.text = curRestauraunt.rName
            ratingLbl.text = String(curRestauraunt.rRating) + " Stars"
            dishLbl.text = curRestauraunt.rSignatureDish
            addressLbl.text = curRestauraunt.rAddress
            
            imgBackground.image = UIImage(named: curRestauraunt.rImage)
            
            /*
             imgBackground.layer.cornerRadius = 15;
             imgBackground.layer.borderColor = UIColor.darkGray.cgColor;
             imgBackground.layer.borderWidth = 2;
             imgBackground.contentMode  = .scaleAspectFill;
             */
            restCounter = restCounter + 1

        }
    }
    
    
    func InitilizeData()
    {
        let r1 = Restauraunt(rName: "Colada Shop", rRating: ratings.randomElement()!, rAddress: "244 19th Ct S #35, Arlington, VA 22202", rImage: "colada.jpg", rSignatureDish: "Cuban Sandwich", rWebSite: "https://www.coladashop.com/locations?y_source=1_MTA3NzkzMDk5Ni03MTUtbG9jYXRpb24ud2Vic2l0ZQ%3D%3D");
        
        ResaurauntArray.append(r1)
        
        let r2 = Restauraunt(rName: "Tatte Bakery & Cafe", rRating: ratings.randomElement()!, rAddress: "2805 Clarendon Blvd, Arlington, VA 22201", rImage: "tatte.jpg", rSignatureDish: "Baked Goods", rWebSite: "https://tattebakery.com/menus/");
        
        ResaurauntArray.append(r2)
        
        let r3 = Restauraunt(rName: "Chipotle Mexican Grill", rRating: ratings.randomElement()!, rAddress: "158 National Plaza B1-4/B1-5, Oxon Hill, MD 20745", rImage: "chipotle.jpg", rSignatureDish: "Bowl", rWebSite: "https://www.coladashop.com/locations?y_source=1_MTA3NzkzMDk5Ni03MTUtbG9jYXRpb24ud2Vic2l0ZQ%3D%3D");
        
        ResaurauntArray.append(r3)
        
        let r4 = Restauraunt(rName: "Taco Bamba", rRating: ratings.randomElement()!, rAddress: "4000 Wilson Blvd Suite C, Arlington, VA 22203", rImage: "Taco Bamba.jpg", rSignatureDish: "Tacos", rWebSite: "https://www.tacobamba.com/");
        
        ResaurauntArray.append(r4)
        
        let r5 = Restauraunt(rName: "Jula's on the Potomac", rRating: ratings.randomElement()!, rAddress: "44 Canal Center Plaza #401, Alexandria, VA 22314", rImage: "julas.png", rSignatureDish: "Pizza", rWebSite: "https://julasotp.com/");
        
        ResaurauntArray.append(r5)
        

        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GetAPIJSONData()
        //InitilizeData()
        setLabels()
        let soundUrl = URL(fileURLWithPath: Bundle.main.path(forResource:"Order-up-bell-sound", ofType:"mp3")!)
        mySoundFile = try? AVAudioPlayer(contentsOf: soundUrl)
        // Do any additional setup after loading the view.
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        favoritesArray.removeAll()
        favRestLbl.text = "Favorite Restaurants:";
        UIView.animate(withDuration: 0.3, animations:{ self.favBtn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) })
        {
            _ in UIView.animate(withDuration: 0.3)
            {
                self.favBtn.transform = CGAffineTransform.identity
            }
        }
        
        mySoundFile.play()

    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        
        UIView.animate(withDuration: 3, animations:
        {
            self.favBtn.alpha = 1
        })
        
    }
    
    
    func GetAPIJSONData()
    {
        let endPointURL = URL(string: "https://raw.githubusercontent.com/jcharuha/MobileAppRestData/master/RestList.json")
        
        let dataBytes = try? Data(contentsOf: endPointURL!)
        
        
        print("Received DataBytes --:  \(dataBytes!) ----- \n")
        
        if(dataBytes != nil)
        {
            
            let dictionary:NSDictionary = (try? JSONSerialization.jsonObject(with: dataBytes!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print("Received Dictionary --:  \(dictionary) ----- \n")
            if let restaurantArray = dictionary["restaurants"] as? [[String: AnyObject]]
            {
            for restaurantData in restaurantArray
                {
                    let restaurant = Restauraunt(
                        rName: restaurantData["rName"] as! String,
                        rRating: restaurantData["rRating"] as! Int,
                        rAddress: restaurantData["rAddress"] as! String,
                        rImage: restaurantData["rImage"] as! String,
                        rSignatureDish: restaurantData["rSignatureDish"] as! String,
                        rWebSite: restaurantData["rWebSite"] as! String
                    )
                    ResaurauntArray.append(restaurant)
                }
            }
        }
        else
        {
           print ("Couldnt receive data from Remote Source. JSON is nil. Check the URL")
        }
        
        
    }



}

