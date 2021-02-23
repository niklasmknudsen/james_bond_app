import 'dart:ui';
//import 'package:agent_list/agent.dart';
//import 'agent.dart';
import 'package:agent_list/agent.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'stateController.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Agents());
}

class Agents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DisplayAgents(),
    );
  }
}

class DisplayAgents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Agent 007"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: agentList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: new Image.asset(agentList[index].imageName,
                  width: 50, height: 50),
              title: Text(agentList[index].name),
              subtitle: Text(agentList[index].activePeriod),
              onTap: () {
                final agent = agentList[index];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayAgent(agent: agent)));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add_box),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateAgent()));
        },
      ),
    );
  }
}

class DisplayAgent extends StatelessWidget {
  final Agent agent;
  const DisplayAgent({this.agent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Image.asset(this.agent.imageName, height: 250),
            ListTile(
              title: new Center(child: (Text(this.agent.name))),
              subtitle: new Center(
                  child: Text('Active periode: ' + this.agent.activePeriod)),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.navigate_before),
      ),
    );
  }
}

class CreateAgent extends StatefulWidget {
  final Agent agent;

  const CreateAgent({Key key, this.agent}) : super(key: key);

  @override
  _AgentState createState() {
    return _AgentState(this.agent);
  }
}

class _AgentState extends State<CreateAgent> {
  final _formkey = GlobalKey<FormState>();
  final Agent _agent;
  String currentDate = DateTime.now().toString();

  _AgentState(this._agent);

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(title: new Text("Tilføj Agent")),
      body: (Container(
          margin: new EdgeInsets.all(15.0),
          child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (val) => setState(() {
                      _agent.name = val;
                    }),
                  ),
                  DateTimePicker(
                    initialValue: currentDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => _agent.activePeriod = val,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      final form = _formkey.currentState;
                      if (form.validate()) {
                        form.save();
                        Agent agent = new Agent(
                            name: _agent.name,
                            imageName: null,
                            activePeriod: _agent.activePeriod);
                        print(agent);
                        agentList.add(agent);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Opretter agent')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              )))),
    );
  }
}
