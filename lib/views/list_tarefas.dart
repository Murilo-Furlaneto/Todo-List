import 'package:flutter/material.dart';

class ListTarefas extends StatefulWidget {
  const ListTarefas({Key? key}) : super(key: key);

  @override
  State<ListTarefas> createState() => _ListTarefasState();
}

class _ListTarefasState extends State<ListTarefas> {
  final TextEditingController taskController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _task = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: taskController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Insira a tarefa',
                        hintStyle: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Insira uma tarefa';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _task.add(taskController.text);
                            });
                            taskController.clear();
                          }
                        },
                        child: const Text('Adicionar')),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _task.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      tileColor: Colors.blue[100],
                      title: Text(_task[index]),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _task.remove(_task[index]);
                              taskController.clear();
                            });
                          }, icon: const Icon(Icons.delete)),
                    ),
                  );
                })),
          ),
        ]),
      ),
    );
  }
}
