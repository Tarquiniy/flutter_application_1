import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../utils/location_utils.dart';

class MapWidget extends StatefulWidget {
  final List<Polygon> polygons;
  final Point? initialLocation;

  const MapWidget({super.key, required this.polygons, this.initialLocation});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late YandexMapController _mapController;
  bool _nightMode = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YandexMap(
          onMapCreated: (controller) async {
            _mapController = controller;
            await _mapController.toggleNightModez(enabled: _nightMode);
            if (widget.initialLocation != null) {
              await _mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: widget.initialLocation!, zoom: 15),
                ),
              );
            } else {
              //Запрашиваем текущую геопозицию пользователя если она есть
              final position = await LocationUtils.getCurrentPosition();
              if (position != null) {
                final point = LocationUtils.positionToPoint(position);
                await _mapController.moveCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: point, zoom: 15)));
              } else {
                //Если не удалось получить геопозицию, то задаем какую-то дефолтную позицию
                await _mapController.moveCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                        target: Point(latitude: 55.7558, longitude: 37.6173),
                        zoom: 10), // Москва
                  ),
                );
              }
            }
          },
          mapObjects: widget.polygons.isNotEmpty ? widget.polygons : [],
        ),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            icon: Icon(
              _nightMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () async {
              setState(() {
                _nightMode = !_nightMode;
              });
              await _mapController.toggleNightMode(enabled: _nightMode);
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
