//
//  EventsViewController..swift
//  EventManagement
//
//  Created by ur268042 on 5/29/21.
//

import UIKit

class EventsViewController: UIViewController {
    var imgUrl: String = ""
    var events =  [EventInfo]()
    var filteredEvents = [EventInfo]()
    var request = APIRequest()
    let loadingView = UIView()
    let indicator = UIActivityIndicatorView()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet var searchView: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView.tableFooterView = UIView()
        setIndicatorView()
        fetchEvents()
        setupTableView()
        setupSearchView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.eventsTableView.reloadData()
    }
    
    func fetchEvents() {
        request.getEvents { [weak self] (response, error)  in
            if response.count > 0  && error == nil{
                self?.events = response
            } else {
                print(error ?? "Error Fetching Data")
            }
            DispatchQueue.main.async {
                self?.eventsTableView.reloadData()
                self?.removeLoadingScreen()
            }
        }
    }
    
    func setupSearchView() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search events"
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false

        navigationItem.titleView = searchController.searchBar
    }
    
    func setupTableView() {
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }
    
    private func setIndicatorView() {

        // Sets the view which contains the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (eventsTableView.frame.width / 2) - (width / 2)
        let y = (eventsTableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)

        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.frame = CGRect(x: 20, y: 0, width: 70, height: 70)
        indicator.startAnimating()

        loadingView.addSubview(indicator)
        eventsTableView.addSubview(loadingView)
    }
    private func removeLoadingScreen() {
        indicator.stopAnimating()
        indicator.isHidden = true
      }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchController.isActive ? filteredEvents.count : events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventsTableViewCell
        let event = searchController.isActive ?
                            filteredEvents[indexPath.row] : events[indexPath.row]
        if UserDefaults.standard.bool(forKey: String(event.id)) {
            cell.favIcon.isHidden = false
        } else {
            cell.favIcon.isHidden = true
        }
        cell.titleLabelText.text = event.title
        cell.locationLabelText.text = event.venue.display_location
        cell.timeLabelText.text = formatDate(dateString: event.datetime_local)
        cell.img?.loadImageFromURL(url: event.performers[0].image)
        cell.img?.makeRoundCorners(byRadius: 10)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "EventDetailViewController") as? EventDetailViewController {
            vc.eventDetails = events[indexPath.row]
            vc.formattedDate = formatDate(dateString: events[indexPath.row].datetime_local)
            vc.imgUrl = events[indexPath.row].performers[0].image
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func formatDate(dateString: String) -> String {
        let concatDateString = dateString + ".000Z"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: concatDateString){
        dateFormatter.dateFormat = "EEEE, d MMM yyyy hh:mm a"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }
        return ""
    }

}

extension EventsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredEvents = []
        if searchText == "" {
            filteredEvents = events
        } else  {
            for event in events {
                if event.type.lowercased().contains(searchText.lowercased()) {
                    filteredEvents.append(event)
                }
            }
        }
        eventsTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        searchController.isActive = false
        eventsTableView.reloadData()
    }
}
