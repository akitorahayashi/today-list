import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// stateless dialog
abstract class TLBaseConsumerDialog extends ConsumerWidget {
  const TLBaseConsumerDialog({super.key});

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
abstract class TLBaseConsumerStatefulDialog extends ConsumerStatefulWidget {
  const TLBaseConsumerStatefulDialog({super.key});

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
