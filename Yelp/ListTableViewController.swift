
import UIKit


class ListTableViewController: UITableViewController,UITableViewDataSource,UITableViewDelegate {
    
    let kConsumerKey = "1tcROctuu-yJUrOl9_NtSg"
    let kConsumerSecret = "vHASjU5Zk6_f6Ze6sUhBQ-ys8gs"
    let kToken = "Su398qprNpeQBDuvsQmx1B4KpXZv0mJm"
    let kTokenSecret = "cjkq8UquMprYC6l5C1qN9zB5QOw"
    var resturants: [Resturant]?
    
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
            }) { (operation: AFHTTPRequestOperation!,error: NSError!) -> Void in
            
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantListTableViewCell
        if let rests = self.resturants{
            let rest = rests[indexPath.row];
            cell.restaurantImage.sd_setImageWithURL(NSURL(string: rest.imageUrl))
            cell.restaurantName.text = rest.name
            cell.restaurantRatingImage.sd_setImageWithURL(NSURL(string: rest.ratingImageUrl))
            cell.restaurantAddress.text = rest.address
            cell.restaurantCategory.text = rest.categories
            
        }
        // Configure the cell...

        return cell
    }
}
