import '../imports.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                final f = context.read<PersonBloc>().add(LoadPersonAction(url: PersonUrl.person1));
              },
              child: const Text('Load json 1'),
            ),
            TextButton(
              onPressed: () {
                final f = context.read<PersonBloc>().add(LoadPersonAction(url: PersonUrl.person2));
              },
              child: const Text('Load json 2'),
            ),
            BlocBuilder<PersonBloc, FetchResult?>(
              buildWhen: (previousResult, currentResult) {
                return previousResult?.persons != currentResult?.persons;
              },
              builder: (context, fatchResult) {
                var persons = fatchResult?.persons;
                if (persons == null) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: persons.length,
                        itemBuilder: (context, index) {
                          // ! using extension subscription on iterable
                          final person = persons[index]!;
                          return ListTile(
                            title: Text(
                              person.name,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );

                return Container();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
