
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
    
    //What we want to do when we get to the bottom of the list is RELOAD the data and then increase the variable numberOfRestaurantsOffset with maxNumberOfSearchedRestaurants soooooooo something like
    //numberOfRestaurantsOffset + = maxNumberOfSearchedRestaurants
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        seachForRestaurants(shouldReload: true, offsetValue: self.numberOfRestaurantsOffset )
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.delegate = self
        tableView.dataSource = self
        
    tableView.addInfiniteScrollingWithActionHandler { () -> Void in
           //return resturants?.count\
//            println("load my data" )
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
//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//       
//       let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//       cell.layer.transform = rotationTransform
//        UIView.animateWithDuration(0.8, animations: { () -> Void in
//          cell.layer.transform = CATransform3DIdentity
//            
//    })
//  }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantListTableViewCell
        if let rests = self.resturants{
            let rest = rests[indexPath.row];
            print(rest)
            
            cell.restaurantName.text = "\(indexPath.row + 1). \(rest.name)"//rest.name
            
            cell.restaurantAddress.text = rest.address
            cell.restaurantCategory.text = rest.categories
            
            
            cell.restaurantImage.sd_setImageWithURL(NSURL(string: rest.imageUrl))
            cell.restaurantRatingImage.sd_setImageWithURL(NSURL(string: rest.ratingImageUrl))
            
            
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
                }else {
                    if let originalRests = self.resturants {
                        var newRests = originalRests + rests
                        self.resturants = newRests
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
