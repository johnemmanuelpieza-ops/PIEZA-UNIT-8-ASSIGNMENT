
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:org_fair/config.dart';
import 'package:org_fair/data/event_repository.dart';
import 'package:org_fair/data/orgs.dart';
import 'package:org_fair/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    // A fake HTTP client so the test never touches a real CMS.
    final client = MockClient((request) async => http.Response('[]', 200));

    await tester.pumpWidget(
      OrgFairApp(
        repository: OrgRepository(delay: Duration.zero),
        events: EventRepository(createEventSource(client)),
      ),
    );

    // Allow pending asynchronous operations to finish.
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
