import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PickLocation extends StatefulWidget{
  const PickLocation({required this.onPickLocation , super.key});
  final Function (Location ) onPickLocation;
  @override
  State<PickLocation> createState() {
    return _PickLocationState();
  }
}
class _PickLocationState extends State<PickLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}