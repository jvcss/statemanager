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
                context.read<PersonBloc>().add(const LoadPersonAction(url: PersonUrl.person1));
              },
              child: const Text('Load json 1'),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonBloc>().add(const LoadPersonAction(url: PersonUrl.person2));
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
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        // ! using extension subscription on iterable
                        final person = persons[index]?.name;
                        return ListTile(
                          title: Text(
                            person??'NO NAME',
                          ),
                        );
                      },
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
