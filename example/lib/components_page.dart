import 'package:flutter/material.dart';
import 'package:flutter_easy/flutter_easy.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ComponentsPage());
  }

  @override
  ComponentsPageState createState() => ComponentsPageState();
}

class ComponentsPageState extends State<ComponentsPage>
    with DialogMixin, ToastMixin {
  Axis axis = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Components'),
      ),
      body: ColoredBox(
        color: Colors.white,
        child: ListView(
          children: [
            Text('Dialog & Toast', style: const TextStyle().s34.black.w700),
            TextButton(
              onPressed: () {
                showMessageDialog(
                  context,
                  title: 'Message Dialog',
                  message: 'This is a simple message dialog',
                  onConfirm: () {
                    toastText(context, 'this is a text toast');
                  },
                );
              },
              child: const Text('show message dialog'),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    showComplexDialog(
                      context,
                      icon: const Icon(Icons.ac_unit, size: 30),
                      title: 'Complex dialog',
                      message: Text(
                        'This is a complex dialog, tap `ok` to show success toast',
                        style: const TextStyle().red,
                      ),
                      onConfirm: () {
                        toastSuccess(context,
                            message: 'this is a success toast');
                      },
                      optionsAxis: axis,
                    );
                  },
                  child: const Text('show complex dialog'),
                ),
                Switch(
                    value: axis == Axis.horizontal,
                    onChanged: (value) {
                      setState(() {
                        axis = axis == Axis.horizontal
                            ? Axis.vertical
                            : Axis.horizontal;
                      });
                    }),
                Text(axis.name),
                const Spacer(),
              ],
            ),
            TextButton(
              onPressed: () {
                showColumnDialog(
                  context,
                  title: 'Column Dialog',
                  message: 'this is a column dialog',
                  options: [
                    DialogOption.normal(
                      title: 'this is a normal row',
                      onPressed: () {
                        toastSuccess(context, message: 'normal pressed');
                      },
                    ),
                    DialogOption.destructive(
                      title: 'this is a destructive row',
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        toastFailed(context, message: 'destructive pressed');
                      },
                    ),
                    DialogOption.cancel(),
                  ],
                );
              },
              child: const Text('show column dialog'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(DialogPage.route(
                  icon: const Icon(Icons.accessible_outlined),
                  title: 'Dialog Page',
                  message: const Text('This is a dialog page'),
                ));
              },
              child: const Text('show dialog page'),
            ),
            const Text('========================================='),
            Text('Modal Route', style: const TextStyle().s34.black.w700),
            TextButton(
              onPressed: () {
                showModalRoute(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      appBar: ModalAppBar(
                        leading: EasyBackButton.cancel(),
                        title: const Text('Modal Route'),
                        leadingWidth: 120,
                      ),
                      body: const Center(child: Text('Modal Route')),
                    );
                  },
                );
              },
              child: const Text('show modal route'),
            ),
            const Text('========================================='),
            Text('TextField', style: const TextStyle().s34.black.w700),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: UnderlinedTextField(prefix: Icon(Icons.place)),
            ),
          ],
        ),
      ),
    );
  }
}
