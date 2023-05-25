//
//  ContentView.swift
//  AthenianMaps
//
//  Created by Tavi Greenfield on 5/15/23.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

let mapView = MKMapView(frame: UIScreen.main.bounds)

struct MapView: UIViewRepresentable {
  func makeUIView(context: Context) -> MKMapView {
    

      let span = MKCoordinateSpan(latitudeDelta: 0.0045, longitudeDelta: 0.0045)
      let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.834, longitude: -121.9496), span: span)

    mapView.region = region
    mapView.delegate = context.coordinator
      
      mapView.mapType = .satellite
    
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  // Acts as the MapView delegate
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
      var color = 0
    

    init(_ parent: MapView) {
      self.parent = parent
    }

      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if overlay is MKPolyline {
        let lineView = MKPolylineRenderer(overlay: overlay)
          
          lineView.strokeColor = .orange
          
        lineView.lineWidth = 5
        return lineView
      } else if overlay is MKPolygon {
        let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.strokeColor = .orange
        return polygonView
      } else if overlay is MKCircle {
          let circleView = MKCircleRenderer(overlay: overlay)
          circleView.strokeColor = .orange
          circleView.lineWidth = 5
            return circleView
    
      }

      return MKOverlayRenderer()
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
      annotationView.canShowCallout = true
      return annotationView
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}


struct ContentView: View {
    var locationManager = LocationManager()
    @State var mapBoundary = false
    @State var mapOverlay = false
    @State var mapPins = false
    @State var mapCharacterLocation = false
    @State var mapRoute = false
    @State var distance = ""
    @State var time = ""
    @State var ETA = ""
    var graph = DijkstraGraph()
    @State var path: DijkstraGraph.Path? = nil
    @State var destination = ""
    @State var location = ""
    let locationLabels = ["Appletree","Baseball Field", "C.I.S.","C.F.T.A.","Commons","Courtside","Creekside","Dase Center/MPR","Gym","House 2","House 3","House 9","Knoll 1-4","Knoll 5-8","Knoll 9/10","Library","Main Hall","Middlefield","Middle School", "Orchard","Parking Lot","Reinhardt","Ridgeview","Science Classrooms","Soccer Field","Student Store", "Weight Room"]
    let locationDict = [
        "Parking Lot": ["North", "South"],
        "Reinhardt": ["North", "South"],
        "Main Hall": ["North", "South", "East"],
        "Commons": ["North", "South"],
        "Courtside": ["North", "South"],
        "Library": ["West", "East"]
    ]


    var body: some View {
      VStack {
          Spacer()
          HStack{
              Spacer()
              Text("Flight").fontWeight(.bold)
                  .font(.title).foregroundColor(.orange)
              + Text("Path").fontWeight(.bold)
                .font(.title).foregroundColor(.white)
              Spacer()
          }
          
          MapView().cornerRadius(20).padding(10).background(Color.orange).cornerRadius(30).padding(7)
          HStack{
              Button(action:{
                  updateLocation()
              }, label: {Image(systemName: "location").foregroundColor(.orange)})
              Picker("Select current location", selection: $location) {
                  Text("Location")
                  ForEach(locationLabels, id: \.self) {
                        Text($0)
                    }
              }.background(Color.orange).accentColor(Color.white).cornerRadius(10).padding(10).pickerStyle(.menu)
                  .onChange(of: location) { location in
                      
                          updateRoute() }
              Picker("Select destination", selection: $destination) {
                  Text("Destination")
                  ForEach(locationLabels, id: \.self) {
                        Text($0)
                  }
              }.background(Color.orange).accentColor(Color.white).cornerRadius(10).padding(10).pickerStyle(.menu)
                  .onChange(of: destination) { destination in
                      updateRoute() }
                  
                  

          }
          HStack{
              Spacer()
              Text(ETA).font(.title3).fontWeight(.bold).foregroundColor(Color.orange).padding()
              Spacer()
              Text(time).font(.title3).fontWeight(.bold).foregroundColor(Color.orange).padding()
              Spacer()
              Text(distance).font(.title3).fontWeight(.bold).foregroundColor(Color.orange).padding().padding()
              Spacer()
          }
          Spacer()
          HStack{
              Spacer()
              Text("developer@unmatch.xyz").accentColor(.orange).font(.custom("Arial", size: 8.0)).padding()
              Spacer()
              Text("By Tavi Greenfield '23").foregroundColor(.orange).font(.custom("Arial", size: 8.0)).padding()
              Spacer()
              Link("Privacy Policy",
                   destination: URL(string: "https://www.termsfeed.com/live/2e67cb15-2cff-4fb6-8ad9-e88a5bcf3a64")!).font(.custom("Arial", size: 8.0)).accentColor(.orange).padding()
              Spacer()
          }
          
          


      }.background(Color.black.edgesIgnoringSafeArea(.all))
      
    }
     
