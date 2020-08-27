import UIKit
import Gimbal

class ViewController: UITableViewController, PlaceManagerDelegate, CommunicationManagerDelegate {
    
    var placeManager: PlaceManager!
    var communicationManager: CommunicationManager!
    var placeEvents : [Visit] = []

    override func viewDidLoad() -> Void {
        placeManager = PlaceManager()
        self.placeManager.delegate = self
        
        communicationManager = CommunicationManager()
        self.communicationManager.delegate = self
        
        Gimbal.start()
    }
    
    func placeManager(_ manager: PlaceManager, didBegin visit: Visit) -> Void {
        print("Begin %@", visit.place.description)
        self.placeEvents.insert(visit, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with:UITableView.RowAnimation.automatic)

    }
    
    func placeManager(_ manager: PlaceManager, didEnd visit: Visit) -> Void {
        NSLog("End %@", visit.place.description)
        self.placeEvents.insert(visit, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    func communicationManager(_ manager: CommunicationManager, presentLocalNotificationsFor communications: [Communication], for visit: Visit) -> [Communication]? {
        return communications
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: NSInteger) -> NSInteger {
        return self.placeEvents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let visit: Visit = self.placeEvents[indexPath.row]
        
        if (visit.departureDate == nil) {
            cell.textLabel!.text = NSString(format: "Begin: %@", visit.place.name) as String
            cell.detailTextLabel!.text = DateFormatter.localizedString(from: visit.arrivalDate,
                                                                       dateStyle: DateFormatter.Style.short,
                                                                       timeStyle: DateFormatter.Style.medium)
        } else if let departureDate = visit.departureDate  {
            cell.textLabel!.text = NSString(format: "End: %@", visit.place.name) as String
            cell.detailTextLabel!.text = DateFormatter.localizedString(from: departureDate,
                                                                       dateStyle: DateFormatter.Style.short,
                                                                       timeStyle: DateFormatter.Style.medium)
        }
        
        return cell
    }
}

