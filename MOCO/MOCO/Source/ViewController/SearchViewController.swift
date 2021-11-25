//
//  SearchViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import UIKit
import CoreLocation

// 글자수 두글자 이상
class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    var searchData: [Search] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var locationManager = CLLocationManager()

    // 여기 이렇게 해줘도 되는지 모르겠음
    var location: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var userCoordinate = CLLocationCoordinate2D() {
        didSet {
            location = CLLocation(latitude: self.userCoordinate.latitude,
                                  longitude: self.userCoordinate.longitude)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        locationManager.delegate = self
        
    }
    
    func configure() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.placeholder = "enter_location".localized()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        self.definesPresentationContext = true
    }
    
    func fetchSearchData(location: CLLocation, query: String) {
        
        SearchAPIManager.shared.fetchData(query: query, longtitude: location.coordinate.longitude, latitude: location.coordinate.latitude) { [weak self] result in
            switch result {
            
            case .success(let searchResults):
                self?.searchData = searchResults
                print(searchResults)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        tableView.separatorStyle = .singleLine
        cell.configureCell(row: searchData[indexPath.row])
        return cell
    }
}

// 글자수 제한
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count >= 2 {
            fetchSearchData(location: location, query: text)
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    
    func checkDeviceLocationAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS14 미만
        }
        
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            checkAppLocationAuthorization(authorizationStatus)
        } else {
            presentLocationAlert(title: "기기 위치 설정 비활성화",
                                 message: "위치 서비스를 위해 설정이 필요합니다.") { [weak self] in
                self?.openSettingURL()
            }
        }
    }
    
    func checkAppLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 디폴트 설정되어있음 옵션
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작 -> didUpdateLocation 실행
        case .restricted, .denied:
            presentLocationAlert(title: "어플 위치 설정 비활성화",
                                 message: "위치 서비스를 위해 설정이 필요합니다.") { [weak self] in
                self?.openSettingURL()
            }
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func checkLocationAccuracy() {
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                break
            case .reducedAccuracy:
                presentLocationAlert(title: "정확한 위치 비활성화",
                                     message: "앱의 정확한 동작을 위해서 설정이 필요할 수 있습니다.") { [weak self] in
                    self?.openSettingURL()
                }
            @unknown default:
                break
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            print("위치 검색 완료")
//            userLongtitude = location.coordinate.longitude
//            userLatitude = location.coordinate.latitude
            userCoordinate = location.coordinate
            print(userCoordinate)
            // Alert if user do not use precise location
            checkLocationAccuracy()
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS14 미만
        }
        
        switch authorizationStatus {
        case .authorizedWhenInUse:
            presentLocationAlert(title: "사용자 위치를 얻는데 실패했습니다.",
                                 message: "위치를 얻으려면 다시 시도해주세요.",
                                 settingTitle: "다시 시도") { [weak self] in
                self?.locationManager.startUpdatingLocation()
            }
        case .notDetermined:
            locationManager.startUpdatingLocation() // 위치 접근 시작
        case .restricted, .denied:
            presentLocationAlert(title: "어플 위치 설정 비활성화",
                                 message: "위치 서비스를 위해 설정이 필요합니다.") { [weak self] in
                self?.openSettingURL()
            }
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    // 6. iOS 14 미만: 앱이 위치 관리자를 생성, 승인 상태가 변경이 될 때 대리자에게 승인상태 알려줌
    // 권한이 변경 될 때 마다 감지해서 실행됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkDeviceLocationAuthorization()
    }
    
    // 7. iOS 14 이상: 앱이 위치 관리자를 생성, 승인 상태가 변경이 될 때 대리자에게 승인상태 알려줌
    // 권한이 변경 될 때 마다 감지해서 실행됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
}
