//
//  ContentView.swift
//  AthenianMaps
//
//  Created by Tavi Greenfield on 5/15/23.
//

import SwiftUI
import MapKit

let mapView = MKMapView(frame: UIScreen.main.bounds)

struct MapView: UIViewRepresentable {
  func makeUIView(context: Context) -> MKMapView {
    

    let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
      let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.834, longitude: -121.9496), span: span)

    mapView.region = region
    mapView.delegate = context.coordinator

    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  // Acts as the MapView delegate
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
      self.parent = parent
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if overlay is MapOverlay {
        return MapOverlayView(
          overlay: overlay,
          overlayImage: UIImage(imageLiteralResourceName: "overlay_park"))
      } else if overlay is MKPolyline {
        let lineView = MKPolylineRenderer(overlay: overlay)
        lineView.strokeColor = .green
        lineView.lineWidth = 3
        return lineView
      } else if overlay is MKPolygon {
        let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.strokeColor = .magenta
        return polygonView
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
    
    @State var mapBoundary = false
    @State var mapOverlay = false
    @State var mapPins = false
    @State var mapCharacterLocation = false
    @State var mapRoute = false

    var body: some View {
      VStack {
          Text("Athenian Maps").fontWeight(.bold)
              .font(.title)
          MapView().cornerRadius(20).padding(15)
          Button("Show Route"){
              print("button tapped")
              addRoute()
          }
          


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
        let coords = [CLLocationCoordinate2D(latitude: 37.83415, longitude: -121.95068),CLLocationCoordinate2D(latitude: 37.83510, longitude: -121.94929)]
        let myPolyline = MKPolyline(coordinates: coords, count: coords.count)

      mapView.addOverlay(myPolyline)
    }
//
//    func addBoundary() {
//      mapView.addOverlay(MKPolygon(coordinates: park.boundary, count: park.boundary.count))
//    }
//
//    func addCharacterLocation() {
//      mapView.addOverlay(Character(filename: "BatmanLocations", color: .blue))
//      mapView.addOverlay(Character(filename: "TazLocations", color: .orange))
//      mapView.addOverlay(Character(filename: "TweetyBirdLocations", color: .yellow))
//    }
//
//    func updateMapOverlayViews() {
//      mapView.removeAnnotations(mapView.annotations)
//      mapView.removeOverlays(mapView.overlays)
//
//      if mapBoundary { addBoundary() }
//      if mapOverlay { addOverlay() }
//      if mapPins { addAttractionPins() }
//      if mapCharacterLocation { addCharacterLocation() }
//      if mapRoute { addRoute() }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
