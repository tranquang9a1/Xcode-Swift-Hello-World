//
//  MealTableViewController.swift
//  FirstApplication
//
//  Created by Tran Vinh Quang on 10/27/15.
//  Copyright © 2015 Tran Vinh Quang. All rights reserved.
//

import UIKit

    class MealTableViewController: UITableViewController {
        // MARK: Properties
        
        var meals = [Meal]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.leftBarButtonItem = editButtonItem()
            
            if let savedMeals = loadMeals() {
                meals += savedMeals
            } else {
                loadSampleMeals()
            }

            // Load the sample data.
            loadSampleMeals()
        }
        
        func loadSampleMeals() {
            let photo1 = UIImage(named: "1")
            let meal1 = Meal(name: "Photo 1", photo: photo1, rating: 4)!
            
            let photo2 = UIImage(named: "2")
            let meal2 = Meal(name: "Photo 2", photo: photo2, rating: 2)!
            
            let photo3 = UIImage(named: "3")
            let meal3 = Meal(name: "Photo 3", photo: photo3, rating: 5)!
            
            meals += [meal1, meal2, meal3]
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return meals.count
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            // Table view cells are reused and should be dequeued using a cell identifier.
            let cellIdentifier = "MealTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
            
            // Fetches the appropriate meal for the data source layout.
            let meal = meals[indexPath.row]
            
            cell.nameLabel.text = meal.name
            cell.photoImageView.image = meal.photo
            cell.ratingControl.rating = meal.rating
            print("Da in ra item " + String(indexPath.row))
            return cell
        }
        
        
        // Override to support conditional editing of the table view.
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        }
        
        
        
        // Override to support editing the table view.
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeals()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        }
        
        
        /*
        // Override to support rearranging the table view.
        override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        }
        */
        
        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
        }
        */
        
                // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "ShowDetail" {
                let mealDetailViewController = segue.destinationViewController as! MealViewController
                if let selectedMealCell = sender as? MealTableViewCell {
                    let indexPath = tableView.indexPathForCell(selectedMealCell)!
                    let selectedMeal = meals[indexPath.row]
                    mealDetailViewController.meal = selectedMeal
                }
            } else if segue.identifier == "AddItem" {
                print("Add New Meal...")
            }
        }
        
        
        @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
            if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal{
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    meals[selectedIndexPath.row] = meal
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                } else {
                    let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                    meals.append(meal)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                    
                }
                saveMeals()
            
            }
            
        }
        
        //NSCoding
        
        func saveMeals()  {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
            if !isSuccessfulSave {
                print("Failed to save meal......")
                
            }
        
        }
        
        func loadMeals() -> [Meal]? {
            print(Meal.ArchiveURL.path!)
            return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
        }

    }

