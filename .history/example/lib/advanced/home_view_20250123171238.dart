import 'dart:async';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter_background_geolocation_example/view/model/ElectricModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_background_geolocation_example/advanced/util/dialog.dart'
    as util;
import 'geofence_view.dart';
import 'package:latlong2/latlong.dart';
import 'util/geospatial.dart';

class HomeView extends StatefulWidget {
  final List data;
  final LatLng position;
  const HomeView({super.key, required this.data, required this.position});
  @override
  State createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  static const LOCATION_ARROW_IMAGE_PATH =
      "assets/images/markers/location-arrow-blue.png";
  List<LatLng> list = [];

@override
void didUpdateWidget(HomeView oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (!ListEquality().equals(widget.data, oldWidget.data)) {
    getLocation(widget.data);
  }
  if (widget.position != oldWidget.position) { 
    _moveToPoint(widget.position);
  }
}


Future<void> getLocation(List data) async {
  List<ElectricVehicle> vehicles = data.map((location) {
    return ElectricVehicle.fromJson(location);
  }).toList();

  setState(() {
    _polygonGeofenceCursorMarkers = vehicles.map((vehicle) {
      LatLng point = LatLng(
          double.parse(vehicle.latitude), double.parse(vehicle.longitude));
      bool isTapped = false; // Trạng thái kiểm soát màu icon

      return Marker(
        width: 120.0, // Tăng chiều rộng của vùng touch
        height: 90.0, // Tăng chiều cao của vùng touch
        point: point,
        builder: (ctx) {
          return GestureDetector(
            onTap: () {
              setState(() {
                isTapped = true; // Đổi trạng thái sang nhấn
              });

              // Tạo hiệu ứng tạm thời sau 500ms đổi lại màu cũ
              Future.delayed(const Duration(milliseconds: 1500), () {
                setState(() {
                  isTapped = false; // Đổi lại trạng thái ban đầu
                });
              });

              _showMarkerDialog(context, vehicle);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_gas_station,
                    color: isTapped
                        ? Colors.red // Đổi sang màu đỏ khi nhấn
                        : Colors.black, // Màu mặc định
                    size: 40.0, // Tăng kích thước icon
                  ),
                  const SizedBox(height: 5.0), // Khoảng cách giữa icon và text
                  Text(
                    vehicle.name,
                    style: const TextStyle(
                      fontSize: 14.0, // Tăng kích thước chữ
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).toList();

    _moveToFirstPoint(vehicles.map((vehicle) {
      return LatLng(
          double.parse(vehicle.latitude), double.parse(vehicle.longitude));
    }).toList());
  });
}




void _showMarkerDialog(BuildContext context, ElectricVehicle vehicle) {
  String status = vehicle.isBusy == null
      ? "Không xác định"
      : (vehicle.isBusy == true ? "Bận" : "Rảnh");
  bool isBusy = vehicle.isBusy ?? false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Bo góc cho hộp thoại
        ),
        title: Row(
          children: [
            Icon(
              Icons.local_gas_station,
              color: isBusy ? Colors.red : Colors.green,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                vehicle.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Quận: ${vehicle.district}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: isBusy ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Trạng thái: $status",
                    style: TextStyle(
                      fontSize: 16,
                      color: isBusy ? Colors.red : Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: isBusy
                ? null
                : () {
                    print("Đăng ký");
                    Navigator.of(context).pop();
                  },
            style: TextButton.styleFrom(
              foregroundColor: isBusy ? Colors.grey : Colors.white,
              backgroundColor: isBusy ? Colors.grey[300] : Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text("Đăng ký"),
          ),
          TextButton(
            onPressed: () {
       
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>),
            );
              
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text("Xem"),
          ),
        ],
      );
    },
  );
}


  void _moveToFirstPoint(List<LatLng> points) {
    if (points.isNotEmpty) {
      LatLng firstPoint = points.first;
      _mapController.move(firstPoint, 18);
    }
  }

  void _moveToPoint(LatLng points) {
    if (points != LatLng(0,0)) {
      LatLng firstPoint = points;
      _mapController.move(firstPoint, 18);
    }
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  bg.Location? _stationaryLocation;
  bg.Location? _lastLocation;

  LatLng _currentPosition = LatLng(45.508888, -73.561668);
  List<LatLng> _polyline = [];
  List<Marker> _locations = [];
  List<CircleMarker> _stopLocations = [];
  List<Polyline> _motionChangePolylines = [];
  List<CircleMarker> _stationaryMarker = [];

  List<GeofenceMarker> _geofences = [];
  List<Polygon> _geofencePolygons = [];
  List<GeofenceMarker> _geofenceEvents = [];
  List<Marker> _geofenceEventEdges = [];
  List<Marker> _geofenceEventLocations = [];
  List<Polyline> _geofenceEventPolylines = [];
  List<Marker> _polygonGeofenceCursorMarkers = [];
  List<LatLng> _polygonGeofenceCursorPoints = [];

  bool _isCreatingPolygonGeofence = false;
  OverlayEntry? _polygonGeofenceMenuOverlay = null;

  LatLng _center = LatLng(108.508888, 87.561668);

  late MapController _mapController;
  late MapOptions _mapOptions;

  @override
  void initState() {
    super.initState();
    _mapOptions = MapOptions(
        onPositionChanged: _onPositionChanged,
        center: _center,
        zoom: 12.0,
        onTap: _onTap,
        onLongPress: _onAddGeofence);
    _mapController = MapController();

    bg.BackgroundGeolocation.onLocation(_onLocation);
    bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    bg.BackgroundGeolocation.onGeofence(_onGeofence);
    bg.BackgroundGeolocation.onGeofencesChange(_onGeofencesChange);
    bg.BackgroundGeolocation.onEnabledChange(_onEnabledChange);
    getLocation(widget.data);
  }

  void _onEnabledChange(bool enabled) {
    if (!enabled) {
      setState(() {
        _locations.clear();
        _geofencePolygons.clear();
        _polyline.clear();
        _stopLocations.clear();
        _motionChangePolylines.clear();
        _stationaryMarker.clear();
        _geofenceEvents.clear();
        _geofenceEventPolylines.clear();
        _geofenceEventLocations.clear();
        _geofenceEventEdges.clear();
      });
    }
  }

  void _onMotionChange(bg.Location location) async {
    LatLng ll = LatLng(location.coords.latitude, location.coords.longitude);

    _updateCurrentPositionMarker(ll);

    _mapController.move(ll, 16);

    // clear the big red stationaryRadius circle.
    _stationaryMarker.clear();

    if (location.isMoving) {
      if (_stationaryLocation == null) {
        _stationaryLocation = location;
      }
      // Add previous stationaryLocation as a small red stop-circle.
      _stopLocations.add(_buildStopCircleMarker(_stationaryLocation!));
      // Create the green motionchange polyline to show where tracking engaged from.
      _motionChangePolylines
          .add(_buildMotionChangePolyline(_stationaryLocation!, location));
    } else {
      // Save a reference to the location where we became stationary.
      _stationaryLocation = location;
      // Add the big red stationaryRadius circle.
      bg.State state = await bg.BackgroundGeolocation.state;
      setState(() {
        _stationaryMarker.add(_buildStationaryCircleMarker(location, state));
      });
    }
  }

  void _onGeofence(bg.GeofenceEvent event) async {
    bg.Logger.info('[onGeofence] Flutter received onGeofence event $event');
    // Provide the location of this event to the Polyline.  BGGeo does not fire an onLocation for geofence events.
    _polyline.add(LatLng(
        event.location.coords.latitude, event.location.coords.longitude));
    GeofenceMarker? marker = _geofences.firstWhereOrNull(
        (GeofenceMarker marker) =>
            marker.geofence?.identifier == event.identifier);
    if (marker == null) {
      bool exists =
          await bg.BackgroundGeolocation.geofenceExists(event.identifier);
      if (exists) {
        // Maybe this is a boot from a geofence event and geofencechange hasn't yet fired
        bg.Geofence? geofence =
            await bg.BackgroundGeolocation.getGeofence(event.identifier);
        marker = GeofenceMarker(geofence!);
        _geofences.add(marker);
      } else {
        print(
            "[_onGeofence] failed to find geofence marker: ${event.identifier}");
        return;
      }
    }

    bg.Geofence? geofence = marker.geofence;

    // Render a new greyed-out geofence CircleMarker to show it's been fired but only if it hasn't been drawn yet.
    // since we can have multiple hits on the same geofence.  No point re-drawing the same hit circle twice.
    GeofenceMarker? eventMarker = _geofenceEvents.firstWhereOrNull(
        (GeofenceMarker marker) =>
            marker.geofence?.identifier == event.identifier);
    if (eventMarker == null)
      _geofenceEvents.add(GeofenceMarker(geofence!, true));

    // Build geofence hit statistic markers:
    // 1.  A computed CircleMarker upon the edge of the geofence circle (red=exit, green=enter)
    // 2.  A CircleMarker for the actual location of the geofence event.
    // 3.  A black PolyLine joining the two above.
    bg.Location location = event.location;
    LatLng center = LatLng(geofence!.latitude!, geofence!.longitude!);
    LatLng hit = LatLng(location.coords.latitude, location.coords.longitude);

    // Update current position marker.
    _updateCurrentPositionMarker(hit);
    // Determine bearing from center -> event location
    double bearing = Geospatial.getBearing(center, hit);
    // Compute a coordinate at the intersection of the line joining center point -> event location and the circle.
    LatLng edge =
        Geospatial.computeOffsetCoordinate(center, geofence.radius!, bearing);
    // Green for ENTER, Red for EXIT.
    Color color = Colors.green;
    var colorName = 'green';
    if (event.action == "EXIT") {
      color = Colors.red;
      colorName = 'red';
    } else if (event.action == "DWELL") {
      color = Colors.yellow;
      colorName = 'amber';
    }
    // Colored circular image marker (red/amber/green) on geofence edge.
    _geofenceEventEdges.add(Marker(
        point: edge,
        width: 16,
        height: 16,
        rotate: false,
        builder: (context) {
          return Image.asset(
              "assets/images/markers/geofence-event-edge-circle-${event.action.toLowerCase()}.png");
        }));

    // Colored event location-arrow Marker (red/amber/green)
    double heading = location.coords.heading.round().toDouble();
    _geofenceEventLocations.add(Marker(
        point: hit,
        width: 24,
        height: 24,
        rotate: false,
        builder: (context) {
          return Transform.rotate(
              angle: (heading * (math.pi / 180)),
              child: Image.asset(
                  "assets/images/markers/location-arrow-${colorName}.png"));
        }));
    // Polyline joining the two above.
    _geofenceEventPolylines.add(
        Polyline(points: [edge, hit], strokeWidth: 2.0, color: Colors.black));
  }

  bool hasGeofenceMarker(String identifier) {
    return _geofences.firstWhereOrNull((GeofenceMarker marker) =>
            marker.geofence?.identifier == identifier) !=
        null;
  }

  void _onGeofencesChange(bg.GeofencesChangeEvent event) {
    print('[${bg.Event.GEOFENCESCHANGE}] - $event');
    setState(() {
      event.off.forEach((String identifier) {
        _geofences.removeWhere((GeofenceMarker marker) {
          return marker.geofence?.identifier == identifier;
        });
      });

      event.on.forEach((bg.Geofence geofence) {
        // Don't re-render markers for existing geofences.
        if (hasGeofenceMarker(geofence.identifier)) return;
        _geofences.add(GeofenceMarker(geofence));

        if (geofence.vertices!.isNotEmpty) {
          _geofencePolygons.add(Polygon(
              borderColor: Colors.blue,
              borderStrokeWidth: 5.0,
              isDotted: true,
              label: geofence.identifier,
              labelStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              color: Colors.blue.withOpacity(0.2),
              isFilled: true,
              points: geofence.vertices!.map((vertex) {
                return LatLng(vertex[0], vertex[1]);
              }).toList()));
        }
      });

      if (event.off.isEmpty && event.on.isEmpty) {
        _geofences.clear();
        _geofencePolygons.clear();
      }
    });
  }

  void _onLocation(bg.Location location) {
    _lastLocation = location;
    LatLng ll = LatLng(location.coords.latitude, location.coords.longitude);

    _mapController.move(ll, _mapController.zoom);

    _updateCurrentPositionMarker(ll);

    if (location.sample) {
      return;
    }

    // Add a point to the tracking polyline.
    _polyline.add(ll);
    // Add a marker for the recorded location.
    //_locations.add(_buildLocationMarker(location));
    //_locations.add(CircleMarker(point: ll, color: Colors.black, radius: 5.0));
    //_locations.add(CircleMarker(point: ll, color: Colors.blue, radius: 4.0));

    double heading = (location.coords.heading >= 0)
        ? location.coords.heading.round().toDouble()
        : 0;
    _locations.add(Marker(
        point: ll,
        width: 16,
        height: 16,
        rotate: false,
        builder: (context) {
          return Transform.rotate(
              angle: (heading * (math.pi / 180)),
              child: Image.asset(LOCATION_ARROW_IMAGE_PATH));
        }));
  }

  /// Update Big Blue current position dot.
  void _updateCurrentPositionMarker(LatLng ll) {
    setState(() {
      _currentPosition = ll;
    });
    /*
    // White background
    _currentPosition
        .add(CircleMarker(point: ll, color: Colors.white, radius: 10));
    // Blue foreground
    _currentPosition
        .add(CircleMarker(point: ll, color: Colors.blue, radius: 7));

   */
  }

  CircleMarker _buildStationaryCircleMarker(
      bg.Location location, bg.State state) {
    return CircleMarker(
        point: LatLng(location.coords.latitude, location.coords.longitude),
        color: Color.fromRGBO(255, 0, 0, 0.5),
        useRadiusInMeter: true,
        radius: (state.trackingMode == 1)
            ? 200
            : (state.geofenceProximityRadius! / 2));
  }

  Polyline _buildMotionChangePolyline(bg.Location from, bg.Location to) {
    return Polyline(points: [
      LatLng(from.coords.latitude, from.coords.longitude),
      LatLng(to.coords.latitude, to.coords.longitude)
    ], strokeWidth: 10.0, color: Color.fromRGBO(22, 190, 66, 0.7));
  }

  CircleMarker _buildStopCircleMarker(bg.Location location) {
    return CircleMarker(
        point: LatLng(location.coords.latitude, location.coords.longitude),
        color: Color.fromRGBO(200, 0, 0, 0.3),
        useRadiusInMeter: false,
        radius: 20);
  }

  void _onTap(pos, latLng) {
    if (!_isCreatingPolygonGeofence) return;
    bg.BackgroundGeolocation.playSound(
        util.Dialog.getSoundId("TEST_MODE_CLICK"));
    HapticFeedback.heavyImpact();
    int index = _polygonGeofenceCursorMarkers.length + 1;
    setState(() {
      _polygonGeofenceCursorPoints.add(latLng);
      _polygonGeofenceCursorMarkers.add(Marker(
          point: latLng,
          width: 20,
          height: 20,
          rotate: false,
          builder: (context) {
            return Container(
                child: Text("$index", style: TextStyle(color: Colors.white)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    //border: Border.all(width: 2, color: Colors.white),
                    shape: BoxShape.circle,
                    color: Colors.black));
          }));
    });
  }

  void _onAddGeofence(pos, latLng) {
    if (_isCreatingPolygonGeofence) return;
    bg.BackgroundGeolocation.playSound(
        util.Dialog.getSoundId("LONG_PRESS_ACTIVATE"));
    HapticFeedback.heavyImpact();
    print("[_onAddGgeofence] latLng: $latLng");

    showAdaptiveActionSheet(
      context: context,
      title: const Text('Add Geofence'),
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text('Circular'),
            onPressed: (context) {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute<Null>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return GeofenceView(center: latLng);
                  }));
            }),
        BottomSheetAction(
            title: const Text('Polygon'),
            onPressed: (context) {
              setState(() {
                _isCreatingPolygonGeofence = true;
              });
              _showPolygonGeofenceMenu();
              Navigator.of(context).pop();
            })
      ],
      cancelAction: CancelAction(
          title: const Text('Cancel'),
          onPressed: (context) {
            Navigator.of(context).pop();
            _cancelAddGeofence();
          }), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
    /*
    Navigator.of(context).push(MaterialPageRoute<Null>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return GeofenceView(latLng);
        }));

     */
  }

  void _showPolygonGeofenceMenu() {
    OverlayState overlayState = Overlay.of(context);
    if (_polygonGeofenceMenuOverlay == null) {
      _polygonGeofenceMenuOverlay = OverlayEntry(builder: (context) {
        return Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    border: Border(bottom: BorderSide(color: Colors.black))),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                            child: Text("Cancel",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.red,
                            onPressed: _cancelAddGeofence),

                        //Text("Tap map to add points", style: TextStyle(fontWeight: FontWeight.bold)),
                        MaterialButton(
                            child: Text("Next",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.blue,
                            onPressed: () {
                              var vertices = _polygonGeofenceCursorMarkers
                                  .map((Marker marker) {
                                return marker.point;
                              }).toList();
                              _cancelAddGeofence();
                              Navigator.of(context)
                                  .push(MaterialPageRoute<Null>(
                                      fullscreenDialog: true,
                                      builder: (BuildContext context) {
                                        return GeofenceView(vertices: vertices);
                                      }));
                            })
                      ]),
                  Row(children: [
                    MaterialButton(
                        child: Icon(Icons.undo),
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          if (_polygonGeofenceCursorPoints.isEmpty) return;
                          setState(() {
                            _polygonGeofenceCursorPoints.removeLast();
                            _polygonGeofenceCursorMarkers.removeLast();
                          });
                        }),
                    Text("Click map to add polygon points",
                        style: TextStyle(
                            fontFamily: "sans-serif",
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 12))
                  ])
                ])));
      });
    }
    overlayState.insert(_polygonGeofenceMenuOverlay!);
  }

  void _cancelAddGeofence() {
    HapticFeedback.heavyImpact();
    if (_polygonGeofenceMenuOverlay != null) {
      _polygonGeofenceMenuOverlay?.remove();
    }
    setState(() {
      _polygonGeofenceCursorMarkers.clear();
      _polygonGeofenceCursorPoints.clear();
      _isCreatingPolygonGeofence = false;
    });
  }

  void _onPositionChanged(MapPosition pos, bool hasGesture) {
    _mapOptions.crs.scale(_mapController.zoom);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            mapController: _mapController,
            options: _mapOptions,
            children: [
              // Lớp bản đồ nền
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              // Lớp Marker hiển thị các điểm tọa độ
              MarkerLayer(
                markers: _polygonGeofenceCursorMarkers,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GeofenceMarker extends CircleMarker {
  bg.Geofence? geofence;
  GeofenceMarker(bg.Geofence geofence, [bool triggered = false])
      : super(
            useRadiusInMeter: true,
            radius: geofence.radius!,
            color: (triggered)
                ? Colors.transparent
                : Colors.green.withOpacity(0.3),
            borderColor: Colors.green,
            borderStrokeWidth: 1,
            point: LatLng(geofence.latitude!, geofence.longitude!)) {
    this.geofence = geofence;
  }
}