    func updateLocation(){
        print("location updated")
        let currentLocation = locationManager.location
        if currentLocation != nil{
//            let currentLocation = locationManager.location
            mapView.removeOverlays(mapView.overlays)
            let circle3 = MKCircle(center: locationManager.location!, radius: 2)
            mapView.addOverlay(circle3)
            
//
            var min = Int.max
            var closest = ""
            for label in locationLabels{
                if locationDict[label] == nil{
                    let vertex = graph.vertices[graph.vertexID[label]!]
                    if CLLocation.distance(from: vertex!.coords, to: currentLocation!) < Double(min) {
                        min = Int(CLLocation.distance(from: vertex!.coords, to: currentLocation!))
                        closest = label
                    }
                }else{
                    for ext in locationDict[label]!{
                        let vertex = graph.vertices[graph.vertexID[label + " " + ext]!]
                        if CLLocation.distance(from: vertex!.coords, to: currentLocation!) < Double(min) {
                            min = Int(CLLocation.distance(from: vertex!.coords, to: currentLocation!))
                            closest = label
                        }
                    }
                }
                
                
            }
            print(closest)
            self.location = closest
            updateRoute()
        }
    }
    func updateRoute(){
        mapView.removeOverlays(mapView.overlays)
        
//        if locationManager.location != nil{
//            print(locationManager.location)
//            let circle = MKCircle(center: locationManager.location!, radius: 3)
//            mapView.addOverlay(circle)
//        }else{
//            print("nil")
//        }
        
        
        
        if (locationLabels.contains(location) && locationLabels.contains(destination) && location != destination){
            if (locationDict[location]==nil && locationDict[destination]==nil){
                path = graph.aStar(source: graph.vertexID[location]!, target: graph.vertexID[destination]!)
               
            }else if (!(locationDict[location] == nil) && locationDict[destination]==nil){
                path = graph.aStar(source: graph.vertexID[location + " " +  locationDict[location]![0]]!, target: graph.vertexID[destination]!)
                var weight = path?.weight
                for locExt in locationDict[location]!{
                    let tempPath = graph.aStar(source: graph.vertexID[location + " " +  locExt]!, target: graph.vertexID[destination]!)
                    if tempPath.weight < weight!{
                        weight = tempPath.weight
                        path = tempPath
                    }
                }
            }
            else if ((locationDict[location] == nil) && !(locationDict[destination]==nil)){
                path = graph.aStar(source: graph.vertexID[location]!, target: graph.vertexID[destination + " " +  locationDict[destination]![0]]!)
                var weight = path?.weight
                for desExt in locationDict[destination]!{
                    let tempPath = graph.aStar(source: graph.vertexID[location]!, target: graph.vertexID[destination + " " +  desExt]!)
                    if tempPath.weight < weight!{
                        weight = tempPath.weight
                        path = tempPath
                    }
                }
            }
            else{
                path = graph.aStar(source: graph.vertexID[location + " " +  locationDict[location]![0]]!, target: graph.vertexID[destination + " " +  locationDict[destination]![0]]!)
                var weight = path?.weight
                for locExt in locationDict[location]!{
                    for desExt in locationDict[destination]!{
                        let tempPath = graph.aStar(source: graph.vertexID[location + " " +  locExt]!, target: graph.vertexID[destination + " " +  desExt]!)
                        if tempPath.weight < weight!{
                            weight = tempPath.weight
                            path = tempPath
                        }
                    }
                }
                
            }
            addRoute()
            distance = String(path!.weight) + " ft"
            
            let today = Date()
            
            var chours   = (Calendar.current.component(.hour, from: today))
            var cminutes = (Calendar.current.component(.minute, from: today))
            var cseconds = (Calendar.current.component(.second, from: today))
            
            
            
            let seconds = Double(path!.weight)/4.7
            let minutes = seconds/60
            
            let roundedMinutes = floor(minutes)
            let roundedSeconds = round(seconds)-(roundedMinutes*60)
            if roundedMinutes == 0.0{
                time = String(Int(roundedSeconds)) + " sec "
            }
            else if roundedSeconds == 0.0{
                time =  String(Int(roundedMinutes)) + " min "
            }
            else{
                time =  String(Int(roundedMinutes)) + " min " + String(Int(roundedSeconds)) + " sec "
            }
            
            cseconds += Int(roundedSeconds)
            if (cseconds >= 60){
                cseconds -= 60
                cminutes += 1
            }
            cminutes += Int(roundedMinutes)
            if cminutes >= 60{
                cminutes -= 60
                chours += 1
            }
            print(chours)
            if chours > 12{
                chours -= 12
            }
            if chours == 0 {
                chours += 12
            }
            ETA = "\(chours):\(cminutes)"
        }
        else if location == destination{
            time = "0 sec"
            distance = "0 ft"
        }
        
    }

//    func addOverlay() {
//      let overlay = ParkMapOverlay(park: park)
//      mapView.addOverlay(overlay)
//    }
//
//    func addAttractionPins() {
//      // 1
//      guard let attractions = Park.plist("MagicMountainAttractions") as? [[String: String]] else { return }
//
//      // 2
//      for attraction in attractions {
//        let coordinate = Park.parseCoord(dict: attraction, fieldName: "location")
//        let title = attraction["name"] ?? ""
//        let typeRawValue = Int(attraction["type"] ?? "0") ?? 0
//        let type = AttractionType(rawValue: typeRawValue) ?? .misc
//        let subtitle = attraction["subtitle"] ?? ""
//        // 3
//        let annotation = AttractionAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
//        mapView.addAnnotation(annotation)
//      }
//    }
//
    func addRoute() {
        

      print("route added")
        var coordList:[CLLocationCoordinate2D] = []
        coordList.append(path!.path[0].source.coords)
        
        for edge in path!.path{
            coordList.append( edge.destination.coords)
        }
        let myPolyline = MKPolyline(coordinates: coordList, count: coordList.count)
    
        let circle = MKCircle(center: coordList[coordList.count-1], radius: 3)
        let circle2 = MKCircle(center: coordList[0], radius: 1)

      mapView.addOverlay(myPolyline)
        mapView.addOverlay(circle)
        mapView.addOverlay(circle2)
        
        
    }

//    func addCharacterLocation() {
//      mapView.addOverlay(Character(filename: "BatmanLocations", color: .blue))
//      mapView.addOverlay(Character(filename: "TazLocations", color: .orange))
//      mapView.addOverlay(Character(filename: "TweetyBirdLocations", color: .yellow))
//    }
//
    func updateMapOverlayViews() {
      mapView.removeAnnotations(mapView.annotations)
      mapView.removeOverlays(mapView.overlays)

//      if mapBoundary { addBoundary() }
//      if mapOverlay { addOverlay() }
//      if mapPins { addAttractionPins() }
//      if mapCharacterLocation { addCharacterLocation() }
      if mapRoute { addRoute() }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
