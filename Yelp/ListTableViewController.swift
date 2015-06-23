
import UIKit


class ListTableViewController: UITableViewController,UITableViewDataSource,UITableViewDelegate {
    
    let kConsumerKey = "1tcROctuu-yJUrOl9_NtSg"
    let kConsumerSecret = "vHASjU5Zk6_f6Ze6sUhBQ-ys8gs"
    let kToken = "Su398qprNpeQBDuvsQmx1B4KpXZv0mJm"
    let kTokenSecret = "cjkq8UquMprYC6l5C1qN9zB5QOw"
    var resturants: [Resturant]?
    var restaurantName:String = ""
    
    func seachForRestaurants() {
        var parameters = [
            // "ll": "43.64286195,-79.4576777",
            
          
            "location": "Toronto",
            "radius_filter":"10000",
            "cc": "CA",
            "term":"cheap_eats",
            
        ]
        
        var yelpClient = YelpClient(consumerKey: kConsumerKey, consumerSecret: kConsumerSecret, accessToken: kToken, accessSecret: kTokenSecret)
        
        yelpClient.searchWithTerm("", parameters: parameters, offset: 0, limit: 20, success: { (results: [Resturant]?) -> Void in
            if let rests = results {
                self.resturants = rests
                self.tableView.reloadData()
                
            }
            })
            { (operation: AFHTTPRequestOperation!,error: NSError!) -> Void in
            
        }
    }
    

  

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        seachForRestaurants()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
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
                detailView.restaurantLabel = rests[selectedRow!].name
                detailView.restaurantAddressString = rests[selectedRow!].address
                detailView.urlDataObject = rests[selectedRow!].imageUrl
                detailView.urlRatingImage = rests[selectedRow!].ratingImageUrl
                detailView.restaurantCategoriesDetail = rests[selectedRow!].categories
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
            
            cell.restaurantName.text = rest.name
            cell.restaurantAddress.text = rest.address
            cell.restaurantCategory.text = rest.categories
            
            cell.restaurantImage.sd_setImageWithURL(NSURL(string: rest.imageUrl))
            cell.restaurantRatingImage.sd_setImageWithURL(NSURL(string: rest.ratingImageUrl))
            
            
            
        }
        // Configure the cell...

        return cell
    }
    

    
    
}
