import 'package:controller_emulator_client/configs/steering.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});
  static const routeName = "/config";

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  void handleGyroscopeRadioChange(SteeringState? value) {
    setState(() {
      if (value == null) {
        SteeringConfiguration.steeringState = SteeringState.disabled;
      }
      SteeringConfiguration.steeringState = value!;
    });
  }

  void handleGyroscopeAxisRadioChange(SteeringAxis? value) {
    setState(() {
      if (value == null) {
        SteeringConfiguration.steeringAxis = SteeringAxis.x;
      }
      SteeringConfiguration.steeringAxis = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Colors.black38,
        title: const Text(
          "XC Mobi",
          style: TextStyle(color: Colors.white70),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/connection");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: ListView(
          children: [
            const Text(
              "Gyroscope",
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
            ListTile(
                title: const Text('Disabled',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Radio<SteeringState>(
                  value: SteeringState.disabled,
                  groupValue: SteeringConfiguration.steeringState,
                  onChanged: handleGyroscopeRadioChange,
                )),
            ListTile(
                title: const Text('Left Stick',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Radio<SteeringState>(
                  value: SteeringState.leftStick,
                  groupValue: SteeringConfiguration.steeringState,
                  onChanged: handleGyroscopeRadioChange,
                )),
            ListTile(
                title: const Text('Right Stick',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Radio<SteeringState>(
                  value: SteeringState.rightStick,
                  groupValue: SteeringConfiguration.steeringState,
                  onChanged: handleGyroscopeRadioChange,
                )),
            const Text(
              "Gyroscope Axis",
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
            ListTile(
                title: const Text('X Axis',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Radio<SteeringAxis>(
                  value: SteeringAxis.x,
                  groupValue: SteeringConfiguration.steeringAxis,
                  onChanged: handleGyroscopeAxisRadioChange,
                )),
            ListTile(
                title: const Text('Y Axis',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Radio<SteeringAxis>(
                  value: SteeringAxis.y,
                  groupValue: SteeringConfiguration.steeringAxis,
                  onChanged: handleGyroscopeAxisRadioChange,
                )),
            ListTile(
                title: const Text('Both Axis',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                leading: Radio<SteeringAxis>(
                  value: SteeringAxis.both,
                  groupValue: SteeringConfiguration.steeringAxis,
                  onChanged: handleGyroscopeAxisRadioChange,
                )),
          ],
        ),
      ),
    );
  }
}
