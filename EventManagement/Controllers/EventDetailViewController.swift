//
//  EventDetailViewController.swift
//  EventManagement
//
//  Created by ur268042 on 5/29/21.
//

import UIKit

@available(iOS 13.0, *)
class EventDetailViewController: UIViewController {
    var eventDetails =  EventInfo()
    var formattedDate: String = ""
    var imgUrl: String = ""
    var isFavouriteButtonClicked = false
    var eventId: String = ""
    let favourieEvents = UserDefaults()
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var favoriteEventButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        //Initialise label texts and image
        titleLabel.text = eventDetails.title
        locationLabel.text = eventDetails.venue.display_location
        timeLabel.text = formattedDate
        eventImageView.loadImageFromURL(url: imgUrl)
        eventImageView.makeRoundCorners(byRadius: 10)
        eventId = String(eventDetails.id)
        if favourieEvents.bool(forKey: eventId) {
            isFavouriteButtonClicked = true
            favoriteEventButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteEventButton.tintColor = .red
        } else {
            favoriteEventButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteEventButton.tintColor = .black
        }
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func onClickOfFavouriteButton(_ sender: Any) {
        isFavouriteButtonClicked = !isFavouriteButtonClicked
        if isFavouriteButtonClicked {
            favourieEvents.setValue(true, forKey: eventId)
            favoriteEventButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteEventButton.tintColor = .red
        } else {
            favourieEvents.removeObject(forKey: eventId)
            favoriteEventButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteEventButton.tintColor = .black
        }
    }
    
    @IBAction func onClickOfBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
