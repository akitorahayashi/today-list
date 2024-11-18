import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// stateless dialog
abstract class TLBaseStatelessDialog extends ConsumerWidget {
  const TLBaseStatelessDialog({super.key});

  Future<void> show({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }
}

// stateful dialog
abstract class TLBaseStatefulDialog extends ConsumerStatefulWidget {
  const TLBaseStatefulDialog({super.key});

  Future<void> show({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }
}
