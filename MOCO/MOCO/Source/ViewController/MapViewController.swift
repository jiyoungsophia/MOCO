//
//  MapViewController.swift
//  MOCO
//
//  Created by 지영 on 2021/11/18.
//

import UIKit
import CoreLocation
import CoreLocationUI
import NMapsMap
import CoreMIDI
import CoreAudio


// TODO: 프로그레스바!!!

class MapViewController: UIViewController {
    func sendYearMonth(year: Int, month: Int) {
        dateList = [year, month]
        print("MAP: \(dateList)")
    }
    
    static let identifier = "MapViewController"
    
    @IBOutlet weak var mapView: NMFMapView!
    @IBOutlet weak var locationButton: NMFLocationButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    // 여기 이렇게 해줘도 되는지 모르겠음
    var location: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var userCoordinate = CLLocationCoordinate2D() {
        didSet {
            location = CLLocation(latitude: self.userCoordinate.latitude,
                                  longitude: self.userCoordinate.longitude)
            
        }
    }
    
    let current = InputManager.shared.dateToYearMonth(date: Date())
    
    var placeData: [Place] = []
    var dateList: [Int] = [] {
        didSet {
            loadOfflineExpense()
        }
    }
    
    var offlineExpense: [Expense] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var markers: [NMFMarker] = []

    let markDefault = NMFOverlayImage(name: "pmarker")
    let markFocus = NMFOverlayImage(name: "pomarker")
    
    
    let DEFAULT_CAMERA_POSITION = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.56645675932999, lng: 126.97798801299875))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfig()
        locationManager.delegate = self
        
        dateList = current
        
        NotificationCenter.default.addObserver(self, selector: #selector(dateNoti(noti:)), name: .dateNotification, object: nil)
        
        locationButton.mapView = mapView
        mapView.positionMode = .direction
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .dateNotification, object: nil)
    }
    
    @objc func dateNoti(noti: NSNotification) {
        if let year = noti.userInfo?["year"] as? Int,
           let month = noti.userInfo?["month"] as? Int {
            dateList[0] = year
            dateList[1] = month
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadOfflineExpense()
        
        //        let marker = NMFMarker()
        //        marker.position = NMGLatLng(from: userCoordinate)
        //        marker.iconImage = markDefault
        //        marker.mapView = mapView
        
        
    }
    
    
    func loadOfflineExpense() {
        offlineExpense = RealmManager.shared.loadOfflineExpense(year: dateList[0], month: dateList[1])
        placeData = RealmManager.shared.loadPlaceData
//        for item in offlineExpense {
//            placeData = RealmManager.shared.loadPlace(id: item.placeId ?? 0 )
//        }
//        self.offlineExpense.forEach { expense in
//            placeData = RealmManager.shared.loadPlace(id: expense.placeId ?? 0)
//        }
//        print(placeData)
        
        //        let marker = NMFMarker(position: NMGLatLng(lat: placeData.last?.latitude ?? 0, lng: placeData.last?.longtitude ?? 0))
        //        marker.iconImage = markDefault
        //        marker.mapView = mapView
        
        
//
//        self.placeData.forEach { place in
//            let marker = NMFMarker(position: NMGLatLng(lat: place.latitude, lng: place.longtitude))
//            marker.iconImage = self.markDefault
//            //                marker.userInfo = ["id": place.placeId]
//            //            marker.touchHandler = { (marker) -> Bool in
//            //                print(marker.userInfo["id"])
//            //                return true
//            //            }
//            print(place)
//            markers.append(marker)
//        }
//
//            for marker in markers {
//                marker.mapView = self.mapView
//
//        }
        
        
        
        
        
        
        //        self.markers.append(marker)
        //        placeData.forEach { place in
        //            let marker = NMFMarker(position: NMGLatLng(lat: place.latitude, lng: place.longtitude))
        //            marker.iconImage = NMF_MARKER_IMAGE_BLACK
        //            marker.iconTintColor = UIColor.red
        //            marker.touchHandler = { (marker) -> Bool in
        //                print("touch")
        //                return true
        //            }
        //            self.markers.append(marker)
        //        }
        //
        //        DispatchQueue.main.async {
        //            self.markers.forEach { marker in
        //                marker.mapView = self.mapView
        //                print("마커디스패치큐")
        //            }
        //        }
        
    }
    
    //    func makeMarkers() {
    //        self.markers.removeAll()
    //        let marker = NMFMarker(position: NMGLatLng(lat: placeData[0].latitude, lng: placeData[0].longtitude))
    //        marker.iconImage = markDefault
    //        marker.touchHandler = { (marker) -> Bool in
    //            print("touch")
    //            return true
    //        }
    //        markers.append(marker)
    //    }
    
    
    
    func collectionViewConfig() {
        let nibName = UINib(nibName: ExpenseCell.identifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: ExpenseCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setMapDefaultLocation() {
        mapView.moveCamera(DEFAULT_CAMERA_POSITION, completion: nil)
    }
    
    
    
    
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offlineExpense.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCell.identifier, for: indexPath) as? ExpenseCell else {
            return UICollectionViewCell()
        }
        let item = offlineExpense[indexPath.item]
        placeData = RealmManager.shared.loadPlace(id: item.placeId ?? 0)
//        cell.configureCell(item: item, place: placeData[0])
//        placeData.filter {
//            $0.placeId == item.placeId ?? 0
//        }
//        for place in placeData {
//            print(place)
//        }
        
        for id in offlineExpense {
            placeData
        }
        
        //TODO: item 없으면 toast??
//        print(placeData)
        
        
        
        
        
        
        return cell
    }
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 28
        let width = UIScreen.main.bounds.width - (spacing * 2)
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
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
            setMapDefaultLocation()
            presentAlert(title: "기기 위치 설정 비활성화",
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
            setMapDefaultLocation()
            presentAlert(title: "어플 위치 설정 비활성화",
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
                presentAlert(title: "정확한 위치 비활성화",
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
            userCoordinate = location.coordinate
            // 카메라 현재위치로 옮기기
            mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(from: userCoordinate)), completion: nil)
            
            
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
            setMapDefaultLocation()
            presentAlert(title: "사용자 위치를 얻는데 실패했습니다.",
                         message: "위치를 얻으려면 다시 시도해주세요.",
                         okTitle: "다시 시도") { [weak self] in
                self?.locationManager.startUpdatingLocation()
            }
        case .notDetermined:
            locationManager.startUpdatingLocation() // 위치 접근 시작
        case .restricted, .denied:
            setMapDefaultLocation()
            presentAlert(title: "어플 위치 설정 비활성화",
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
