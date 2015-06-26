
import UIKit


class ListTableViewController: UITableViewController,UITableViewDataSource,UITableViewDelegate {
    
    let kConsumerKey = "1tcROctuu-yJUrOl9_NtSg"
    let kConsumerSecret = "vHASjU5Zk6_f6Ze6sUhBQ-ys8gs"
    let kToken = "Su398qprNpeQBDuvsQmx1B4KpXZv0mJm"
    let kTokenSecret = "cjkq8UquMprYC6l5C1qN9zB5QOw"
    var resturants: [Resturant]?
    var restaurantName:String = ""
    
    var numberOfRestaurantsOffset:Int = 0 //the starting point for restaurants retrived in search starting zero
    var maxNumberOfSearchedRestaurants:Int = 20
    
    var mapViewController: MapViewController!
    
    func didPressMapView(){
        self.navigationController?.pushViewController(self.mapViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapViewController = MapViewController()
        
        // set action then set target to the Map Bar Button
        self.navigationItem.rightBarButtonItem?.action = Selector("didPressMapView")
        self.navigationItem.rightBarButtonItem?.target = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        seachForRestaurants(shouldReload: true, offsetValue: self.numberOfRestaurantsOffset )
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addInfiniteScrollingWithActionHandler { () -> Void in
   
         self.tableView.infiniteScrollingView.stopAnimating()
         self.seachForRestaurants(shouldReload: false, offsetValue: self.resturants!.count )
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let rests = self.resturants {
            return count(rests)
        }
        return 0
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "detailView") {
            // data to pass values too.
            var detailView = segue.destinationViewController as! DetailsViewController
            // access data from DetailViewController
            let selectedRow = self.tableView.indexPathForSelectedRow()?.row
            if let rests = self.resturants {

                detailView.resturant = rests[selectedRow!]
          }
        }
    }

    // animation for cell
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
      let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
       cell.layer.transform = rotationTransform
        UIView.animateWithDuration(1.5, animations: { () -> Void in
          cell.layer.transform = CATransform3DIdentity
    
  })
 }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantListTableViewCell
        if let rests = self.resturants{
            let rest = rests[indexPath.row];
            print(rest)
            
            cell.restaurantName.text = "\(indexPath.row + 1). \(rest.name)"
            
           // cell.restaurantAddress.text = rest.address
            cell.restaurantCategory.text = rest.categories
            
            
            cell.restaurantImage.sd_setImageWithURL(NSURL(string: rest.imageUrl))
            cell.restaurantRatingImage.sd_setImageWithURL(NSURL(string: rest.ratingImageUrl))
            
            cell.restaurantImage.layer.cornerRadius = 5
            cell.restaurantImage.layer.masksToBounds = true
            
            
            
        }
        // Configure the cell...

        return cell
    }
    
    func seachForRestaurants(shouldReload:Bool = true, offsetValue:Int ) {
        var parameters = [
            
            "location": "Toronto",
            "radius_filter":"10000",
            "cc": "CA",
            "term":"cheap_eats",
            
        ]
        
        var yelpClient = YelpClient(consumerKey: kConsumerKey, consumerSecret: kConsumerSecret, accessToken: kToken, accessSecret: kTokenSecret)
        
        yelpClient.searchWithTerm("", parameters: parameters, offset: offsetValue, limit: 20, success: { (results: [Resturant]?) -> Void in
           
            if let rests = results {
                
                if shouldReload{
                    self.resturants = rests
                    self.mapViewController.resturants = rests
                }else {
                    if let originalRests = self.resturants {
                        var newRests = originalRests + rests
                        self.resturants = newRests
                        self.mapViewController.resturants = newRests
                    }
                }
                
                self.tableView.reloadData()
                
            }
            })
            { (operation: AFHTTPRequestOperation!,error: NSError!) -> Void in
                println("failed")
        }
    }
    
    
}
